with pkg_cronometro_calendar;
with pkg_cronometro_realtime;
with pkg_memoria_compartida;
with PKG_Torre_Control;
with Ada.Text_IO;

package body pkg_creacion_aviones is

   task body TareaGeneraAviones is
      tarea_avion      : Ptr_TareaAvion;
      ptr_avion        : Ptr_T_RecordAvion;
      cronometro       : pkg_cronometro_calendar.Ptr_Cronometro_Calendar; -- Puntero al cronometro Calendar
      cronometro_real  : pkg_cronometro_realtime.Ptr_Cronometro_RealTime; -- Puntero al cronometro RealTime

      package pkg_generadorRetardo is new Ada.Numerics.Discrete_Random(T_RetardoAparicionAviones);
      generador_retardo : pkg_generadorRetardo.Generator;

   begin
      -- Crea cronometros de manera dinamica
      cronometro := new pkg_cronometro_calendar.T_Cronometro_Calendar;
      cronometro_real := new pkg_cronometro_realtime.T_Cronometro_RealTime;
      pkg_generadorRetardo.Reset(generador_retardo);

      for id in T_IdAvion loop
         for aerovia in T_Rango_Aerovia'First..T_Rango_Aerovia'Last - 2 loop
            -- Inicializar los datos de un nuevo avión
            ptr_avion := new T_RecordAvion;

            ptr_avion.id := id;
            ptr_avion.velocidad.x := 0;
            ptr_avion.velocidad.y := 0;
            ptr_avion.aerovia := aerovia;
            ptr_avion.tren_aterrizaje := False;
            ptr_avion.aerovia_inicial := aerovia;
            ptr_avion.pista := SIN_PISTA;
            ptr_avion.color := BLUE;
            ptr_avion.pos := Pos_Inicio(aerovia);

            -- Cambiar direccion
            if aerovia = 1 or aerovia = 3 then
               ptr_avion.velocidad.X := -VELOCIDAD_VUELO;
            else
               ptr_avion.velocidad.X := VELOCIDAD_VUELO;
            end if;

            Ada.Text_IO.Put_Line("Inicializando avion ID "& T_IdAvion'Image(id) & " en aerovia "& T_Rango_AeroVia'Image(aerovia));

            -- Crear la tarea para el comportamiento del avión
            tarea_avion := new T_TareaAvion(ptr_avion);

            delay(Duration(pkg_generadorRetardo.random(generador_retardo)));
         end loop;
      end loop;
   end TareaGeneraAviones;

   task body T_TareaAvion is
      avion            : T_RecordAvion;
      inicio_espera    : Ada.Real_Time.Time; -- Momento en el que inicia la espera
      tiempo_espera    : Duration;
      permiso_descenso : Boolean := False;

   begin
      avion := ptr_avion.all;
      inicio_espera := Ada.Real_Time.Clock;

      -- Verificar si hay espacio en la zona segura antes de aparecer
      --pkg_memoria_compartida.ocupacion_aerovias(avion.aerovia).check_espacio;

      -- Medir el tiempo de espera
      tiempo_espera := Ada.Real_Time.To_Duration(Ada.Real_Time.Clock - inicio_espera);

      if tiempo_espera > 1.0 then
         avion.color := Yellow;
      end if;

      -- Marcar la zona segura como ocupada antes de aparecer
      pkg_memoria_compartida.ocupacion_aerovias(avion.aerovia).marcar_zona_segura(PKG_graficos.Posicion_ZonaEspacioAereo(avion.pos.X));

      Aparece(avion);

      while True loop
         pkg_memoria_compartida.ocupacion_aerovias(avion.aerovia).liberar_zona_segura(PKG_graficos.Posicion_ZonaEspacioAereo(avion.pos.X));

         select
            -- Solicitar permiso de descenso
            PKG_Torre_Control.Tarea_Torre_Control.Solicitar_Descenso(aerovia_actual => avion.aerovia, permiso => permiso_descenso);
         then abort
            -- No recibe el permiso, me sigo moviendo
            Actualiza_Movimiento(avion);
            Aparece(avion);
            delay Duration(RETARDO_MOVIMIENTO);
         end select;


         if permiso_descenso then
            -- Cambiar a la aerovía inferior si se concede el permiso
            avion.aerovia := avion.aerovia - 1;
            avion.color := Blue;

            -- Actualizar posición en la nueva aerovía
            pkg_memoria_compartida.ocupacion_aerovias(avion.aerovia).marcar_zona_segura(PKG_graficos.Posicion_ZonaEspacioAereo(avion.pos.X));

            -- Esta función debería actualizar la posición del avión
            Actualiza_Movimiento(avion);
            Aparece(avion);

            -- Verificar si llegó a la última aerovía (para aterrizar)
            if avion.aerovia = T_Rango_AeroVia'First then
               Desaparece(avion);
               exit;
            end if;
         end if;
      end loop;


   exception
      when pkg_tipos.DETECTADA_POSIBLE_COLISION =>
         Desaparece(avion);
         Ada.Text_IO.Put_Line("Posible colisión detectada con avión " & T_IdAvion'Image(ptr_avion.id));

      when others =>
         Ada.Text_IO.Put_Line("ERROR en TASK Avion");

   end T_TareaAvion;

end pkg_creacion_aviones;

