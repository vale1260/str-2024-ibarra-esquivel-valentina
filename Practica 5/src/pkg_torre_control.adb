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
      aviones_en_vuelo : array (T_Rango_AeroVia) of Integer := (others => 0); -- Contador de aviones por aerovía

   BEGIN
      PKG_debug.Escribir("======================INICIO TASK Torre_Control");

      ACCEPT Iniciar_Torre_Control DO
         null;
      END Iniciar_Torre_Control;


      -- Bucle para peticiones de descenso
      loop
         ACCEPT Solicitar_Descenso (aerovia_actual : in T_Rango_AeroVia; permiso : out Boolean) do
            declare
               aerovia_inferior : constant T_Rango_AeroVia := aerovia_actual + 1;

            begin
               -- Comprobar si la aerovía inferior tiene espacio para el avión
               if aviones_en_vuelo(aerovia_inferior) < MAX_AVIONES_AEROVIA then
                  -- Permitir el descenso
                  aviones_en_vuelo(aerovia_inferior) := aviones_en_vuelo(aerovia_inferior) + 1;
                  permiso := True;
                  PKG_debug.Escribir("Permiso concedido para el descenso del avión aerovia ID: " & T_Rango_AeroVia'Image(aerovia_actual));
               else
                  -- Denegar el descenso
                  permiso := False;
                  PKG_debug.Escribir("Permiso denegado para el descenso del avión aerovia ID: " & T_Rango_AeroVia'Image(aerovia_actual));
               end if;
            end;
         END Solicitar_Descenso;

         -- Esperar 2 segundos antes de atender otra petición
         delay 2.0;
      end loop;

   exception
      when others =>
         --PKG_debug.Escribir("ERROR en TASK Torre_Control: " & Exception_Name(Exception_Identity(event)));
         PKG_debug.Escribir("ERROR en TASK Torre_Control: Torre");
   end Tarea_Torre_Control;
end PKG_Torre_Control;
