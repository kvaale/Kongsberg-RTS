with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;


package body taskRecieve is
   protected body Obj is
      procedure Set (Var : Radio.RadioData) is
      begin
         RxData := Var;
      end Set;
      function Get return Radio.RadioData is
      begin
         return RxData;
      end Get;
   end Obj;
   task body Recieve is
      myClock : Time;
      RxData : Radio.RadioData;
      TxData : Radio.RadioData;
   begin
         TxData.Length := 5;
         TxData.Version:= 12;
         TxData.Group := 1;
         TxData.Protocol := 14;

         Radio.Setup(RadioFrequency => 2469,
                     Length => TxData.Length,
                     Version => TxData.Version,
                     Group => TxData.Group,
                     Protocol => TxData.Protocol);

         Radio.StartReceiving;
         Put_Line("Radio state: ");
         Put_Line(Radio.State); -- this should report Status: 3, meaning in RX mode
      loop
         myClock := Clock;

         loop
            while Radio.DataReady loop
               RxData := Radio.Receive;
               Obj.Set(RxData);
            end loop;
         end loop;
         delay until myClock + Milliseconds(200); --random period
      end loop;
   end Recieve;




   task body Drive is
      Speed : Integer := 512; --between 0 and 1023
      Turn : Integer := 512;
      L : Integer := 512;
      R : Integer := 512;
      Forward : constant Boolean := True; -- forward is true, backward is false
      myClock : Time;
   begin
      Set_Analog_Period_Us(20000); -- 50 Hz = 1/50 = 0.02s = 20 ms = 20000us
      loop
         myClock := Clock;
         Speed := 4*Integer((Obj.Get.Payload(1)));
         Turn := 4*Integer((Obj.Get.Payload(2)));

         R := Speed * Turn/512;
         L := Speed * ((1024-Turn)/512);

         if L > 1023 then
            L := 1013;
         end if;

         if R > 1023 then
            R := 1023;
         end if;


         --  Put("Speed is: " & Integer'Image(Speed));
         --  Put_Line(" Turn is: " & Integer'Image(Turn));
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
         delay until myClock + Milliseconds(200);
      end loop;
   end Drive;

end taskRecieve;
