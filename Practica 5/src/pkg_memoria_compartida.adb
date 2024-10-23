package body pkg_memoria_compartida is
   protected body T_OcupacionAerovia is
      -- Entrada para verificar si hay espacio disponible
      entry check_espacio when contador < MAX_AVIONES_AEROVIA is
      begin
         null;
      end check_espacio;

      procedure incrementar is
      begin
         if contador < MAX_AVIONES_AEROVIA then
            contador := contador + 1;
         end if;
      end incrementar;

      procedure decrementar is
      begin
         if contador > 0 then
            contador := contador - 1;
         end if;
      end decrementar;

      -- Devuelve True si la aerovia esta completamente ocupada
      function esta_ocupada return Boolean is
      begin
         return contador >= MAX_AVIONES_AEROVIA;
      end esta_ocupada;

      procedure marcar_zona_segura(X : T_Rango_Rejilla_X) is
      begin
         ocupacion(X) := True;
         if X > T_Rango_Rejilla_X'First then
            ocupacion(X - 1) := True;
         end if;

         if X < T_Rango_Rejilla_X'Last then
            ocupacion(X + 1) := True;
         end if;
      end marcar_zona_segura;

      procedure liberar_zona_segura(X : T_Rango_Rejilla_X) is
      begin
         ocupacion(X) := False;
         if X > T_Rango_Rejilla_X'First then
            ocupacion(X - 1) := False;
         end if;

         if X < T_Rango_Rejilla_X'Last then
            ocupacion(X + 1) := False;
         end if;
      end liberar_zona_segura;
   end T_OcupacionAerovia;
end pkg_memoria_compartida;
