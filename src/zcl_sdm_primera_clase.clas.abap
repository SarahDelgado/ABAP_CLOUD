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

    "Mostrar información por consola"
    OUT->write( |Variable de lv edad: { lv_number } Variable de lv_total: { lv_total } | ).


    DATA: lv_string TYPE STRING,
          lv_int TYPE I,
          lv_fecha TYPE D,
          lv_dec TYPE P LENGTH 8 DECIMALS 2 VALUE '300.99',
          lv_car TYPE C LENGTH 10 VALUE 'experis'.

         lv_fecha = '20260512'.
         lv_string = '20260512'.

         OUT->WRITE( lv_string ).
         OUT->WRITE( lv_int ).
         OUT->WRITE( lv_fecha ).
         OUT->WRITE( lv_dec ).
         OUT->WRITE( lv_car ).




  ENDMETHOD.

ENDCLASS.
