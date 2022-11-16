package body timedThink is

   task body Think is
      Time_Now_Stopwatch : Time;
      Time_Now_CPU : CPU_Time;
      Elapsed_Stopwatch : Time_Span;
      Elapsed_CPU : Time_Span;
      AmountOfMeasurement: Integer := 10000;
      WorstCase_Stopwatch : Time_Span;
      WorstCase_CPU : Time_Span;
      
      yVal : Integer := 512;     --between 0 and 1023
      xVal : Integer := 512;
      L : Integer := 512;
      R : Integer := 512;
      Forward : Boolean := True; -- forward is true, backward is false
      Mode : UInt8;
      RxData : Radio.RadioData;
   begin      
      loop
         WorstCase_CPU := Time_Span_Zero;
         WorstCase_Stopwatch := Time_Span_Zero;
         Elapsed_Stopwatch := Time_Span_Zero;
         Elapsed_CPU := Time_Span_Zero;
         RxData.Payload(1) := 128;  -- yVal
         RxData.Payload(2) := 128;  -- xVal
         RxData.Payload(3) := 1;    -- Direction
         RxData.Payload(4) := 0;    -- Driving mode
         objRec.setPayload(RxData.Payload);
         UltraSonicSensor.setDistance(300);  -- Sensor distance
         
         for Index in 1..AmountOfMeasurement loop
            Time_Now_Stopwatch := Clock;
            Time_Now_CPU := Clock;
            ----------------------------------------------------------------------------
            yVal := Integer((objRec.getPayload(1)));  -- yVal = Speed
            xVal := Integer((objRec.getPayload(2)));  -- xVal = Turn
            Mode := objRec.getPayload(4);
      
            if Integer(UltraSonicSensor.getDistance) <= 5 then
               objThink.setDrive(True, True, False, False, 512, 512);
            else
               if Mode < 1 then

                  yVal := 4*yVal;
                  xVal := 4*xVal;

                  L := yVal * ((1024-xVal)/512);
                  R := yVal * xVal/512;


                  if objRec.getPayload(3) = 1 then
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
         
                  objThink.setDrive(Forward, Forward, Forward, Forward, Analog_Value(L), Analog_Value(R)); 
               else
                  if (yVal < 150 and yVal > 100 and xVal < 150 and xVal > 100) then
                     objThink.setDrive(False, False, False, False, 0, 0);    -- STOPPED
                  elsif (yVal < 150 and yVal > 100 and xVal < 256 and xVal > 200) then
                     objThink.setDrive(True, False, False, True, 512, 512);  -- LEFT
                  elsif (yVal < 256 and yVal > 200 and xVal < 150 and xVal > 100) then
                     objThink.setDrive(True, True, True, True, 512, 512);    -- FORWARD
                  elsif (yVal < 100 and yVal >= 0 and xVal < 150 and xVal > 100) then
                     objThink.setDrive(False, False, False, False, 512, 512); -- REVERSE
                  elsif (yVal < 150 and yVal > 100 and xVal < 100 and xVal >= 0) then
                     objThink.setDrive(False, True, True, False, 512, 512);   -- RIGHT
                  end if;
               end if;
            end if;        
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
         delay(0.5);
      end loop;
      
   end Think;

end timedThink;
