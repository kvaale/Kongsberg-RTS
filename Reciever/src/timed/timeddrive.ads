with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Console; use MicroBit.Console; use MicroBit;

package timedDrive is

   task Drive with Priority => 1;

end timedDrive;
