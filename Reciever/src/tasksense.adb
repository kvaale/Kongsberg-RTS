package body taskSense is
   task body Sense is
      myClock : Time;
   begin
      Ultrasonic.Setup(19,11);
      
      loop
         myClock := Clock;

         UltraSonicSensor.setDistance(UltraSonic.Read);
         
         delay until myClock + Milliseconds(50);
      end loop;
   end Sense;
end taskSense;
