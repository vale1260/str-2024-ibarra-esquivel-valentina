with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Float_Text_IO;
package body pkg_ejercicio2 is

   procedure otroMensaje is
   begin
      Ada.Text_IO.Put_Line("Vamos a iniciarnos en el lenguaje Ada");
   end otroMensaje;

   -- Funcion para imprimir nota media
   function obtenerNotaMedia return float is
   begin
      return notaMedia;
   end obtenerNotaMedia;

end pkg_ejercicio2;
