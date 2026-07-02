CLASS zcl_calculadora_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      sumar
        IMPORTING
          iv_num1          TYPE p
          iv_num2          TYPE p
        RETURNING
          VALUE(rv_result) TYPE decfloat16
        RAISING
          zcx_resultado_no_valido_sdm,

      restar
        IMPORTING
          iv_num1          TYPE p
          iv_num2          TYPE p
        RETURNING
          VALUE(rv_result) TYPE decfloat16
        RAISING
          zcx_resultado_no_valido_sdm,

      multiplicar
        IMPORTING
          iv_num1          TYPE p
          iv_num2          TYPE p
        RETURNING
          VALUE(rv_result) TYPE decfloat16
        RAISING
          zcx_resultado_no_valido_sdm,

      dividir
        IMPORTING
          iv_num1          TYPE p
          iv_num2          TYPE p
        RETURNING
          VALUE(rv_result) TYPE f
        RAISING
          cx_sy_zerodivide
          zcx_resultado_no_valido_sdm.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_calculadora_sdm IMPLEMENTATION.

  METHOD sumar.
    rv_result = iv_num1 + iv_num2.
    IF rv_result = 100.
      RAISE EXCEPTION TYPE zcx_resultado_no_valido_sdm.
    ENDIF.
  ENDMETHOD.

  METHOD restar.
    rv_result = iv_num1 - iv_num2.
    IF rv_result = 100.
      RAISE EXCEPTION TYPE zcx_resultado_no_valido_sdm.
    ENDIF.
  ENDMETHOD.

  METHOD multiplicar.
    rv_result = iv_num1 * iv_num2.
    IF rv_result = 100.
      RAISE EXCEPTION TYPE zcx_resultado_no_valido_sdm.
    ENDIF.
  ENDMETHOD.

  METHOD dividir.
    IF iv_num2 = 0.
      RAISE EXCEPTION TYPE cx_sy_zerodivide.
    ENDIF.
    rv_result = iv_num1 / iv_num2.
    IF rv_result = 100.
      RAISE EXCEPTION TYPE zcx_resultado_no_valido_sdm.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
