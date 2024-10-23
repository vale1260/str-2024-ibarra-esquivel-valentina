with Ada.Text_IO; use Ada.Text_IO;
with PKG_graficos; use PKG_graficos;
with Ada.Real_Time; use Ada.Real_Time;

package pkg_cronometro_realtime is
   -- Defino tarea dinamica
   task type T_Cronometro_RealTime;

   -- Puntero a la tarea cronometro
   type Ptr_Cronometro_RealTime is access T_Cronometro_RealTime;

   -- Procedimiento para crear cronometro dinamico
   procedure Iniciar_Cronometro_RealTime;
end pkg_cronometro_realtime;
