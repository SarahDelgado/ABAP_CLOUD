CLASS zcl_sdm_primera_clase DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sdm_primera_clase IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    "Tipo cadena de texto"
    DATA lv_name TYPE string.
    lv_name = 'Pedro'.
    DATA lv_name2 TYPE string VALUE 'Laura'.

    "Tipo entero I"
    DATA lv_number TYPE I.
    lv_number = 26.
    DATA lv_number2 TYPE I VALUE 33.

    "Suma de variables"
    DATA lv_total TYPE I.
    lv_total = lv_number + lv_number2.

    "Sacar información por consola"

    OUT->write( lv_total ).

  ENDMETHOD.

ENDCLASS.
