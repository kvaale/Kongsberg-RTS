with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Radio; use MicroBit;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.Console; use MicroBit.Console; use MicroBit;

package taskRecieve is

   task Recieve with Priority => 3;

end taskRecieve;
