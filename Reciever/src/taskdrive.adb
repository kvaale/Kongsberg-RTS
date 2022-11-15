with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
--  with MicroBit.Console; use MicroBit.Console; use MicroBit;

package body taskDrive is
   task body Drive is
      myClock : Time;
   begin
      Set_Analog_Period_Us(20000); -- 50 Hz = 1/50 = 0.02s = 20 ms = 20000us
      loop
         myClock := Clock;
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

         delay until myClock + Milliseconds(10);
      end loop;
   end Drive;
end taskDrive;
