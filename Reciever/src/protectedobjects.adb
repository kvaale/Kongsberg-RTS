with nRF.Radio;

package body protectedObjects is

   protected body Obj is
   
      procedure Set (Var : nRF.Radio.Payload_Data) is
      begin
         RxDataPayload := Var;
      end Set;
   
      function Get return nRF.Radio.Payload_Data is
      begin
         return RxDataPayload;
      end Get;
   end Obj;

   protected body MotorDriver is
      --  procedures can modify the data
      procedure SetDirection (V : Directions) is
      begin
         DriveDirection := V;
      end SetDirection;

      --  functions cannot modify the data
      function GetDirection return Directions is
      begin
         return DriveDirection;
      end GetDirection;
   end MotorDriver;


end protectedObjects;
