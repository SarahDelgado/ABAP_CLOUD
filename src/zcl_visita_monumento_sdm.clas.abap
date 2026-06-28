CLASS zcl_visita_monumento_sdm DEFINITION
  PUBLIC
  INHERITING FROM zcl_experiencia_sdm
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: nombre_monumento TYPE string,
          requiere_reserva TYPE abap_bool.

    METHODS:
      constructor
        IMPORTING
          iv_nombre            TYPE string
          iv_precio_base       TYPE p
          iv_duracion          TYPE i
          iv_max_part          TYPE i
          iv_monumento         TYPE string
          iv_reserva           TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_visita_monumento_sdm IMPLEMENTATION.

    METHOD constructor.
    " Llamamos al constructor de la clase padre
    super->constructor(
      iv_nombre       = iv_nombre
      iv_precio_base  = iv_precio_base
      iv_duracion     = iv_duracion
      iv_max_part     = iv_max_part ).

    nombre_monumento = iv_monumento.
    requiere_reserva = iv_reserva.
  ENDMETHOD.

ENDCLASS.
