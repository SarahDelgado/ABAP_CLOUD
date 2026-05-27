CLASS zcl_ejerc_tablas_rangos_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejerc_tablas_rangos_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "Trabajas para una agencia de viajes que necesita filtrar vuelos según distintos criterios comerciales.
  "Vas a construir varias tablas de rangos y usarlas para consultar /dmo/flight.

  "Tarea 1: Compañías concretas (I + EQ): Crea una range table que seleccione unicamente los vuelos de las compañias AA, LH y SQ.
  DATA lr_company TYPE RANGE OF /dmo/carrier_id.
  APPEND VALUE #( sign = 'I' option = 'EQ' low = 'AA' ) to lr_company.
  APPEND VALUE #( sign = 'I' option = 'EQ' low = 'LH' ) to lr_company.
  APPEND VALUE #( sign = 'I' option = 'EQ' low = 'SQ' ) to lr_company.

  "Forma moderna:
  TYPES tt_carrier_id TYPE RANGE OF /dmo/carrier_id.
  data(lr_company2) = VALUE tt_carrier_id(
                            ( sign = 'I' option = 'EQ' low = 'AA' )
                            ( sign = 'I' option = 'EQ' low = 'LH' )
                            ( sign = 'I' option = 'EQ' low = 'SQ' ) ).

  "Tarea 2: Rango de fechas (I + BT) Crea una range table que seleccione los vuelos cuya fecha esté entre el 01.01.2025 y el 30.06.2026 (ambos incluidos)
  DATA lr_fecha TYPE RANGE OF /dmo/flight_date.
  APPEND VALUE #( sign = 'I' option = 'BT' low = '20250101' high = '20260630' ) to lr_fecha.

  "Forma moderna:
  TYPES tt_fecha TYPE RANGE OF /dmo/flight_date.
  data(lr_fecha2) = VALUE tt_fecha( ( sign = 'I' option = 'BT' low = '20250101' high = '20260630' ) ).


  "Tarea 3: Patrón de conexión(I + CP): Crea una range table que seleccione las conexiones cuyo numero empiece por 1 (es decir, 1xxx).
  "DATA lr_connection TYPE RANGE OF /dmo/connection_id.
  "APPEND VALUE #( sign = 'I' option = 'BT' low = '1000' HIGH = '2000' ) to lr_connection.
  DATA lr_connection type RANGE OF string.
  APPEND value #( sign = 'I' option = 'CP' low = '1*' ) to lr_connection.

  "Tarea 4: Exclusión(E + EQ): Crea una range table que seleccione todas las compañías excepto UA.
  DATA lr_company_ex TYPE RANGE OF /dmo/carrier_id.
  APPEND VALUE #( sign = 'E' option = 'EQ' low = 'UA' ) to lr_company_ex.

  "Tarea 5: Precio( I + GT y I + LE): Crea una range table que seleccione los vuelos con precio mayor que 100 y, en una segunda linea, los precios menor o igual que 50(dos tramos misma tabla)
  DATA lr_price TYPE RANGE OF /dmo/flight_price.
  APPEND VALUE #( sign = 'I' option = 'GT' low = '100' ) to lr_price.
  APPEND VALUE #( sign = 'I' option = 'LE' low = '50' ) to lr_price.

  "Forma moderna:
  TYPES tt_price TYPE RANGE OF /dmo/flight_price.
  data(lr_price2) = VALUE tt_price(
                            ( sign = 'I' option = 'GT' low = '100' )
                            ( sign = 'I' option = 'LE' low = '50' ) ).

  "Tarea 6: Consulta combinada. Lanza un SELECT sobre /dmo/flight que use simultaneamente los rangos de las tareas 1, 2 y 4, muestra cuantas lineas devuelve.

  SELECT FROM /dmo/flight
      FIELDS carrier_id, connection_id, flight_date, price
      WHERE carrier_id  IN @lr_company
        AND carrier_id  IN @lr_company_ex
        AND flight_date IN @lr_fecha
      INTO TABLE @DATA(flights).

   LOOP AT flights INTO DATA(ls_vuelo).
      out->write( ls_vuelo ).
  ENDLOOP.


  SELECT FROM /dmo/flight
      FIELDS connection_id
      WHERE connection_id IN @lr_connection
      INTO TABLE @DATA(flights2).

  LOOP AT flights2 INTO DATA(ls_vuelo2).
      out->write( ls_vuelo2 ).
  ENDLOOP.

  ENDMETHOD.
ENDCLASS.
