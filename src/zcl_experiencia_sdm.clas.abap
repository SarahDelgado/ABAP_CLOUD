CLASS zcl_experiencia_sdm DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: nombre            TYPE string,
          duracion_minutos  TYPE i,
          max_participantes TYPE i.

    METHODS:
      constructor
        IMPORTING
          iv_nombre      TYPE string
          iv_precio_base TYPE p
          iv_duracion    TYPE i
          iv_max_part    TYPE i,

      " Método que calculará el precio y que se puede sobreescribir (redefinir)
      calcular_precio_total
        IMPORTING
          iv_num_personas        TYPE i
        RETURNING
          VALUE(rv_precio_total) TYPE decfloat16,

     get_precio_base
       EXPORTING o_precio_base TYPE decfloat16.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA precio_base TYPE p DECIMALS 2.

ENDCLASS.



CLASS zcl_experiencia_sdm IMPLEMENTATION.

  METHOD constructor.
    nombre = iv_nombre.
    precio_base = iv_precio_base.
    duracion_minutos = iv_duracion.
    max_participantes = iv_max_part.
  ENDMETHOD.

  METHOD calcular_precio_total.
    " Regla general: precio base * número de personas
    rv_precio_total = me->precio_base * iv_num_personas.

    " Si el grupo es de más de 8 personas, se aplica un 10% de descuento
    IF iv_num_personas > 8.
      rv_precio_total = rv_precio_total * '0.9'.
    ENDIF.
  ENDMETHOD.

  METHOD get_precio_base.
    o_precio_base = precio_base.
  ENDMETHOD.

ENDCLASS.
