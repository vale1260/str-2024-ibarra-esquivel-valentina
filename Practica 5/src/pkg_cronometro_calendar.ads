with Ada.Text_IO; use Ada.Text_IO;
with PKG_graficos; use PKG_graficos;
with Ada.Calendar; use Ada.Calendar;

package pkg_cronometro_calendar is
   task type T_Cronometro_Calendar;
   type Ptr_Cronometro_Calendar is access T_Cronometro_Calendar;
   procedure Iniciar_Cronometro_Calendar;
end pkg_cronometro_calendar;
