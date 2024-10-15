package body pkg_cronometro_calendar is
   task body T_Cronometro_Calendar is
      Tiempo_Inicio : Time;
      Tiempo_Actual : Time;
      Siguiente     : Time;
      Duracion      : Duration;
      Periodo       : constant Duration := 1.0;

   begin
      Tiempo_Inicio := Clock; -- Inicializo el tiempo
      Siguiente := Clock + Periodo;

      loop
         delay until Siguiente;
         Siguiente := Siguiente + Periodo;

         Tiempo_Actual := Clock;
         Duracion := Ada.Calendar."-"(Tiempo_Actual, Tiempo_Inicio);

         -- Convertir duracion a segundos
         PKG_graficos.Actualiza_Cronometro(Duracion);
      end loop;
   end;

   procedure Iniciar_Cronometro_Calendar is
      Cronometro : Ptr_Cronometro_Calendar;
   begin
      Cronometro := new T_Cronometro_Calendar;
   end Iniciar_Cronometro_Calendar;
end pkg_cronometro_calendar;


-- Las diferencias en precisión y tipo de manejo de tiempo entre Ada.Calendar
-- y Ada.Real_Time no se visualizan claramente ya que tal vez en el contexto
-- de uso no se logra observar que ofrece cada paquete ya que ambos se usan en
-- contextos distintos.

-- Las ejecuciones con delay until son mucho mas precisas que las que usan solo delay
