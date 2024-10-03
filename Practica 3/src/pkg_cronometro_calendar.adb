package body pkg_cronometro_calendar is
   task body actualizar1 is
      Inicio    : Time;
      periodo   : constant Duration := 1.0; -- Periodo de 1 segundo
      Siguiente : Time;

   begin
      Inicio := Clock; -- Inicializo el tiempo
      Siguiente := Clock + periodo; -- Calcula el siguiente punto de activacion

      loop
         Actualiza_Cronometro(Clock - Inicio);
         delay until Siguiente;
         Siguiente := Siguiente + periodo;
      end loop;
   end;
end pkg_cronometro_calendar;
