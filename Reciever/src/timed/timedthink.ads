with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Radio; use MicroBit;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.Console; use MicroBit.Console; use MicroBit;

package timedThink is

   task Think with Priority => 1;

end timedThink;
