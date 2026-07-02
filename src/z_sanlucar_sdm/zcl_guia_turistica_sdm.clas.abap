CLASS zcl_guia_turistica_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_guia_turistica_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lt_guias TYPE TABLE OF REF TO zif_negocio_sanlucar_sdm.

    APPEND NEW zcl_bodega_sanlucar_sdm( ) TO lt_guias.

    APPEND NEW zcl_marisqueria_sanlucar_sdm( ) TO lt_guias.

    APPEND  NEW zcl_hipodromo_sanlucar_sdm( ) TO lt_guias.

    LOOP AT lt_guias INTO DATA(lo_guia).
      out->write( |[{ lo_guia->get_tipo( ) }] { lo_guia->get_nombre( ) } - { lo_guia->get_descripcion( ) } (Precio: { lo_guia->calcular_precio( ) DECIMALS = 2 } €)| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
