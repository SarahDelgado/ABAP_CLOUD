CLASS zcl_ejerc_tablas_bbdd_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejerc_tablas_bbdd_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "EJERCICIOS"
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  "Usando la tabla de base de datos /dmo/airoport.

  "1. Extraer todos los registros del campo country = UK.

  SELECT FROM /dmo/airport
  FIELDS *
  WHERE country = 'UK'
  INTO TABLE @DATA(lt_flights).

  IF sy-subrc = 0.
    out->write( 'Ejercicio 1: Todos los registros con el campo country = UK' ).
    out->write( lt_flights ).
    out->write( ' ' ).
  ENDIF.

  "2. Extraer únicamente el nombre(del campo nombre) que esta asociado a LGW del campo airport_id.

  SELECT FROM /dmo/airport
  FIELDS name
  WHERE airport_id = 'LGW'
  INTO TABLE @DATA(lt_flights2).

  IF sy-subrc = 0.
    out->write( 'Ejercicio 2: El campo nombre que esta asociado a LGW en el campo airport_id' ).
    out->write( lt_flights2 ).
    out->write( ' ' ).
  ENDIF.

  "3. Extraer con la tabla sorted todos los registros donde country sea igual a IT

  DATA lt_flights_sorted TYPE SORTED TABLE OF /dmo/airport WITH NON-UNIQUE KEY airport_id.

  SELECT FROM /dmo/airport
  FIELDS *
  WHERE country = 'IT'
  INTO TABLE @lt_flights_sorted.

  IF sy-subrc = 0.
    out->write( 'Ejercicio 3: Usando una tabla sorted, todos los registros donde country = IT' ).
    out->write( lt_flights_sorted ).
    out->write( ' ' ).
  ENDIF.

  ENDMETHOD.
ENDCLASS.
