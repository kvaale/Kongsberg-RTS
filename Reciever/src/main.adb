with taskSense;   -- Priority => 4
with taskRecieve; -- Priority => 3
with taskThink;   -- Priority => 2
with taskDrive;   -- Priority => 1
--  with timedSense;
--  with timedReciever;
--  with timedThink;
--  with timedDrive;

procedure Main with Priority => 0 is
begin
   loop
      null;
   end loop;
end Main;
