with protectedObjects; use protectedObjects;
with Ada.Real_Time; use Ada.Real_Time;
with MicroBit.Radio; use MicroBit;
with HAL; use HAL;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
with MicroBit.Console; use MicroBit.Console; use MicroBit;

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
         --  Put_Line("Entering task Recieve");

         --  loop
            while Radio.DataReady loop
               RxData := Radio.Receive;
               objRec.setPayload(RxData.Payload);
            end loop;
         --  end loop;

         delay until myClock + Milliseconds(10);
      end loop;
   end Recieve;
end taskRecieve;
