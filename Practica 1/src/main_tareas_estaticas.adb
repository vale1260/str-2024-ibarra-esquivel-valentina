with pkg_tareas_estaticas; use pkg_tareas_estaticas;

procedure main_tareas_estaticas is
   tarea1 : T_Tarea(0,9);
   tarea2 : T_Tarea(10,99);
   tarea3 : T_Tarea(100,999);
begin
   null;
end main_tareas_estaticas;


-- 7a) La sentencia null; no realiza ninguna acción en el cuerpo del procedimiento main_tareas_estaticas.
--     Sin embargo, las tarea1, tarea2 y tarea3, se ejecutarán independientemente de la ausencia de acciones
--     explícitas en el bloque principal.
--     Las tareas se ejecutan concurrentemente y no requieren una llamada explícita para activarse.

-- 7c) En la parte final del cuerpo de un paquete, se pueden incluir sentencias ejecutables que se ejecutan
--     una única vez al elaborar el paquete.
