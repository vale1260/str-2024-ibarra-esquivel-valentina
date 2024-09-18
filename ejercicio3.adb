with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with pkg_ejercicio2;

procedure ejercicio3 is

   package Dias_IO is new Ada.Text_IO.Enumeration_IO(pkg_ejercicio2.TdiasSemana);

begin
   -- Imprimir la variable p�blica numAlumnos
   Ada.Text_IO.Put_Line("N�mero de alumnos: ");
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

   -- Solicitar al usuario un d�a de la semana
   Ada.Text_IO.Put_Line("Introduce un dia de la semana: ");
   declare
      dia_usuario : pkg_ejercicio2.TdiasSemana;
   begin
      Dias_IO.Get(dia_usuario);

   -- Verificar si hay clases de STR ese d�a
      case dia_usuario is
         when pkg_ejercicio2.Lunes =>
            Ada.Text_IO.Put_Line("El Lunes hay clases de STR");
         when others =>
            Ada.Text_IO.Put_Line("El " & pkg_ejercicio2.TdiasSemana'Image(dia_usuario) & " no hay clases de STR");
      end case;
   exception
      when Ada.Text_IO.Data_Error =>
         Ada.Text_IO.Put_Line("El valor introducido no es un d�a v�lido.");
   end;
end ejercicio3;
