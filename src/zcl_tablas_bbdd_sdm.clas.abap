CLASS zcl_tablas_bbdd_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablas_bbdd_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "SELECCIONAR REGISTROS Y CAMPOS DE UNA TABLA DE BASE DE DATOS Y GUARDARLOS EN UNA TABLA INTERNA
  SELECT FROM /dmo/airport
  FIELDS *
  WHERE country EQ 'DE' "EQ = equals, sería lo mismo que usar el signo igual =
  INTO TABLE @DATA(lt_flights).

  "Comprueba si la consulta se ha ejecutado correctamente, es decir, si la consulta ha obtenido resultados
  IF sy-subrc = 0.
    out->write( lt_flights ).
    "READ: se utiliza para leer una linea especifica de una tabla interna en tiempo de ejecucion, nos permite recuperar datos de una tabla de manera eficiente
    READ TABLE lt_flights INTO DATA(ls_fligth) index 1. "Trae una linea concreta cons los registros de la tabla de la base de datos
    out->write( ls_fligth ).
    READ TABLE lt_flights INTO DATA(ls_fligth2) INDEX 2 TRANSPORTING airport_id city."Usando transporting seleccionamos los campos que queremos obtener
    out->write( ls_fligth2 ).
    "Usando la clave en vez del índice, solo obtiene el primer registro que coincida con la clave
    READ TABLE lt_flights INTO DATA(ls_fligth3) WITH KEY city = 'Berlin'.
    out->write( ls_fligth3 ).
    "Forma moderna de hacer lo mismo, es mejor usar esta
    DATA(ls_fligth4) = lt_flights[ city = 'Berlin' ].
    out->write( ls_fligth4 ).
    "Para extraer solo un campo usando la forma moderna
    DATA(ls_fligth5) = lt_flights[ city = 'Berlin' ]-airport_id.
    out->write( ls_fligth5 ).
  ENDIF.

  "Usando una tabla sorted con clave primaria
  DATA lt_flights_sorted TYPE SORTED TABLE OF /dmo/airport WITH NON-UNIQUE KEY airport_id.

  IF sy-subrc = 0.
  SELECT FROM /dmo/airport
  FIELDS *
  INTO TABLE @lt_flights_sorted.
  "Usando READ
  READ TABLE lt_flights_sorted into data(ls_flight6) WITH TABLE KEY airport_id = 'LAS'.
  out->write( ls_flight6 ).
  "Usando la forma moderna
  DATA(ls_flight7) = lt_flights_sorted[ key primary_key airport_id = 'LAS' ].
  ENDIF.


  SELECT FROM /dmo/flight
  FIELDS *
  WHERE carrier_id = 'LH'
  INTO TABLE @DATA(lt_flights_standard).
  "Para comprobar si existe en la base de datos, no necesitamos que nos traiga valores, por lo que usamos TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    READ TABLE lt_flights_standard WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
        out->write( 'El vuelo existe en la BD.' ).
    ELSE.
        out->write( 'El vuelo no existe en la BD.' ).
    ENDIF.
  ENDIF.


  "OBTENER EL INDICE DE UN REGISTRO
  SELECT FROM /dmo/flight
  FIELDS *
  INTO TABLE @DATA(lt_flights_standard2).

  IF sy-subrc = 0.
    DATA(lv_index) = line_index( lt_flights_standard2[ connection_id = '0322' ] ).
    out->write( lv_index ).
  ENDIF.

  "Para filtrar los datos de un registro usando loop at
  LOOP AT lt_flights_standard2 INTO DATA(ls_vuelo) WHERE connection_id = '0015'.
    out->write( ls_vuelo ).
  ENDLOOP.

  "
  SELECT FROM /dmo/flight
  FIELDS *
  WHERE carrier_id = 'LH'
  INTO TABLE @DATA(lt_vuelos).

  IF sy-subrc = 0.
    SELECT carrier_id, connection_id
    FROM @lt_vuelos as lt
    INTO TABLE @DATA(lt_copia).

    out->write( lt_vuelos ).
    out->write( lt_copia ).
  ENDIF.


   ENDMETHOD.
ENDCLASS.
