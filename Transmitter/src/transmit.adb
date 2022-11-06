with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body transmit is
   procedure sendBuf is
      RXdata : Radio.RadioData;
      TxData : Radio.RadioData;
      xVal : Analog_Value;
      yVal : Analog_Value;
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

      Radio.StartReceiving;
      Put_Line(Radio.State); -- this should report Status: 3, meaning in RX mode

      loop
         xVal := (Analog(4))/4;
         yVal := (Analog(10))/4;
         --
         --  -- setup some data to be transmitted and transmit it
         TxData.Payload(1) := UInt8(xVal);
         TxData.Payload(2) := UInt8(yVal);
         Put("Transmit D1: " & UInt8'Image(TXdata.Payload(1)));
         Put_Line(" D2: " & UInt8'Image(TXdata.Payload(2)));
         Radio.Transmit(TXdata);
         delay(0.2);

      end loop;
   end sendBuf;
end transmit;
