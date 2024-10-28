--******************* PKG_TORRE_CONTROL.ADS *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_tipos; use PKG_tipos;

PACKAGE PKG_Torre_Control IS

   TASK Tarea_Torre_Control IS
      ENTRY Iniciar_Torre_Control;
      ENTRY Solicitar_Descenso(aerovia_actual : in PKG_tipos.T_Rango_AeroVia; permiso : out Boolean);
   END Tarea_Torre_Control;

end PKG_Torre_Control;
