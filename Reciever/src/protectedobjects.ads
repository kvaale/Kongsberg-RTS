with nRF.Radio;

package protectedObjects is

   protected Obj is
      procedure Set (Var : nRF.Radio.Payload_Data);
      function Get return nRF.Radio.Payload_Data;
   private
      RxDataPayload : nRF.Radio.Payload_Data;
   end Obj;

   -------------------------------------------------

   type Directions is (Straight, Left, Right, Backward, Stop, Rotate_Left, Rotate_Right);

   protected MotorDriver is
      function GetDirection return Directions;
      procedure SetDirection (V : Directions);
   private
      DriveDirection : Directions := Stop;
   end MotorDriver;

   --  procedure DriveUni ( V : Directions);


end protectedObjects;
