CLASS zcl_acreditado_sdm DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: nombre_completo TYPE string,
          pais            TYPE string,
          fecha_caducidad TYPE d.

    METHODS:
      constructor
        IMPORTING
          iv_nombre TYPE string
          iv_pais   TYPE string
          iv_fecha  TYPE d
          iv_num    TYPE string,

      get_num_acreditacion
        RETURNING VALUE(rv_num) TYPE string,

      describir_pase
        RETURNING VALUE(rv_texto) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA num_acreditacion TYPE string.

ENDCLASS.



CLASS zcl_acreditado_sdm IMPLEMENTATION.

  METHOD constructor.
    nombre_completo     = iv_nombre.
    pais                = iv_pais.
    fecha_caducidad     = iv_fecha.
    num_acreditacion = iv_num.
  ENDMETHOD.

  METHOD get_num_acreditacion.
    rv_num = num_acreditacion.
  ENDMETHOD.

  METHOD describir_pase.
    rv_texto = |Acreditación general|.
  ENDMETHOD.
ENDCLASS.
