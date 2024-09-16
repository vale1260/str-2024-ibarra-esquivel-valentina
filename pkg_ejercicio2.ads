package pkg_ejercicio2 is
   -- Declaraci�n del tipo TdiasSemana
   type TdiasSemana is (Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, Domingo);

   -- Declaraci�n de una variable p�blica
   numAlumnos : Integer := 16;

   -- Procedimiento previamente definido
   procedure otroMensaje;

   -- Nueva funcion publica para acceder a la variable privada
   function obtenerNotaMedia return float;

private
   -- Declaraci�n de la variable privada
   notaMedia : Float := 5.69;
end pkg_ejercicio2;
