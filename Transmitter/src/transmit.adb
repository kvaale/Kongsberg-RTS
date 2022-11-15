with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body transmit is
   procedure sendBuf is
      TxData : Radio.RadioData;
      yVal : UInt8;
      xVal : UInt8;
      Dir : UInt8;
   begin
      TxData.Length := 5;
      TxData.Version:= 12;
      TxData.Group := 1;
      TxData.Protocol := 14;

      Radio.Setup(RadioFrequency => 2469,
                  Length => TxData.Length,
                  Version => TxData.Version,
                  Group => TxData.Group,
                  Protocol => TxData.Protocol);

      Radio.StartReceiving;
      Put_Line(Radio.State); -- this should report Status: 3, meaning in RX mode
      loop
         yVal := UInt8((Analog(10))/4);
         xVal := UInt8((Analog(4))/4);

         Put("yVal: " & UInt8'Image(yVal));
         if yVal > 127 then
            yVal := 2*(yVal-127);
            Dir := 1;
         else
            yVal := 2*(-yVal+127);
            Dir := 0;
         end if;


         TxData.Payload(1) := yVal;  -- Speed
         TxData.Payload(2) := xVal;  -- Turn rate
         TxData.Payload(3) := Dir;   -- Direction, 1 is Forward
         TxData.Payload(4) := 0;     -- Driving mode

         Put(" Transmit D1: " & UInt8'Image(TxData.Payload(1)));
         Put_Line(" D2: " & UInt8'Image(TxData.Payload(2)));

         Radio.Transmit(TxData);
         delay(0.2);
      end loop;
   end sendBuf;
end transmit;
