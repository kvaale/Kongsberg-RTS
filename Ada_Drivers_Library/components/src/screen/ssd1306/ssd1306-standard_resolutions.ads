------------------------------------------------------------------------------
--                                                                          --
--                        Copyright (C) 2017, AdaCore                       --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

package SSD1306.Standard_Resolutions is

   type SSD1306_96x16_Screen
     (Port             : not null Any_I2C_Port;
      RST              : not null Any_GPIO_Point;
      Time             : not null HAL.Time.Any_Delays)
   is new SSD1306_Screen ((96 * 16) / 8, 96, 16, Port, RST, Time) with null record;

   type SSD1306_128x32_Screen
     (Port             : not null Any_I2C_Port;
      RST              : not null Any_GPIO_Point;
      Time             : not null HAL.Time.Any_Delays)
   is new SSD1306_Screen ((128 * 32) / 8, 128, 32, Port, RST, Time) with null record;

   type SSD1306_128x64_Screen
     (Port             : not null Any_I2C_Port;
      RST              : not null Any_GPIO_Point;
      Time             : not null HAL.Time.Any_Delays)
   is new SSD1306_Screen ((128 * 64) / 8, 128, 64, Port, RST, Time) with null record;
end SSD1306.Standard_Resolutions;
