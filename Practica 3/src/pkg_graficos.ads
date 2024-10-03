--************************ PAQUETE PKG_GRAFICOS ***************************
-- Este paquete se encarga de implementar la interfaz gráfica
--*************************************************************************

with pkg_tipos; USE pkg_tipos;
with PKG_bufferGenerico;
with Gdk.Types;         use Gdk.Types;
with Cairo;             use Cairo;
with Pango.Font;        use Pango.Font;
with Gtkada.Style;      use Gtkada.Style;
with Gtk.Window;        use Gtk.Window;
with Gtk.Drawing_Area;  use Gtk.Drawing_Area;
with Gtk.Handlers;      use Gtk.Handlers;
pragma Elaborate_All (Gtk.Handlers);
with Gtk.Main;          use Gtk.Main;
with Glib.Main;         use Glib.Main;
pragma Elaborate_All (Gtk.Main);
with Pango.Layout;      use Pango.Layout;
with Gdk.RGBA;
with Glib;              use Glib;
with Gdk.Pixbuf;
with Gdk.Event;         use Gdk.Event;
with Gtk.Button;        use Gtk.Button;



PACKAGE PKG_graficos IS

   -----------------------------------------------------------------
   -- DECLARACIONES DE PROCEDIMIENTOS Y FUNCIONES PÚBLICAS
   -----------------------------------------------------------------

   -- Procedure que se encarga de redibujar y capturar eventos en la
   -- interfaz gráfica
   procedure Simular_Sistema;

   -- Hacer aparecer el objeto especificado en el sistema
   PROCEDURE Aparece(avion : in T_RecordAvion);
   PROCEDURE Aparece_En_Pista(avion : in T_RecordAvion);

   -- Eliminar el objeto especificado
   PROCEDURE Desaparece(avion : in T_RecordAvion);
   PROCEDURE Desaparece_En_Pista(avion : in T_RecordAvion);

   -- Función que devuelve las coordenadas de la posición inicial de un objeto
   FUNCTION Pos_Inicio(aerovia : T_Rango_AeroVia) RETURN T_Punto;
   FUNCTION Pos_Inicio(pos_x: T_CoordenadaX; aerovia : T_Rango_AeroVia) RETURN T_Punto;
   FUNCTION Pos_Inicio(pista : T_PistaAterrizaje) RETURN T_Punto;


   -- Actualiza el movimiento de un avion dependiendo de su velocidad
   PROCEDURE Actualiza_Movimiento(avion : IN OUT T_RecordAvion);
   PROCEDURE Actualiza_Movimiento_En_Pista(avion : IN OUT T_RecordAvion);

   -- calcula la nueva posición de la coordenad X, comprobando los límites de una aerovía
   -- y teniendo en cuenta un movimiento cíclico en la misma
   function Nueva_PosicionX(pos_actual_x : T_CoordenadaX; vel_x : T_RangoVelocidad) return T_CoordenadaX;


   -- comprueba si se ya llegado al final de la pista de aterrizaje
   function Fin_Aterrizaje(pos_y : T_CoordenadaY) return Boolean;

   -- actualiza el valor del cronómetro
   PROCEDURE Actualiza_Cronometro(tiempo_transcurrido: Duration);

   -- calcula y actualiza la velocidad de aterrizaje, reduciéndola
   procedure Reduce_Velocidad_Aterrizaje(avion: in out T_RecordAvion);


   subtype T_Area_Dibujo_Record is Gtk.Drawing_Area.Gtk_Drawing_Area_Record;

   type T_Area_Dibujo is access all T_Area_Dibujo_Record'Class;


   -----------------------------------------------------------------
   -- DECLARACIONES PRIVADAS
   -----------------------------------------------------------------

private

      X_CRONOMETRO : CONSTANT := CANVAS_WIDTH-100;
      Y_CRONOMETRO : CONSTANT := 40;

      TAM_CRONOMETRO: CONSTANT := 7;
      hora_segundos : Glib.UTF8_String(1..TAM_CRONOMETRO) := "000.000";

      PERIODICIDAD_REDIBUJAR_MILISEGUNDOS : constant Glib.Guint := 100;

      X_INICIO_PISTA1 : CONSTANT := 150;
      X_INICIO_PISTA2 : CONSTANT := 450;
      Y_INICIO_PISTA : CONSTANT := ALTURA_AEROVIA*(NUM_AEROVIAS+1);
      ANCHO_PISTA : CONSTANT := 100;
      LONGITUD_PISTA : CONSTANT := CANVAS_HEIGHT - Y_INICIO_PISTA;


      Y_AEROVIA1 : CONSTANT := 70;
      Y_AEROVIA2 : CONSTANT := Y_AEROVIA1+ALTURA_AEROVIA;
      Y_AEROVIA3 : CONSTANT := Y_AEROVIA2+ALTURA_AEROVIA;
      Y_AEROVIA4 : CONSTANT := Y_AEROVIA3+ALTURA_AEROVIA;
      Y_AEROVIA5 : CONSTANT := Y_AEROVIA4+ALTURA_AEROVIA;
      Y_AEROVIA6 : CONSTANT := Y_AEROVIA5+ALTURA_AEROVIA;

      -- array con las filas centrales de las aerovias
      y_aerovia : array (T_Rango_AeroVia) of integer := (Y_AEROVIA1, Y_AEROVIA2, Y_AEROVIA3, Y_AEROVIA4, Y_AEROVIA5, Y_AEROVIA6);

      -- array con las columnas centrales de las pistas
      x_pista : array (T_Rango_Pista) of integer := (X_INICIO_PISTA1, X_INICIO_PISTA2);


      -- Fuentes de letra utilizados
      fuente_letra : Pango_Font;

   -- Paleta de colores utilizada
      White_RGBA : constant Gdk.RGBA.Gdk_RGBA := (1.0, 1.0, 1.0, 1.0);
      Black_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.0, 0.0, 0.0, 1.0);
      Grey_RGBA  : constant Gdk.RGBA.Gdk_RGBA := (0.75, 0.75, 0.75, 1.0);
      --Green_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.0, 1.0, 0.0, 1.0);
      Green_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.0, 0.5, 0.0, 1.0);
      Red_RGBA   : constant Gdk.RGBA.Gdk_RGBA := (0.8, 0.0, 0.0, 1.0);
      --Yellow_RGBA : constant Gdk.RGBA.Gdk_RGBA := (1.0, 1.0, 0.0, 1.0);
      Yellow_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.9, 0.9, 0.0, 1.0);
      Blue_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.0, 0.0, 1.0, 1.0);
      Cyan_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.0, 1.0, 1.0, 1.0);
      --Cyan_Light_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.9, 1.0, 1.0, 1.0);
      Gris_Fondo_RGBA : constant Gdk.RGBA.Gdk_RGBA := (0.6, 0.6, 0.6, 1.0);
      Orange_RGBA : constant Gdk.RGBA.Gdk_RGBA := (1.0, 0.5, 0.0, 1.0);

      White_Gc    : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(White_RGBA);
      Black_Gc    : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Black_RGBA);
      Grey_Gc     : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Grey_RGBA);
      Green_Gc    : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Green_RGBA);
      Red_Gc      : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Red_RGBA);
      Yellow_Gc   : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Yellow_RGBA);
      Blue_Gc     : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Blue_RGBA);
      Cyan_Gc     : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Cyan_RGBA);
      Gris_Fondo_Gc : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Gris_Fondo_RGBA);
      Orange_Gc     : constant Gtkada.Style.Cairo_Color := Gtkada.Style.To_Cairo(Orange_RGBA);

      PangoLayout: Pango_Layout;

      package Void_Cb is new Gtk.Handlers.Callback (Gtk_Window_Record);
      package Main_Context_Sources is new Glib.Main.Generic_Sources(Gtk_Drawing_Area);
      --package Gint_Timeout is new Gtk.Main.Timeout (Gtk_Drawing_Area);
      package Destroyed is new Gtk.Handlers.Callback (Widget_Type => Gtk_Window_Record);

      Procedure Draw_Objetos_Graficos (cr : Cairo_Context);
      function Draw_Area_Dibujo (area_dibujo : Gtk_Drawing_Area) return Boolean;

      procedure Quit (Win : access Gtk_Window_Record'Class);


      -- DECLARACIÓN DE BUFFERS CIRCULARES PARA GUARDAR INFORMACIÓN DE LA INTERFAZ
      package Pkg_Buffer_aviones is new Pkg_bufferGenerico(tipo_dato=>T_RecordAvion, tam=>T_RangoBufferAviones);
      buffer_aviones : array(T_Rango_AeroVia) of Pkg_Buffer_aviones.T_Buffer;

      package Pkg_Buffer_aviones_en_pista is new Pkg_bufferGenerico(tipo_dato=>T_RecordAvion, tam=>T_RangoBufferAvionesAterrizando);
      buffer_aviones_en_pista : Pkg_Buffer_aviones_en_pista.T_Buffer;

      -- Procedure que se encarga de inicializar la interfaz gráfica
      procedure Inicializar_Interfaz_Grafica;

      -- Procedure que envía un mensaje a la torre de control para activar su ejecución
      procedure Iniciar_Torre_Control(button : access Gtk_Button_Record'Class);

      -- Procedure que inicializa el buffer de aviones
      procedure Inicializar_Buffer_Aviones;

      -- Función que devuelve la posición de un avion dentro del buffer
      FUNCTION Posicion_Buffer(Id : T_IdAvion; aerovia_inicial: T_Rango_AeroVia;
                               buffer: Pkg_Buffer_aviones.T_Buffer) return T_RangoBufferAviones;

      FUNCTION Posicion_Buffer(Id : T_IdAvion; aerovia_inicial: T_Rango_AeroVia;
                            Buffer: Pkg_Buffer_aviones_en_pista.T_Buffer) RETURN T_RangoBufferAvionesAterrizando;


      -- Procedimiento que devuelve el avion mas cercano y la distancia al mismo
      -- Si no hay avion cercano, devuelve la velocidad del propio avion y distancia = 0
      PROCEDURE Detectar_Avion_Mas_Cercano(avion : IN T_RecordAvion; avion_cercano : OUT T_RecordAvion;
                                           distancia : OUT Integer);


      -- calcula la nueva posición de la coordenada Y, comprobando el límite
      -- de la pista de aterrizaje
      function Nueva_PosicionY(pos_actual_y : T_CoordenadaY; vel_y : T_RangoVelocidad) return T_CoordenadaY;


      -- Procedure que se encarga de dibujar en el canvas todos los
      -- objetos del entorno gráfico
      procedure Dibujar_Canvas(Pixmap : Cairo_Context);

      -- Procedure que se encarga de dibujar las pistas de aterrizaje
      procedure Dibujar_Pistas_Aterrizaje(Pixmap : Cairo_Context);

      -- Función que convierte un color a su correspondiente del
      -- contexto gráfico
      FUNCTION Convertir_Color_GC(Color : T_Color) RETURN Gtkada.Style.Cairo_Color;

      -- Dibujar en el canvas las líneas determinadas por un conjunto de puntos
      procedure Dibujar_Lineas(Pixmap : Cairo_Context; color : Gtkada.Style.Cairo_Color; flecha : Gdk_Points_Array; n_puntos : Integer);

      -- Dibujar en el canvas una rueda
      procedure Dibujar_Rueda(Pixmap: Cairo_Context; color_neumatico: Gtkada.Style.Cairo_Color;
                              color_llanta: Gtkada.Style.Cairo_Color; x: Gint; y: Gint;
                              diametro_neumatico:Gint; diametro_llanta: Gint);

      -- Dibujar en el canvas un avion
      procedure Dibujar_Avion(Pixmap: Cairo_Context; avion : T_RecordAvion);

      -- Dibujar las ruedas del tren de aterrizaje
      procedure Dibujar_Tren_Aterrizaje(Pixmap: Cairo_Context; avion: T_RecordAvion);

      -- Dibujar el cronometro
      PROCEDURE Dibujar_Canvas_Cronometro(Pixmap : Cairo_Context);


      function Dibujar_CairoContext (area_dibujo : access T_Area_Dibujo_Record'Class;
                                     Event       : Gdk.Event.Gdk_Event) return Boolean;
      function Posicion_Raton (area_dibujo : access T_Area_Dibujo_Record'Class;
                               Event       : Gdk.Event.Gdk_Event) return Boolean;


      procedure Crear_Area_Dibujo (area_dibujo : out T_Area_Dibujo);
      procedure Inicializar_Area_Dibujo (area_dibujo : T_Area_Dibujo);




end PKG_graficos;
