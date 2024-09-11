with Ada.Text_IO;
with Ada.Integer_Text_IO;
with pkg_ejercicio2;

procedure ejercicio3 is
   -- Procedimiento para convertir TdiasSemana a String
   function Dia_Semana_To_String(dia : pkg_ejercicio2.TdiasSemana) return String is
   begin
      case dia is
         when pkg_ejercicio2.Lunes     => return "Lunes";
         when pkg_ejercicio2.Martes    => return "Martes";
         when pkg_ejercicio2.Miercoles => return "Miercoles";
         when pkg_ejercicio2.Jueves    => return "Jueves";
         when pkg_ejercicio2.Viernes   => return "Viernes";
         when pkg_ejercicio2.Sabado    => return "Sabado";
         when pkg_ejercicio2.Domingo   => return "Domingo";
      end case;
   end Dia_Semana_To_String;

begin
   -- Imprimir la variable p�blica numAlumnos
   Ada.Text_IO.Put_Line("N�mero de alumnos: ");
   Ada.Integer_Text_IO.Put(pkg_ejercicio2.numAlumnos);
   Ada.Text_IO.New_Line;

   -- Llamar al procedimiento del paquete que imprime la nota media
   pkg_ejercicio2.imprimirNotaMedia;

   -- Recorrer los valores del tipo TdiasSemana y mostrarlos
   for dia in pkg_ejercicio2.TdiasSemana loop
      Ada.Text_IO.Put_Line(Dia_Semana_To_String(dia));
   end loop;
end ejercicio3;

-- La variable notaMedia est� en la parte privada del paquete,
-- por lo que no puede ser accedida directamente desde fuera del paquete (como desde ejercicio3).

-- Soluci�n: Se crea el procedimiento imprimirNotaMedia dentro del paquete pkg_ejercicio2 que accede
-- a la variable privada y la imprime. Este procedimiento es p�blico, por lo que puede ser llamado
-- desde ejercicio3.

-- ejercicio3 invoca a pkg_ejercicio2.imprimirNotaMedia para imprimir el valor de la variable privada
-- notaMedia sin violar las restricciones de visibilidad.
