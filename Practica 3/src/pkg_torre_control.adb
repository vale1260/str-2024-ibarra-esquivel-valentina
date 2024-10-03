--******************* PKG_TORRE_CONTROL.ADB *****************************
-- Paquete que implementa la tarea de la torre de control
--***********************************************************************

with PKG_graficos;
with PKG_debug;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Calendar; use Ada.Calendar;


PACKAGE BODY PKG_Torre_Control IS

   -----------------------------------------------------------------------
   -- DEFINICIÓN DE LA TAREA DE LA TORRE DE CONTROL
   -----------------------------------------------------------------------
   TASK BODY Tarea_Torre_Control IS

   BEGIN
      PKG_debug.Escribir("======================INICIO TASK Torre_Control");

      ACCEPT Iniciar_Torre_Control DO
         null;
      END Iniciar_Torre_Control;

      exception
       when event: others =>
        PKG_debug.Escribir("ERROR en TASK Torre_Control: " & Exception_Name(Exception_Identity(event)));

   END Tarea_Torre_Control;


end PKG_Torre_Control;
