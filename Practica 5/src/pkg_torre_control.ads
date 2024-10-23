--******************* PKG_TORRE_CONTROL.ADS *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_tipos; use PKG_tipos;

PACKAGE PKG_Torre_Control IS

   TASK Tarea_Torre_Control IS
      ENTRY Iniciar_Torre_Control;
      ENTRY Solicitar_Descenso(avion_id : in PKG_tipos.T_IdAvion; aerovia_actual : in PKG_tipos.T_Rango_AeroVia);
      ENTRY Respuesta_Permiso(permiso_concedido : out Boolean);
   END Tarea_Torre_Control;

end PKG_Torre_Control;
