with PKG_debug; use PKG_debug;
with PKG_tipos; use PKG_tipos;
with PKG_graficos; use PKG_graficos;
with Ada.Numerics.Discrete_Random;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

package pkg_creacion_aviones is
   TASK TareaGeneraAviones;
   -- Tipo tarea encargada del comportamiento de los aviones
   TASK TYPE T_TareaAvion(ptr_avion : Ptr_T_RecordAvion);
   -- Puntero al avion para poder pasale datos
   type Ptr_TareaAvion is access T_TareaAvion;

end pkg_creacion_aviones;
