with PKG_debug;
with PKG_tipos; use PKG_tipos;
with PKG_graficos; use PKG_graficos;
with Ada.Numerics.Discrete_Random;
with Ada.Exceptions; use Ada.Exceptions;

package pkg_creacion_aviones is
    TASK TareaGeneraAviones;
   TASK TYPE T_TareaAvion(ptr_avion : Ptr_T_RecordAvion);
   type Ptr_TareaAvion is access T_TareaAvion;

end pkg_creacion_aviones;
