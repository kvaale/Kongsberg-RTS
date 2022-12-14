package body protectedObjects is

   protected body objRec is
   
      procedure setPayload (Var : nRF.Radio.Payload_Data) is
      begin
         RxDataPayload := Var;
      end setPayload;
   
      function getPayload return nRF.Radio.Payload_Data is
      begin
         return RxDataPayload;
      end getPayload;
   end objRec;
   
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
   
   protected body objThink is
      
      procedure setDrive (V1 : Boolean; V2 : Boolean; V3 : Boolean; V4 : Boolean; V5 : Analog_Value; V6 : Analog_Value) is
      begin
         Dir_L1 := V1;
         Dir_L2 := V2;
         Dir_R1 := V3;
         Dir_R2 := V4;
         L := V5;
         R := V6;
      end setDrive;
      
      function get_L return Analog_Value is
      begin
         return L;
      end;
      function get_R return Analog_Value is
      begin
         return R;
      end;
      function get_Dir return Boolean is
      begin
         return Dir;
      end;
      
      function get_L1 return Boolean is
      begin
         return Dir_L1;
      end;
      function get_L2 return Boolean is
      begin
         return Dir_L2;
      end;
      function get_R1 return Boolean is
      begin
         return Dir_R1;
      end;
      function get_R2 return Boolean is
      begin
         return Dir_R2;
      end;
   end objThink;

   
end protectedObjects;
