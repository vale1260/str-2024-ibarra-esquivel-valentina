with PKG_tipos; use PKG_tipos;

package pkg_memoria_compartida is
   protected type T_OcupacionAerovia is     -- Tipo protegido que gestiona la ocupacion de una aerovia
      entry check_espacio;                  -- Verifica si hay espacio en la aerovia
      procedure incrementar;                -- Incrementa el contador de aviones en la aerovia
      procedure decrementar;                -- Decrementa el contador de aviones en la aerovia
      function esta_ocupada return Boolean; -- Verifica si la aerovia esta ocupada

      procedure marcar_zona_segura(X : T_Rango_Rejilla_X);  -- Verifica y marca las celdas en la zona
      procedure liberar_zona_segura(X : T_Rango_Rejilla_X); -- Libera la zona ocupada al moverse

   private
      ocupacion : T_Rejilla_Ocupacion := (others => False); -- Inicializo el falso
      contador  : Integer := 0; -- Contador de aviones en la aerovia
   end T_OcupacionAerovia;

   -- Defino array de aerovias ocupadas
   ocupacion_aerovias : array(PKG_tipos.T_Rango_AeroVia) of T_OcupacionAerovia;
end pkg_memoria_compartida;
