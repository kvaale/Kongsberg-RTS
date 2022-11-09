with MicroBit.Radio; use MicroBit;

package taskRecieve is

   task Recieve with Priority => 1;
   task Drive with Priority => 2;

   protected Obj is
      procedure Set (Var : Integer);
      function Get return Integer;
   private
      RxData : Integer;
   end Obj;

end taskRecieve;
