with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;




package body SensorData is

  protected body ControllerData is
      --  procedures can modify the data
      procedure setXvalue (X : Integer) is
      begin
         valueX := X;
      end setXvalue;

      --  functions cannot modify the data
      function getXvalue return Integer is
      begin
         return valueX;
      end getXvalue;
      
      procedure setYvalue ( Y : Integer) is
      begin
         valueY := Y;
      end setYvalue;
      
      function getYvalue return Integer is
      begin 
         return valueY;
      end getYvalue;
      
      
   end ControllerData;
   
   protected body UltraSonicSensor is
      function getDistance return Ultrasonic.Distance_cm is 
      begin 
         return Dist;
      end getDistance;
      
         procedure setDistance (V : Ultrasonic.Distance_cm) is 
      begin 
         Dist := V;
      end setDistance;
      
   end UltraSonicSensor;
   
   protected body ButtonState is
      function getButtonState return Integer is
      begin
         return State;
      end getButtonState;
      
      procedure setButtonState ( V : Integer) is
      begin
         State := V;
      end setButtonState;
   end ButtonState;
   
    protected body Payload is
      function getPayload return Radio.RadioData is
      begin
         return Data;
         end getPayload;
      procedure setPayload ( V : Radio.RadioData ) is
      begin
         Data := V;
         end setPayload;
   end Payload;
   

end SensorData;
