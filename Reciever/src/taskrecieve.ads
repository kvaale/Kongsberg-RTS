with MicroBit.Radio; use MicroBit;

package taskRecieve is

   task Recieve with Priority => 1;
   task Drive with Priority => 2;

   protected Obj is
      procedure Set (Var : Radio.RadioData);
      function Get return Radio.RadioData;
   private
      RxData : Radio.RadioData;
   end Obj;

end taskRecieve;
