package pkg_tareas_dinamicas is
   MIN_VELOCIDAD_AVION  : CONSTANT := -10;
   MAX_VELOCIDAD_AVION : CONSTANT := 10;
   VELOCIDAD_VUELO     : CONSTANT := 5;
   NUM_INICIAL_AVIONES_AEROVIA : CONSTANT := 3;
   NUM_AEROVIAS : CONSTANT := 6;
   type T_RangoVelocidad is new integer range MIN_VELOCIDAD_AVION..MAX_VELOCIDAD_AVION;
   -- identificador num�rico de cada avi�n
   type T_IdAvion is mod NUM_INICIAL_AVIONES_AEROVIA;
   -- rango del n�mero de aerovias de distintas altitudes
   type T_Rango_AeroVia is new integer range 1..NUM_AEROVIAS;
   -- velocidad de los aviones en los ejes X e Y
   type T_Velocidad is
   record
      X : T_RangoVelocidad;
      Y : T_RangoVelocidad;
   end record;
   -- tipo registro para almacenar los datos de un avi�n
   type T_RecordAvion is
   record
      id                     : T_IdAvion;  -- identificador del avion
      velocidad        : T_Velocidad;
      aerovia            : T_Rango_AeroVia;
      tren_aterrizaje : Boolean;
   end record;
   type Ptr_T_RecordAvion is access T_RecordAvion;
   TASK TareaGeneraAviones;
   -- Tipo tarea encargada del comportamiento de un avion
   TASK TYPE T_TareaAvion(ptr_avion : Ptr_T_RecordAvion);
   type Ptr_TareaAvion is access T_TareaAvion;
end pkg_tareas_dinamicas;

-- Se definen las constantes, tipos y tareas que se utilizan
