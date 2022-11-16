package body timedDrive is

   task body Drive is
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      AmountOfMeasurement: Integer := 1000;
      WorstCase_Stopwatch : Time_Span;
      WorstCase_CPU : Time_Span;
   begin
      Set_Analog_Period_Us(20000); -- 50 Hz = 1/50 = 0.02s = 20 ms = 20000us
      
      loop
         WorstCase_CPU := Time_Span_Zero;
         WorstCase_Stopwatch := Time_Span_Zero;
         Elapsed_Stopwatch := Time_Span_Zero;
         Elapsed_CPU := Time_Span_Zero;
         
         objThink.setDrive(True, True, True, True, 512, 512);
         
         for Index in 1..AmountOfMeasurement loop
            Time_Now_Stopwatch := Clock;
            Time_Now_CPU := Clock;
            ----------------------------------------------------------------------------
            --LEFT front
            Set(6, objThink.get_L1);      --IN1
            Set(7, not objThink.get_L1);  --IN2

            --LEFT back
            Set(2, objThink.get_L2);      --IN3
            Set(3, not objThink.get_L2);  --IN4

            --RIGHT front
            Set(12, objThink.get_R1);     --IN1
            Set(13, not objThink.get_R1); --IN2

            --RIGHT back
            Set(14, objThink.get_R2);     --IN3
            Set(15, not objThink.get_R2); --IN4

            Write (0, objThink.get_L);     --left speed control ENA ENB
            Write (1, objThink.get_R);     --right speed control ENA ENB
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
         
         --  delay(0.5);
         
      end loop;
   end Drive;

end timedDrive;
