CLASS zcl_jugador_sdm DEFINITION
  PUBLIC
  INHERITING FROM zcl_acreditado_sdm
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ENUM ty_posicion,
             portero,
             defensa,
             centrocampista,
             delantero,
           END OF ENUM ty_posicion.

    DATA: dorsal         TYPE i,
          posicion       TYPE ty_posicion,
          esta_convocado TYPE abap_boolean.

    METHODS:
      constructor
        IMPORTING
          iv_nombre         TYPE string
          iv_pais           TYPE string
          iv_fecha          TYPE d
          iv_num            TYPE string
          iv_dorsal         TYPE i
          iv_posicion       TYPE ty_posicion
          iv_esta_convocado TYPE abap_boolean,

      describir_pase REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_jugador_sdm IMPLEMENTATION.
  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre
                        iv_pais   = iv_pais
                        iv_fecha  = iv_fecha
                        iv_num    = iv_num ).

    dorsal       = iv_dorsal.
    posicion     = iv_posicion.
    esta_convocado = iv_esta_convocado.

  ENDMETHOD.

  METHOD describir_pase.

    rv_texto = |--- PASE DE JUGADOR ---\n| &&
               |Nombre: { nombre_completo } \n| &&
               |País: { pais } \n| &&
               |Accesos permitidos: Campo y Vestuarios.|.

  ENDMETHOD.

ENDCLASS.
