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

            while Radio.DataReady loop
               RxData := Radio.Receive;
               objRec.setPayload(RxData.Payload);
            end loop;

         delay until myClock + Milliseconds(50);
      end loop;
   end Recieve;
end taskRecieve;
