with MicroBit.Radio;
with HAL; use HAL;
with MicroBit.Console; use MicroBit.Console;
with nRF.Radio;
with MicroBit.Buttons; use MicroBit.Buttons;
use MicroBit;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;

package body transmit is
   procedure sendBuf is
      TxData : Radio.RadioData;
      yVal : UInt8;
      xVal : UInt8;
      Dir : UInt8;
      Mode : UInt8;
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
      Put_Line(Radio.State); -- this should report Status: 3, meaning in RX mode
      loop

         yVal := UInt8((Analog(10))/4);
         xVal := UInt8((Analog(4))/4);

         if MicroBit.Buttons.State (Button_B) = Released then
            if yVal > 127 then
               yVal := 2*(yVal-127);
               Dir := 1;
            else
               yVal := 2*(-yVal+127);
               Dir := 0;
            end if;
            Mode := 0;
         else
            Mode := 1;
         end if;

         TxData.Payload(1) := yVal;  -- Speed
         TxData.Payload(2) := xVal;  -- Turn rate
         TxData.Payload(3) := Dir;   -- Direction, 1 is Forward
         TxData.Payload(4) := 1;     -- Driving mode
         --  Put(" yVal: " & UInt8'Image(yVal));
         --  Put_Line(" xVal: " & UInt8'Image(xVal));

         Radio.Transmit(TxData);
         --  delay(0.5);
      end loop;
   end sendBuf;
end transmit;
