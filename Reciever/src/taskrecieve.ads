with MicroBit.Radio; use MicroBit;
with nRF.Radio;

package taskRecieve is

   task Recieve with Priority => 1;
   task Drive with Priority => 2;

   protected Obj is
      procedure Set (Var : nRF.Radio.Payload_Data);
      function Get return nRF.Radio.Payload_Data;
   private
      RxDataPayload : nRF.Radio.Payload_Data;
   end Obj;

end taskRecieve;
