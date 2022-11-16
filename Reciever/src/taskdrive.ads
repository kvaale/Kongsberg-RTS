with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
--  with MicroBit.Console; use MicroBit.Console; use MicroBit;

package taskDrive is
   
   task Drive with Priority => 1;
   
end taskDrive;
