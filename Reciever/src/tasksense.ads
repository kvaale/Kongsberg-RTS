with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with Ultrasonic;

package taskSense is

   task Sense with Priority => 4;

end taskSense;
