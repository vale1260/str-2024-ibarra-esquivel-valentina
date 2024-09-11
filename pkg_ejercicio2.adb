with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
package body pkg_ejercicio2 is

   procedure otroMensaje is
   begin
      Ada.Text_IO.Put_Line("Vamos a iniciarnos en el lenguaje Ada");
   end otroMensaje;

   -- Procedimiento para imprimir la nota media
   procedure imprimirNotaMedia is
   begin
      Ada.Text_IO.Put("Nota media: ");
      Ada.Float_Text_IO.Put(notaMedia, Aft => 1);  -- Un solo decimal
      Ada.Text_IO.New_Line;
   end imprimirNotaMedia;

end pkg_ejercicio2;
