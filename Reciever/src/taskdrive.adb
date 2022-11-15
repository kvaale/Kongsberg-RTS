with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body taskDrive is
   task body Drive is
      yVal : Integer := 512; --between 0 and 1023
      xVal : Integer := 512;
      L : Integer := 512;
      R : Integer := 512;
      Forward : Boolean := True; -- forward is true, backward is false
      Mode : UInt8;
      myClock : Time;
   begin
      Set_Analog_Period_Us(20000); -- 50 Hz = 1/50 = 0.02s = 20 ms = 20000us
      loop
         myClock := Clock;

         yVal := Integer((Obj.Get(1)));  -- yVal = Speed
         xVal := Integer((Obj.Get(2)));  -- xVal = Turn
         Mode := Obj.Get(4);

         --  Put(" Mode: " & UInt8'Image(Mode));
         --  Put(" yVal: " & Integer'Image(yVal));
         --  Put_Line(" xVal: " & Integer'Image(xVal));

         if Mode < 1 then

            yVal := 4*yVal;
            xVal := 4*xVal;

            L := yVal * ((1024-xVal)/512);
            R := yVal * xVal/512;


            if Obj.Get(3) = 1 then
               Forward := True;
            else
               Forward := False;
            end if;

            if L > 1023 then
               L := 1013;
            end if;

            if R > 1023 then
               R := 1023;
            end if;

            --LEFT
            --front
            Set(6, Forward); --IN1
            Set(7, not Forward); --IN2

            --back
            Set(2, Forward); --IN3
            Set(3, not Forward); --IN4

            --RIGHT
            --front
            Set(12, Forward); --IN1
            Set(13, not Forward); --IN2

            --back
            Set(14, Forward); --IN3
            Set(15, not Forward); --IN4

            Write (0, Analog_Value(L)); --left speed control ENA ENB
            Write (1, Analog_Value(R)); --right speed control ENA ENB

         else
            --  if (xVal < 150 and xVal > 100 and yVal < 150 and yVal > 100) then
            --     MotorDriver.SetDirection (Stop);
            --  elsif (xVal < 150 and xVal > 100 and yVal < 256 and yVal > 200) then
            --     MotorDriver.SetDirection (Right);
            --  elsif (xVal < 256 and xVal > 200 and yVal < 150 and yVal > 100) then
            --     MotorDriver.SetDirection (Straight);
            --  elsif (xVal < 100 and xVal >= 0 and yVal < 150 and yVal > 100) then
            --     MotorDriver.SetDirection (Backward);
            --  elsif (xVal < 150 and xVal > 100 and yVal < 100 and yVal >= 0) then
            --     MotorDriver.SetDirection (Left);
            --  end if;

            if (yVal < 150 and yVal > 100 and xVal < 150 and xVal > 100) then
               MotorDriver.SetDirection (Stop);
            elsif (yVal < 150 and yVal > 100 and xVal < 256 and xVal > 200) then
               MotorDriver.SetDirection (Right);
            elsif (yVal < 256 and yVal > 200 and xVal < 150 and xVal > 100) then
               MotorDriver.SetDirection (Straight);
            elsif (yVal < 100 and yVal >= 0 and xVal < 150 and xVal > 100) then
               MotorDriver.SetDirection (Backward);
            elsif (yVal < 150 and yVal > 100 and xVal < 100 and xVal >= 0) then
               MotorDriver.SetDirection (Left);
            end if;

            DriveUni(MotorDriver.GetDirection);
         end if;

         --  Put_Line("THIS IS THE TOO CLOSE INT" & Integer'Image(tooClose));
         --  if (tooClose <= 10) then
         --     MotorDriver.SetDirection (Rotate_Right);
         --  end if;


         --  Put("Speed is: " & Integer'Image(Speed));
         --  Put_Line(" Turn is: " & Integer'Image(Turn));
         --  Put("L: " & Integer'Image(L));
         --  Put_Line(" R: " & Integer'Image(R));

         --  --LEFT
         --  --front
         --  Set(6, Forward); --IN1
         --  Set(7, not Forward); --IN2
         --
         --  --back
         --  Set(2, Forward); --IN3
         --  Set(3, not Forward); --IN4
         --
         --  --RIGHT
         --  --front
         --  Set(12, Forward); --IN1
         --  Set(13, not Forward); --IN2
         --
         --  --back
         --  Set(14, Forward); --IN3
         --  Set(15, not Forward); --IN4
         --
         --  Write (0, Analog_Value(L)); --left speed control ENA ENB
         --  Write (1, Analog_Value(R)); --right speed control ENA ENB

         delay until myClock + Milliseconds(200);
      end loop;
   end Drive;

   procedure DriveUni (V : Directions) is
      Dir : Directions := V;

      Speed : constant Analog_Value := 512;--between 0 and 1023
      Forward : constant Boolean := True; -- forward is true, backward is false
   begin
      Set_Analog_Period_Us(20000);

      Write (0, Speed); --left speed control ENA ENB
      Write (1, Speed); --right speed control ENA ENB
      if (Dir = Stop) then
         Write (0, 0); --left speed control ENA ENB
         Write (1, 0); --right speed control ENA ENB -- STOP
      elsif (Dir = Right) then
         -- GO RIGHT
         --LEFT
         --front
         Set(6, not Forward); --IN1
         Set(7, Forward); --IN2

         --back
         Set(2, Forward); --IN3
         Set(3, not Forward); --IN4

         --RIGHT
         --front
         Set(12, Forward); --IN1
         Set(13, not Forward); --IN2

         --back
         Set(14, not Forward); --IN3
         Set(15, Forward); --IN4

         Write (0, Speed); --left speed control ENA ENB
         Write (1, Speed); --right speed control ENA ENB
      elsif (Dir = Straight) then
         -- GO FORWARD
         --LEFT
         --front
         Set(6, Forward); --IN1
         Set(7, not Forward); --IN2

         --back
         Set(2, Forward); --IN3
         Set(3, not Forward); --IN4

         --RIGHT
         --front
         Set(12, Forward); --IN1
         Set(13, not Forward); --IN2

         --back
         Set(14, Forward); --IN3
         Set(15, not Forward); --IN4

         Write (0, Speed); --left speed control ENA ENB
         Write (1, Speed); --right speed control ENA ENB
      elsif (Dir = Backward) then
         -- GO BACKWARDS
         --LEFT
         --front
         Set(6, not Forward); --IN1
         Set(7, Forward); --IN2

         --back
         Set(2, not Forward); --IN3
         Set(3, Forward); --IN4

         --RIGHT
         --front
         Set(12, not Forward); --IN1
         Set(13, Forward); --IN2

         --back
         Set(14, not Forward); --IN3
         Set(15, Forward); --IN4

         Write (0, Speed); --left speed control ENA ENB
         Write (1, Speed); --right speed control ENA ENB

      elsif (Dir = Left) then
         -- GO LEFT
         --LEFT
         --front
         Set(6, Forward); --IN1
         Set(7, not Forward); --IN2

         --back
         Set(2, not Forward); --IN3
         Set(3, Forward); --IN4

         --RIGHT
         --front
         Set(12, not Forward); --IN1
         Set(13, Forward); --IN2

         --back
         Set(14, Forward); --IN3
         Set(15, not Forward); --IN4

         Write (0, Speed); --left speed control ENA ENB
         Write (1, Speed); --right speed control ENA ENB

      elsif (Dir = Rotate_Right) then

         -- ROTATE RIGHT
         --LEFT
         --front
         Set(6, Forward); --IN1
         Set(7, not Forward); --IN2

         --back
         Set(2, Forward); --IN3
         Set(3, not Forward); --IN4

         --RIGHT
         --front
         Set(12, not Forward); --IN1
         Set(13, Forward); --IN2

         --back
         Set(14, not Forward); --IN3
         Set(15, Forward); --IN4

         Write (1, Speed); --left speed control ENA ENB
         Write (0, Speed); --right speed control ENA ENB

      elsif (Dir = Rotate_Left) then
         -- ROTATE RIGHT
         --LEFT
         --front
         Set(6, not Forward); --IN1
         Set(7, Forward); --IN2

         --back
         Set(2, not Forward); --IN3
         Set(3, Forward); --IN4

         --RIGHT
         --front
         Set(12, Forward); --IN1
         Set(13, not Forward); --IN2

         --back
         Set(14, Forward); --IN3
         Set(15, not Forward); --IN4

         Write (1, Speed); --left speed control ENA ENB
         Write (0, Speed); --right speed control ENA ENB

      end if;
   end driveUni;


end taskDrive;
