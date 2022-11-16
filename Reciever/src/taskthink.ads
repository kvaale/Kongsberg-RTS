with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ultrasonic;
with MicroBit.Console; use MicroBit.Console; use MicroBit;

package taskThink is

   task Think with Priority => 2;

end taskThink;
