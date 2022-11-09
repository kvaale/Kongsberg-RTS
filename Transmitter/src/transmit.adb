with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body transmit is
   procedure sendBuf is
      --  RxData : Radio.RadioData;
      TxData : Radio.RadioData;
      yVal : UInt8;
      xVal : UInt8;
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
         TxData.Payload(1) := yVal;
         TxData.Payload(2) := xVal;
         --  Put("Transmit D1: " & UInt8'Image(TXdata.Payload(1)));
         --  Put_Line(" D2: " & UInt8'Image(TXdata.Payload(2)));
         Radio.Transmit(TXdata);
         --  delay(0.2);
      end loop;
   end sendBuf;
end transmit;
