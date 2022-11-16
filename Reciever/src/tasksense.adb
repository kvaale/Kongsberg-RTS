package body taskSense is
   task body Sense is
      --  Distance : Ultrasonic.Distance_cm := 0;
      myClock : Time;
   begin
      Ultrasonic.Setup(19,11);
      
      loop
         myClock := Clock;
         --  Distance := UltraSonic.Read;
         UltraSonicSensor.setDistance(UltraSonic.Read);
         
         delay until myClock + Milliseconds(50);
      end loop;
   end Sense;
end taskSense;
