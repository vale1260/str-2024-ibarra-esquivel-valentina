with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with pkg_ejercicio2;

procedure ejercicio3 is

   package Dias_IO is new Ada.Text_IO.Enumeration_IO(Enum => pkg_ejercicio2.TdiasSemana);

begin
   -- Imprimir la variable pública numAlumnos
   Ada.Text_IO.Put_Line("Número de alumnos: ");
   Ada.Integer_Text_IO.Put(pkg_ejercicio2.numAlumnos);
   Ada.Text_IO.New_Line;

   -- Llamar a la funcion que imprime la nota media
   Ada.Text_IO.Put("Nota media: ");
   Ada.Float_Text_IO.Put(pkg_ejercicio2.obtenerNotaMedia, Aft => 1);
   Ada.Text_IO.New_Line;

   -- Recorrer los valores del tipo TdiasSemana y mostrarlos
   for dia in pkg_ejercicio2.TdiasSemana loop
      Dias_IO.Put(dia);
      Ada.Text_IO.New_Line;
   end loop;

end ejercicio3;

-- La variable notaMedia está en la parte privada del paquete,
-- por lo que no puede ser accedida directamente desde fuera del paquete (como desde ejercicio3).

-- Solución: Se crea el procedimiento imprimirNotaMedia dentro del paquete pkg_ejercicio2 que accede
-- a la variable privada y la imprime. Este procedimiento es público, por lo que puede ser llamado
-- desde ejercicio3.

-- ejercicio3 invoca a pkg_ejercicio2.imprimirNotaMedia para imprimir el valor de la variable privada
-- notaMedia sin violar las restricciones de visibilidad.
