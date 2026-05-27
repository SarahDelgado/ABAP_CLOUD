CLASS zcl_tabla_rangos_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tabla_rangos_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Tablas de rango: una lista de filtros, trae las cosas que cumplan unas condiciones
    "sing -> dice si la condicion es incluir (I) o excluir (E).
    "option -> Dice el tipo de comparacion. EQ -> igual a, NE -> diferente a, GT -> mayor que, LT -> menor que, BT -> entre
    "low -> el valor mínimo o valor exacto
    "high -> el valor máximo(solo se usa con "entre" BT)

    "Ejemplo: una lista de coches, quieres los rojos, los azules y no quieres los amarillos
    "sing            option       low       high
    "i                 eq         rojo
    "i                 eq         azul
    "e                 eq         amarillo


    "Creamos la tabla de filtracion usando una tabla de rangos
    DATA lr_asientos TYPE RANGE OF /dmo/plane_seats_occupied.
    out->write(  lr_asientos ).

    "Vuelos con asientos que esten entre 50 y 100
    APPEND VALUE #( sign = 'I' option = 'BT' low = 50 high = 100 ) TO lr_asientos.

    "Vuelos con exactamente 150 asientos
    APPEND VALUE #( sign = 'I' option = 'EQ' low = 141 ) TO lr_asientos.

    "Vuelos que no tengan menos de 10 asientos
    APPEND VALUE #( sign = 'E' option = 'LT' low = 10 ) TO lr_asientos.


    DATA lt_vuelos TYPE TABLE OF /dmo/flight.

    SELECT * FROM /dmo/flight
    WHERE seats_occupied IN @lr_asientos
    INTO TABLE @lt_vuelos.

    LOOP AT lt_vuelos INTO DATA(ls_vuelo).
        IF ls_vuelo-carrier_id = 'UA'.
            out->write( ls_vuelo ).
        ENDIF.
    ENDLOOP.





  ENDMETHOD.
ENDCLASS.
