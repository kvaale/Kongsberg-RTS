with Ada.Real_Time; use Ada.Real_Time;
--with Ada.Text_IO; use Ada.Text_IO; -- instead of MicroBit.Console we can also use Ada.Text_IO (in the Serial Ports view) for convenience which use the same API's
with Ada.Execution_Time; use Ada.Execution_Time;

with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;

package body Brain is

   task body Sense is
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      AmountOfMeasurement: Integer := 10; -- do 10 measurement and average
            RXdata : Radio.RadioData;
      TxData : Radio.RadioData;
   begin
      loop
            Elapsed_Stopwatch := Time_Span_Zero;
         Elapsed_CPU := Time_Span_Zero;
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

            for Index in 1..AmountOfMeasurement loop
               Time_Now_Stopwatch := Clock;
               Time_Now_CPU := Clock;



            --  --check if some data received and if so print it. Note that the framebuffer can max contain x messages (currently set to 4).
            --important! Sometimes data received contains junk since we dont do any package verification and radio transmission is noisy!
            while Radio.DataReady loop
               RXdata :=Radio.Receive;
               Put("Raven Received D1: " & UInt8'Image(RXdata.Payload(1)));
               Put_Line(" D2: " & UInt8'Image(RXdata.Payload(2)));
            end loop;

               Elapsed_CPU := Elapsed_CPU + (Clock - Time_Now_CPU);
               Elapsed_Stopwatch := Elapsed_Stopwatch + (Clock - Time_Now_Stopwatch);
            end loop;

            Elapsed_CPU := Elapsed_CPU / AmountOfMeasurement;
            Elapsed_Stopwatch := Elapsed_Stopwatch / AmountOfMeasurement;

            Put_Line ("Average CPU time: " & To_Duration (Elapsed_CPU)'Image & " seconds");
            Put_Line ("Average Stopwatch time: " & To_Duration (Elapsed_Stopwatch)'Image & " seconds");

      end loop;
   end Sense;
end Brain;
