with Ada.Text_IO;
with Ada.Integer_Text_IO;
with pkg_ejercicio2;
use Ada.Text_IO;

procedure Ejercicio1 is
   s : String := "Comenzamos las practicas STR";
   Mes : Natural;

begin
   Put("Hola mundo");
   pkg_ejercicio2.otroMensaje;

   -- Lectura del n�mero de mes
   Ada.Text_IO.Put_Line("Introduce el n�mero del mes (1-12): ");

   -- Bloque para manejar el flujo principal
   begin
      Ada.Integer_Text_IO.Get(Mes);

      -- Sentencia case para determinar la estaci�n del a�o
      case Mes is
         when 1 | 2 | 12 =>
            Ada.Text_IO.Put_Line("Invierno");
         when 3 | 4 | 5 => -- Tambien se puede escribir como 3..4
            Ada.Text_IO.Put_Line("Primavera");
         when 6 | 7 | 8 =>
            Ada.Text_IO.Put_Line("Verano");
         when 9 | 10 | 11 =>
            Ada.Text_IO.Put_Line("Oto�o");
         when others =>
            Ada.Text_IO.Put_Line("Mes incorrecto");
      end case;

   exception
      when Ada.Text_IO.Data_Error =>
         Ada.Text_IO.Put_Line("Entrada no v�lida. Por favor, introduce un n�mero.");
      when Constraint_Error =>
         Ada.Text_IO.Put_Line("El n�mero de mes debe ser > 0");
      when others =>
         Ada.Text_IO.Put_Line("Ha ocurrido un error inesperado.");
   end;

   -- Esta sentencia siempre se ejecutar� al final del programa
   Ada.Text_IO.Put_Line("FIN DEL PROGRAMA");

end Ejercicio1;


