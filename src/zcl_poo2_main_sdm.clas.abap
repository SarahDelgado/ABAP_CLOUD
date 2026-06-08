CLASS zcl_poo2_main_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_poo2_main_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_nombre) = new zcl_poo2_sdm(  ).


  ENDMETHOD.
ENDCLASS.
