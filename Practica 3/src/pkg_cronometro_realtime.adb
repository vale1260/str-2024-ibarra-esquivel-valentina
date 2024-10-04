package body pkg_cronometro_realtime is
   task body T_Cronometro_RealTime is
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
   end T_Cronometro_RealTime;

   procedure Iniciar_Cronometro_RealTime is
      Cronometro : Ptr_Cronometro_RealTime;
   begin
      Cronometro := new T_Cronometro_RealTime;
   end Iniciar_Cronometro_RealTime;
end pkg_cronometro_realtime;
