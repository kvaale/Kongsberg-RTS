with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with MicroBit.Radio; use MicroBit;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with Ada.Text_IO; use Ada.Text_IO;

package timedReciever is

   task Recieve with Priority => 1;

end timedReciever;
