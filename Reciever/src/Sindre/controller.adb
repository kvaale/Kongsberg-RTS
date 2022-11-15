with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;
with SensorData;
with Ultrasonic;

package body Controller is

   task body sense is
      myClock : Time;
      RXdata : Radio.RadioData;
      TxData : Radio.RadioData;
      Distance : Ultrasonic.Distance_cm := 0;
      
   begin
      TxData.Length := 10;
      TxData.Version:= 12;
      TxData.Group := 1;
      TxData.Protocol := 14;

      Radio.Setup(RadioFrequency => 2469,
                  Length => TxData.Length,
                  Version => TxData.Version,
                  Group => TxData.Group,
                  Protocol => TxData.Protocol);

      Radio.StartReceiving;
      Ultrasonic.Setup(19,11);
      loop
          
         myClock := Clock;
         
         Distance := UltraSonic.Read;
         
         SensorData.UltraSonicSensor.setDistance(Distance);
         Put_Line ("Read" & Ultrasonic.Distance_cm'Image(Distance));
      
         RXdata :=Radio.Receive;
         
         SensorData.Payload.setPayload(Integer(RXdata));
         
        -- SensorData.ControllerData.setXvalue(Integer(RXdata.Payload(1)));
        -- SensorData.ControllerData.setYvalue(Integer(RXdata.Payload(2)));
         
        -- SensorData.ButtonState.setButtonState(Integer(RXdata.Payload(4)));
            
      
         Put("Raven Received D1: " & Integer'Image(SensorData.ControllerData.getXvalue));
         Put_Line(" D2: " & Integer'Image(SensorData.ControllerData.getYvalue));
         Put_Line(" D3: " & Integer'Image(SensorData.ButtonState.getButtonState));

        
         
   delay until myClock + Milliseconds(100);
end loop;
end sense;

      task body think is
      myClock : Time;
      xVal : Integer;
      yVal : Integer;
      tooClose : Integer;
   begin
      loop
         myClock := Clock;
         
         Put_Line (" Thinking ");
         
         xVal := SensorData.Payload.getPayload(1);
         yVal := SensorData.Payload.getPayload(2);
         tooClose := Integer(SensorData.UltraSonicSensor.getDistance);
         
         --xVal := SensorData.ControllerData.getXvalue;
       --  yVal := SensorData.ControllerData.getYvalue;
        -- tooClose := Integer(SensorData.UltraSonicSensor.getDistance);
         
         if (xVal < 150 and xVal > 100 and yVal < 150 and yVal > 100) then
            MotorDriver.SetDirection (Stop);
         elsif (xVal < 150 and xVal > 100 and yVal < 256 and yVal > 200) then
            MotorDriver.SetDirection (Right);
         elsif (xVal < 256 and xVal > 200 and yVal < 150 and yVal > 100) then
            MotorDriver.SetDirection (Straight);
         elsif (xVal < 100 and xVal >= 0 and yVal < 150 and yVal > 100) then
            MotorDriver.SetDirection (Backward);
         elsif (xVal < 150 and xVal > 100 and yVal < 100 and yVal >= 0) then
            MotorDriver.SetDirection (Left);
         end if;
         
         Put_Line("THIS IS THE TOO CLOSE INT" & Integer'Image(tooClose));
         if (tooClose <= 10) then
            MotorDriver.SetDirection (Rotate_Right);
         end if;
         
         -- Frem 256 og 127
         -- Bak 0 og 127
         -- Venstre 127 og 0
         -- Høyre 128 og 256
         -- skrått til venstre 253 og 0, 0 253
         -- skrått til høyre 253 og 253, 0, 0
        
            
         
         delay (0.05); --simulate 50 ms execution time
         
         delay until myClock + Milliseconds(200);
      end loop;
   end think;
   
   task body act is
      
      
      myClock : Time;
   begin
      
      loop
         myClock := Clock;
         
         Put_Line("Acting");
         
         DriveUni (Motordriver.GetDirection);
         
         Put_Line ("Direction is: " & Directions'Image (MotorDriver.GetDirection));
         
         delay until myClock + Milliseconds(200);
      end loop;
   end act;
   
    protected body MotorDriver is
      --  procedures can modify the data
      procedure SetDirection (V : Directions) is
      begin
         DriveDirection := V;
      end SetDirection;

      --  functions cannot modify the data
      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;
      
   end MotorDriver;
   
 
   
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
   
   procedure Drive ( P1 : Integer; P2 : Integer; P3 : Integer) is 
      Speed : Integer := 512; --between 0 and 1023
      Turn : Integer := 512;
      L : Integer := 512;
      R : Integer := 512;
      Forward : Boolean := True; -- forward is true, backward is false
   begin
      Set_Analog_Period_Us(20000);
      loop
         Speed := 4*Integer((SensorData.ControllerData.getXvalue));
         Turn := 4*Integer((SensorData.ControllerData.getYvalue));

         L := Speed * ((1024-Turn)/512);
         R := Speed * Turn/512;
       

       --  if Obj.Get.Payload(3) = 1 then
      --      Forward := True;
      --   else
      --      Forward := False;
     --    end if;

         if L > 1023 then
            L := 1013;
         end if;

         if R > 1023 then
            R := 1023;
         end if;

         Put("L: " & Integer'Image(L));
         Put_Line(" R: " & Integer'Image(R));

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

         
      end loop;
   end Drive;
end Controller;
