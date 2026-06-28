CLASS zcl_periodista_sdm DEFINITION
  PUBLIC
  INHERITING FROM zcl_acreditado_sdm
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ENUM ty_tipo_prensa,
             escrita,
             television,
             radio,
             digital,
           END OF ENUM ty_tipo_prensa.
    DATA: medio_com         TYPE string,
          tipo_prensa       TYPE ty_tipo_prensa,
          acceso_zona_mixta TYPE abap_boolean.

    METHODS:
      constructor
        IMPORTING
          iv_nombre            TYPE string
          iv_pais              TYPE string
          iv_fecha             TYPE d
          iv_num               TYPE string
          iv_medio_com         TYPE string
          iv_tipo_prensa       TYPE ty_tipo_prensa
          iv_acceso_zona_mixta TYPE abap_boolean,

      describir_pase REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_periodista_sdm IMPLEMENTATION.

  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre
                        iv_pais   = iv_pais
                        iv_fecha  = iv_fecha
                        iv_num    = iv_num ).

    medio_com         = iv_medio_com.
    tipo_prensa       = iv_tipo_prensa.
    acceso_zona_mixta = iv_acceso_zona_mixta.

  ENDMETHOD.

  METHOD describir_pase.

    DATA(lv_acceso) = |Sala de prensa|.

    IF acceso_zona_mixta = abap_true.
      lv_acceso = lv_acceso && | y Zona Mixta|.
    ENDIF.

    rv_texto = |--- PASE DE PERIODISTA ---\n| &&
                 |Nombre: { nombre_completo } \n| &&
                 |País: { pais } \n| &&
                 |Accesos permitidos: { lv_acceso }.|.

  ENDMETHOD.

ENDCLASS.
