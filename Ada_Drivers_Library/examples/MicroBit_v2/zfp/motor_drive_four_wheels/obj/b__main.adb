pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

package body ada_main is

   E81 : Short_Integer; pragma Import (Ada, E81, "memory_barriers_E");
   E79 : Short_Integer; pragma Import (Ada, E79, "cortex_m__nvic_E");
   E71 : Short_Integer; pragma Import (Ada, E71, "nrf__events_E");
   E28 : Short_Integer; pragma Import (Ada, E28, "nrf__gpio_E");
   E73 : Short_Integer; pragma Import (Ada, E73, "nrf__gpio__tasks_and_events_E");
   E75 : Short_Integer; pragma Import (Ada, E75, "nrf__interrupts_E");
   E36 : Short_Integer; pragma Import (Ada, E36, "nrf__rtc_E");
   E39 : Short_Integer; pragma Import (Ada, E39, "nrf__spi_master_E");
   E58 : Short_Integer; pragma Import (Ada, E58, "nrf__tasks_E");
   E56 : Short_Integer; pragma Import (Ada, E56, "nrf__adc_E");
   E83 : Short_Integer; pragma Import (Ada, E83, "nrf__ppi_E");
   E43 : Short_Integer; pragma Import (Ada, E43, "nrf__timers_E");
   E46 : Short_Integer; pragma Import (Ada, E46, "nrf__twi_E");
   E50 : Short_Integer; pragma Import (Ada, E50, "nrf__uart_E");
   E06 : Short_Integer; pragma Import (Ada, E06, "nrf__device_E");
   E54 : Short_Integer; pragma Import (Ada, E54, "microbit__ios_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);


   procedure adainit is
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");

      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      null;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;


      E81 := E81 + 1;
      E79 := E79 + 1;
      E71 := E71 + 1;
      E28 := E28 + 1;
      E73 := E73 + 1;
      E75 := E75 + 1;
      E36 := E36 + 1;
      E39 := E39 + 1;
      E58 := E58 + 1;
      E56 := E56 + 1;
      E83 := E83 + 1;
      E43 := E43 + 1;
      E46 := E46 + 1;
      E50 := E50 + 1;
      Nrf.Device'Elab_Spec;
      Nrf.Device'Elab_Body;
      E06 := E06 + 1;
      Microbit.Ios'Elab_Spec;
      Microbit.Ios'Elab_Body;
      E54 := E54 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   procedure main is
      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      adainit;
      Ada_Main_Program;
   end;

--  BEGIN Object file/option list
   --   C:\Users\aadne\Documents\git-repos\Ada_Drivers_Library\examples\MicroBit_v2\zfp\motor_drive_four_wheels\obj\main.o
   --   -LC:\Users\aadne\Documents\git-repos\Ada_Drivers_Library\examples\MicroBit_v2\zfp\motor_drive_four_wheels\obj\
   --   -LC:\Users\aadne\Documents\git-repos\Ada_Drivers_Library\examples\MicroBit_v2\zfp\motor_drive_four_wheels\obj\
   --   -LC:\Users\aadne\Documents\git-repos\Ada_Drivers_Library\boards\MicroBit_v2\obj\zfp_lib_Debug\
   --   -LC:\gnat\2021-arm-elf\arm-eabi\lib\gnat\zfp-cortex-m4f\adalib\
   --   -static
   --   -lgnat
--  END Object file/option list   

end ada_main;
