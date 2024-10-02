with Ada.Text_IO; use Ada.Text_IO;
with Pkg_Tipos; use Pkg_Tipos;
with Pkg_Graficos; use Pkg_Graficos;
with Pkg_Debug; use Pkg_Debug;
package body pkg_creacion_aviones is

   task body TareaGeneraAviones is
      tarea_avion : Ptr_TareaAvion;
      ptr_avion   : Ptr_T_RecordAvion;

      package pkg_RetardoAleatorio is new Ada.Numerics.Discrete_Random(T_RetardoAparicionAviones);

      generador_num : pkg_RetardoAleatorio.Generator;
      rand_num      : Integer;

   begin
      pkg_RetardoAleatorio.Reset(generador_num);

      for id in T_IdAvion loop
         for aerovia in T_Rango_Aerovia'First..T_Rango_Aerovia'Last - 2 loop
            -- Inicializar los datos de un nuevo avión
            ptr_avion := new T_RecordAvion;
            ptr_avion.id := id;
            ptr_avion.velocidad.x := VELOCIDAD_VUELO * (if aerovia mod 2 = 0 then -1 else 1);
            ptr_avion.velocidad.y := 0;
            ptr_avion.aerovia := aerovia;
            ptr_avion.tren_aterrizaje := False;
            ptr_avion.pista := SIN_PISTA;
            ptr_avion.color := BLUE;
            ptr_avion.aerovia_inicial := aerovia;
            ptr_avion.pos := Pos_Inicio(aerovia);


            -- Crear la tarea para el comportamiento del avión
            tarea_avion := new T_TareaAvion(ptr_avion);

            rand_num := pkg_RetardoAleatorio.Random(generador_num);
            delay Duration(rand_num);
         end loop;
      end loop;
   end TareaGeneraAviones;

   task body T_TareaAvion is
   begin
      -- Imprimir los detalles del avión en el log
      Pkg_Debug.Escribir("TASK Avion: " & T_IdAvion'Image(ptr_avion.id) &
                         " - Aerovia: " & T_Rango_Aerovia'Image(ptr_avion.aerovia));

      -- Mostrar el avión en la pantalla
      Aparece(ptr_avion);

      loop
         -- Simular movimiento
         Actualiza_Movimiento(ptr_avion.id);
         delay Pkg_Tipos.RETARDO_MOVIMIENTO;
      end loop;

         -- Manejar posible colisión
         exception
            when pkg_tipos.DETECTADA_POSIBLE_COLISION =>
               Pkg_Debug.Escribir("Posible colisión detectada con avión " & T_IdAvion'Image(ptr_avion.id));
               Desaparece(ptr_avion.id);
               return;

            when others =>
               Pkg_Debug.Escribir("ERROR en TASK Avion: " & Exception_Name(Exception_Identity));
               return;
   end T_TareaAvion;

end pkg_creacion_aviones;
