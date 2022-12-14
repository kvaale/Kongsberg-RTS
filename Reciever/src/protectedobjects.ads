with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with nRF.Radio;
with Ultrasonic;

package protectedObjects is

   protected objRec is
      procedure setPayload (Var : nRF.Radio.Payload_Data);
      function getPayload return nRF.Radio.Payload_Data;
   private
      RxDataPayload : nRF.Radio.Payload_Data;
   end objRec;

   protected UltraSonicSensor is
      function getDistance return Ultrasonic.Distance_cm;
      procedure setDistance (V : Ultrasonic.Distance_cm);
   private
      Dist : Ultrasonic.Distance_cm;
   end UltraSonicSensor;

   protected objThink is
      procedure setDrive(V1 : Boolean; V2 : Boolean; V3 : Boolean; V4 : Boolean; V5 : Analog_Value; V6 : Analog_Value);
      function get_L return Analog_Value;
      function get_R return Analog_Value;
      function get_Dir return Boolean;
      function get_L1 return Boolean;
      function get_L2 return Boolean;
      function get_R1 return Boolean;
      function get_R2 return Boolean;
   private
      L : Analog_Value;
      R : Analog_Value;
      Dir : Boolean;
      Dir_L1 : Boolean;
      Dir_L2 : Boolean;
      Dir_R1 : Boolean;
      Dir_R2 : Boolean;
   end objThink;

end protectedObjects;
