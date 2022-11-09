with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;


package body taskRecieve is
   protected body Obj is
      procedure Set (Var : Integer) is
      begin
         RxData := Var;
      end Set;
      function Get return Integer is
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

         Radio.Setup(RadioFrequency => 2407,
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
            --  --check if some data received and if so print it. Note that the framebuffer can max contain x messages (currently set to 4).
            --important! Sometimes data received contains junk since we dont do any package verification and radio transmission is noisy!
            while Radio.DataReady loop
               RxData := Radio.Receive;
               Obj.Set(Integer(RxData.Payload(1)));
               Put("Raven Received D1: " & UInt8'Image(RxData.Payload(1)));
               Put_Line(" D2: " & UInt8'Image(RxData.Payload(2)));
            end loop;
         end loop;
         delay until myClock + Milliseconds(200); --random period
      end loop;
   end Recieve;




   task body Drive is
      Speed : Analog_Value := 512; --between 0 and 1023
      Forward : constant Boolean := True; -- forward is true, backward is false
      myClock : Time;
   begin
      Set_Analog_Period_Us(20000); -- 50 Hz = 1/50 = 0.02s = 20 ms = 20000us
      loop
         myClock := Clock;
         Speed := Analog_Value(4*(Obj.Get));
         Put_Line("Speed is: " & Analog_Value'Image(Speed));

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
         delay until myClock + Milliseconds(200);
      end loop;
   end Drive;

end taskRecieve;
