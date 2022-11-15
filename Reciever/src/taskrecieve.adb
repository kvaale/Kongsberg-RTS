with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body taskRecieve is
   task body Recieve is
      myClock : Time;
      RxData : Radio.RadioData;
      TxData : Radio.RadioData;
   begin
      TxData.Length := 10;
      TxData.Version:= 12;
      TxData.Group := 1;
      TxData.Protocol := 14;

      Radio.Setup(RadioFrequency => 2469,
                  Length => TxData.Length,
                  Version => TxData.Version,
                  Group => TxData.Group,
                  Protocol => TxData.Protocol);

      Radio.StartReceiving;
      Put_Line("Radio state: ");
      Put_Line(Radio.State); -- this should report Status: 3, meaning in RX mode
      loop
         myClock := Clock;

         loop
            while Radio.DataReady loop
               RxData := Radio.Receive;
               Obj.Set(RxData.Payload);
            end loop;
         end loop;

         delay until myClock + Milliseconds(200); --random period
      end loop;
   end Recieve;
end taskRecieve;


