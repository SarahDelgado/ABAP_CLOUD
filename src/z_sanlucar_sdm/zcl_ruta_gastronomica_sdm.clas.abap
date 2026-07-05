CLASS zcl_ruta_gastronomica_sdm DEFINITION
  PUBLIC
  INHERITING FROM zcl_experiencia_sdm
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: num_tapas   TYPE i,
          es_nocturno TYPE abap_bool.

    METHODS:
      constructor
        IMPORTING
          iv_nombre            TYPE string
          iv_precio_base       TYPE p
          iv_duracion          TYPE i
          iv_max_part          TYPE i
          iv_num_tapas         TYPE i
          iv_nocturno          TYPE abap_bool,

    calcular_precio_total REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ruta_gastronomica_sdm IMPLEMENTATION.

    METHOD constructor.
    super->constructor(
      iv_nombre       = iv_nombre
      iv_precio_base  = iv_precio_base
      iv_duracion     = iv_duracion
      iv_max_part     = iv_max_part ).

    num_tapas   = iv_num_tapas.
    es_nocturno = iv_nocturno.
  ENDMETHOD.

  METHOD calcular_precio_total.

    DATA lv_precio_base TYPE decfloat16.
    me->get_precio_base( IMPORTING o_precio_base = lv_precio_base ).

    rv_precio_total = lv_precio_base * max_participantes.

    IF max_participantes > 5.
        rv_precio_total = rv_precio_total * '0.8'.
    ENDIF.

ENDMETHOD.

ENDCLASS.
