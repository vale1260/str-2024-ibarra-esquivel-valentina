with Ada.Numerics.Float_Random;
with Ada.Float_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;

procedure numerosAleatorios is
   -- Declarar el tipo Generator del paquete Ada.Numerics.Float_Random
   generador : Ada.Numerics.Float_Random.Generator;
   numero    : Float;
begin
   -- Inicializa el generador de números aleatorios
   Ada.Numerics.Float_Random.Reset(generador);

   -- Bucle para generar y mostrar números aleatorios
   loop
      -- Generar número aleatorio en el rango 0.0 .. 1.0
      numero := Ada.Numerics.Float_Random.Random(generador);

      -- Mostrar el número con 4 decimales
      Put("Número aleatorio: ");
      Ada.Float_Text_IO.Put(numero, Fore => 1, Aft => 4);
      New_Line;
   end loop;

end numerosAleatorios;
