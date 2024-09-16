package pkg_ejercicio2 is
   -- Declaración del tipo TdiasSemana
   type TdiasSemana is (Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo);

   -- Declaración de una variable pública
   numAlumnos : Integer := 16;

   -- Procedimiento previamente definido
   procedure otroMensaje;

   -- Nueva funcion publica para acceder a la variable privada
   function obtenerNotaMedia return float;

private
   -- Declaración de la variable privada
   notaMedia : Float := 5.69;
end pkg_ejercicio2;
