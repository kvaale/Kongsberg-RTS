package Controller is

   type Directions is (Straight, Left, Right, Backward, Stop, Rotate_Left, Rotate_Right);
   
   task Sense with Priority => 1;
  
   task Think with Priority=> 2;
   
   task Act with Priority=> 3;
   
   procedure DriveUni ( V : Directions);
   
   procedure Drive ( P1 : Integer; P2 : Integer; P3 : Integer);
   
   

   protected MotorDriver is
      function GetDirection return Directions;
      procedure SetDirection (V : Directions);
   private
      DriveDirection : Directions := Stop;
   end MotorDriver;
  

end Controller;
