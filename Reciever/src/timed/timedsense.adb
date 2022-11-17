package body timedSense is
   task body Sense is
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      AmountOfMeasurement: Integer := 1000;
      WorstCase_Stopwatch : Time_Span;
      WorstCase_CPU : Time_Span;
   begin
      Ultrasonic.Setup(19,11);
      
      loop
         WorstCase_CPU := Time_Span_Zero;
         WorstCase_Stopwatch := Time_Span_Zero;
         Elapsed_Stopwatch := Time_Span_Zero;
         Elapsed_CPU := Time_Span_Zero;
         
         for Index in 1..AmountOfMeasurement loop
            Time_Now_Stopwatch := Clock;
            Time_Now_CPU := Clock;
            ----------------------------------------------------------------------------
            UltraSonicSensor.setDistance(UltraSonic.Read);
            ----------------------------------------------------------------------------
            Elapsed_CPU := (Clock - Time_Now_CPU);
            Elapsed_Stopwatch := (Clock - Time_Now_Stopwatch);
            
            
            if Elapsed_CPU > WorstCase_CPU then
               WorstCase_CPU := Elapsed_CPU;
            end if;
            if Elapsed_Stopwatch > WorstCase_Stopwatch then
               WorstCase_Stopwatch := Elapsed_Stopwatch;
            end if;
            
         end loop;

         Put_Line ("Worst-case CPU time: " & To_Duration (WorstCase_CPU)'Image & " seconds");
         Put_Line ("Worst-case Stopwatch time: " & To_Duration (WorstCase_Stopwatch)'Image & " seconds");
         
         delay(0.1);
         
      end loop;
   end Sense;

end timedSense;

--  Worst-case CPU time:  0.002960205 seconds        (MAX DISTANCE: 10cm)
--  Worst-case Stopwatch time:  0.002990723 seconds  (MAX DISTANCE: 10cm)

--  Worst-case CPU time:  0.00357 seconds            (MAX DISTANCE: 20cm)
--  Worst-case Stopwatch time:  0.00357 seconds      (MAX DISTANCE: 20cm)

