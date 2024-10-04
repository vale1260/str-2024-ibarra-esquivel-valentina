package body pkg_cronometro_realtime is
   task body actualizar2 is
      Tiempo_Inicio : Time;
      Tiempo_Actual : Time;
      Duracion : Time_Span;

   begin
      Tiempo_Inicio := Clock; -- Inicializo

      loop
         delay 1.0;

         -- Actualiza el tiempo actual
         Tiempo_Actual := Clock;
         
         -- Calcula la duracion desde inicio
         Duracion := Ada.Real_Time."-"(Tiempo_Actual, Tiempo_Inicio);
         
         -- Convertir Time_Span a segundos 
         PKG_graficos.Actualiza_Cronometro(To_Duration(Duracion));
      end loop;
   end actualizar2;
end pkg_cronometro_realtime;
