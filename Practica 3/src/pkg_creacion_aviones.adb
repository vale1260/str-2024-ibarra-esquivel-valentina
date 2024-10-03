package body pkg_creacion_aviones is

   task body TareaGeneraAviones is
      tarea_avion : Ptr_TareaAvion;
      ptr_avion   : Ptr_T_RecordAvion;

      package pkg_generadorRetardo is new Ada.Numerics.Discrete_Random(T_RetardoAparicionAviones);

      generador_retardo : pkg_generadorRetardo.Generator;

   begin
      pkg_generadorRetardo.Reset(generador_retardo);

      for id in T_IdAvion loop
         for aerovia in T_Rango_Aerovia'First..T_Rango_Aerovia'Last - 2 loop
            -- Inicializar los datos de un nuevo avión
            ptr_avion := new T_RecordAvion;

            ptr_avion.id := id;
            ptr_avion.velocidad.x := VELOCIDAD_VUELO;
            ptr_avion.velocidad.y := 0;
            ptr_avion.aerovia := aerovia;
            ptr_avion.tren_aterrizaje := False;
            ptr_avion.aerovia_inicial := aerovia;
            ptr_avion.pista := SIN_PISTA;
            ptr_avion.color := BLUE;
            ptr_avion.pos := Pos_Inicio(aerovia);


            -- Crear la tarea para el comportamiento del avión
            tarea_avion := new T_TareaAvion(ptr_avion);

            delay(Duration(pkg_generadorRetardo.random(generador_retardo)));
         end loop;
      end loop;
   end TareaGeneraAviones;

   task body T_TareaAvion is
      avion : T_RecordAvion;
   begin
      avion := ptr_avion.all;

      -- Imprimir los detalles del avión en el log
      Pkg_Debug.Escribir("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) &
                         " - Aerovia: " & T_Rango_Aerovia'Image(ptr_avion.aerovia));

      -- Cambiar direccion
      if avion.aerovia = 1 or avion.aerovia = 3 then
         avion.velocidad.X := -VELOCIDAD_VUELO;
      else
         avion.velocidad.X := VELOCIDAD_VUELO;
      end if;

      Escribir(cadena => "Info del vuelo");
      -- Mostrar el avión en la pantalla
      Aparece(avion);

      while True loop
         -- Simular movimiento
         Actualiza_Movimiento(avion);
         delay(Duration(RETARDO_MOVIMIENTO));
      end loop;

         -- Manejar posible colisión
   exception
      when pkg_tipos.DETECTADA_COLISION =>
         Desaparece(avion);
         Escribir("Posible colisión detectada con avión " & T_IdAvion'Image(ptr_avion.id));

      when others =>
         Escribir("ERROR en TASK Avion: ");

   end T_TareaAvion;

end pkg_creacion_aviones;
