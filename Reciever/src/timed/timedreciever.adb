package body timedReciever is

   task body Recieve is
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      AmountOfMeasurement: Integer := 10000;
      WorstCase_Stopwatch : Time_Span;
      WorstCase_CPU : Time_Span;
      
      RxData : Radio.RadioData;
      TxData : Radio.RadioData;
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
      Put_Line("Radio state: ");
      Put_Line(Radio.State); -- this should report Status: 3, meaning in RX mode
      
      loop
         WorstCase_CPU := Time_Span_Zero;
         WorstCase_Stopwatch := Time_Span_Zero;
         Elapsed_Stopwatch := Time_Span_Zero;
         Elapsed_CPU := Time_Span_Zero;
         
         for Index in 1..AmountOfMeasurement loop
            Time_Now_Stopwatch := Clock;
            Time_Now_CPU := Clock;
            ----------------------------------------------------------------------------
            while Radio.DataReady loop
               RxData := Radio.Receive;
               objRec.setPayload(RxData.Payload);  -- objRec.setPayload(Radio.Recieve.Payload); ????
            end loop;
            ----------------------------------------------------------------------------
            Elapsed_CPU := Clock - Time_Now_CPU;
            Elapsed_Stopwatch := Clock - Time_Now_Stopwatch;
            
            
            if Elapsed_CPU > WorstCase_CPU then
               WorstCase_CPU := Elapsed_CPU;
            end if;
            
            if Elapsed_Stopwatch > WorstCase_Stopwatch then
               WorstCase_Stopwatch := Elapsed_Stopwatch;
            end if;
            
         end loop;

         Put_Line ("Worst-case CPU time: " & To_Duration (WorstCase_CPU)'Image & " seconds");
         Put_Line ("Worst-case Stopwatch time: " & To_Duration (WorstCase_Stopwatch)'Image & " seconds");
         delay(0.5);
      end loop;
   end Recieve;
end timedReciever;
