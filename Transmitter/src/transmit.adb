with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;

package body transmit is
   procedure sendBuf is
      RXdata : Radio.RadioData;
      TxData : Radio.RadioData;
   begin
      TxData.Length := 5;
      TxData.Version:= 12;
      TxData.Group := 1;
      TxData.Protocol := 14;

      Radio.Setup(RadioFrequency => 2407,
                  Length => TxData.Length,
                  Version => TxData.Version,
                  Group => TxData.Group,
                  Protocol => TxData.Protocol);
      
      TxData.Payload(1) := 12;
      TxData.Payload(2) := 34;
      Put("Transmit D1: " & UInt8'Image(TXdata.Payload(1)));
      Put_Line(" D2: " & UInt8'Image(TXdata.Payload(2)));
      Radio.Transmit(TXdata);
      
      delay(2.0);
   end sendBuf;
end transmit;
