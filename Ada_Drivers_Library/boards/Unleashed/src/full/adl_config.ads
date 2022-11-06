--  This package was generated by the Ada_Drivers_Library project wizard script
package ADL_Config is
   Architecture                   : constant String  := "RISC-V";            -- From board definition
   Board                          : constant String  := "Unleashed";         -- From command line
   CPU_Core                       : constant String  := "RISC-V64";          -- From mcu definition
   Device_Family                  : constant String  := "U5";                -- From board definition
   Device_Name                    : constant String  := "U540";              -- From board definition
   Has_Ravenscar_Full_Runtime     : constant String  := "True";              -- From board definition
   Has_Ravenscar_SFP_Runtime      : constant String  := "True";              -- From board definition
   Has_ZFP_Runtime                : constant String  := "True";              -- From board definition
   Max_Mount_Name_Length          : constant         := 128;                 -- From default value
   Max_Mount_Points               : constant         := 2;                   -- From default value
   Max_Path_Length                : constant         := 1024;                -- From default value
   Number_Of_Interrupts           : constant         := 0;                   -- From default value
   Runtime_Name                   : constant String  := "ravenscar-full-unleashed"; -- From default value
   Runtime_Name_Suffix            : constant String  := "unleashed";         -- From board definition
   Runtime_Profile                : constant String  := "ravenscar-full";    -- From command line
   Use_Startup_Gen                : constant Boolean := False;               -- From command line
   Vendor                         : constant String  := "SiFive";            -- From board definition
end ADL_Config;
