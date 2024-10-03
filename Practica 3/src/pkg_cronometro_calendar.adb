package body pkg_cronometro_calendar is
   task body actualizar1 is
      Tiempo_Inicio : Time;
      Tiempo_Actual : Time;
      Duracion      : Duration;

   begin
      Tiempo_Inicio := Clock; -- Inicializo el tiempo

      loop
         delay until Tiempo_Inicio;

         Tiempo_Actual := Clock;
         Duracion := Ada.Calendar."-"(Tiempo_Actual, Tiempo_Inicio);
         
         -- Convertir duracion a segundos
         PKG_graficos.Actualiza_Cronometro(Duracion);
      end loop;
   end;
end pkg_cronometro_calendar;

-- Las diferencias en precisión y tipo de manejo de tiempo entre Ada.Calendar 
-- y Ada.Real_Time no se visualizan claramente ya que tal vez en el contexto 
-- de uso no se logra observar que ofrece cada paquete ya que ambos se usan en 
-- contextos distintos.

-- Las ejecuciones con delay until son mucho mas precisas que las que usan solo delay
