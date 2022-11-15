with Ultrasonic;
with MicroBit.Radio;
with nRF.Radio;
with HAL; use HAL;
use MicroBit;

package SensorData is

   protected ControllerData is
      function getXvalue return Integer;
      procedure setXvalue (X : Integer);
      function getYvalue return Integer;
      procedure setYvalue (Y : Integer);
   private
      valueX : Integer := 512;
      valueY : Integer := 512;
   end ControllerData;
   
   protected UltraSonicSensor is
      function getDistance return Ultrasonic.Distance_cm;
      procedure setDistance (V : Ultrasonic.Distance_cm);
   private
      Dist : Ultrasonic.Distance_cm;
   end UltraSonicSensor;
   
   protected ButtonState is
      function getButtonState return Integer;
      procedure setButtonState ( V : Integer);
   private
      State : Integer;
   end ButtonState;
   
   protected Payload is
      function getPayload return Radio.RadioData;
      procedure setPayload ( V : Radio.RadioData );
   private
      Data : Radio.RadioData;
   end Payload;
   
   

end SensorData;
