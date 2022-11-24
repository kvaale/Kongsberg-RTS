with HAL; use HAL;
with nRF.Radio;
with MicroBit.Radio;
with MicroBit.Console; use MicroBit.Console;
with MicroBit.Buttons; use MicroBit.Buttons;
with MicroBit.IOsForTasking; use MicroBit.IOsForTasking;
use MicroBit;

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

         yVal := UInt8((Analog(10))/4);  -- Divided by 4 to fit in UInt8
         xVal := UInt8((Analog(4))/4);   -- Divided by 4 to fit in UInt8

         if MicroBit.Buttons.State (Button_B) = Released then
            if yVal > 127 then
               yVal := 2*(yVal-127);     -- yVal (Speed) starts at
               Dir := 1;                 -- 0 in dead centre (=128)
            else
               yVal := 2*(-yVal+127);    -- Calculated yVal increases
               Dir := 0;                 -- when joystick is pulled down
            end if;
            Mode := 0;
         else
            Mode := 1;
         end if;

         TxData.Payload(1) := yVal;  -- Speed
         TxData.Payload(2) := xVal;  -- Turn rate
         TxData.Payload(3) := Dir;   -- Direction, 1 is Forward
         TxData.Payload(4) := Mode;  -- Driving mode
         Radio.Transmit(TxData);
      end loop;
   end sendBuf;
end transmit;
