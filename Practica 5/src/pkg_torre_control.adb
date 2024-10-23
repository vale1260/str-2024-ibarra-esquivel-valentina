--******************* PKG_TORRE_CONTROL.ADB *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_graficos;
with PKG_debug;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Calendar; use Ada.Calendar;
with PKG_tipos; use PKG_tipos;


PACKAGE BODY PKG_Torre_Control IS
   -----------------------------------------------------------------------
   -- DEFINICIÓN DE LA TAREA DE LA TORRE DE CONTROL
   -----------------------------------------------------------------------
   TASK BODY Tarea_Torre_Control IS
      aviones_en_vuelo : array (T_Rango_AeroVia) of Integer := (others => 0); -- Contador de aviones por aerovia
      avion            : Ptr_T_RecordAvion;
      avion_permiso    : Boolean;

   BEGIN
      PKG_debug.Escribir("======================INICIO TASK Torre_Control");

      ACCEPT Iniciar_Torre_Control DO
         null;
      END Iniciar_Torre_Control;

      -- Bucle para peticiones de descenso
      loop
         ACCEPT Solicitar_Descenso (avion_id : in PKG_tipos.T_IdAvion; aerovia_actual : in PKG_tipos.T_Rango_AeroVia) do
            PKG_debug.Escribir("Solicitud de descenso para avion: "& T_IdAvion'Image(avion.id));

            declare
               aerovia_inferior : constant T_Rango_AeroVia := aerovia_actual - 1;

            begin
               if aviones_en_vuelo(aerovia_inferior) < MAX_AVIONES_AEROVIA then
                  PKG_debug.Escribir("Permiso para descender: " & T_IdAvion'Image(avion.id));
                  aviones_en_vuelo(aerovia_inferior) := aviones_en_vuelo(aerovia_inferior) + 1;
                  avion_permiso := True;
               else
                  PKG_debug.Escribir("Permiso denegado: " & T_IdAvion'Image(avion.id));
                  avion_permiso := False;
               end if;
            end;
         END Solicitar_Descenso;

         ACCEPT Respuesta_Permiso (permiso_concedido : out Boolean) do
               permiso_concedido := avion_permiso;
         END Respuesta_Permiso;

         delay 2.0;
      end loop;

      exception
       when event: others =>
        PKG_debug.Escribir("ERROR en TASK Torre_Control: " & Exception_Name(Exception_Identity(event)));

   END Tarea_Torre_Control;
end PKG_Torre_Control;
