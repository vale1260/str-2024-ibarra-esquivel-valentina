package body pkg_cronometro_calendar is
   task body actualizar1 is
      Tiempo_Inicio : Time;
      Tiempo_Actual : Time;
      Duracion      : Duration;

   begin
      Tiempo_Inicio := Clock; -- Inicializo el tiempo

      loop
         delay 1.0;

         Tiempo_Actual := Clock;
         Duracion := Ada.Calendar."-"(Tiempo_Actual, Tiempo_Inicio);
         
         -- Convertir duracion a segundos
         PKG_graficos.Actualiza_Cronometro(Duracion);
      end loop;
   end;
end pkg_cronometro_calendar;
