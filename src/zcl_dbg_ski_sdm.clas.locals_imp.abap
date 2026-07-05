CLASS lcl_esquiador DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre  TYPE string
                iv_nivel   TYPE i
                iv_forfait TYPE string.

    METHODS puede_bajar_pista
      IMPORTING iv_color_pista  TYPE string
      RETURNING VALUE(rv_puede) TYPE abap_bool.

    METHODS generar_mensaje_bienvenida
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS get_nombre  RETURNING VALUE(rv_nombre) TYPE string.
    METHODS get_nivel   RETURNING VALUE(rv_nivel)  TYPE i.

  PROTECTED SECTION.
    DATA mv_nombre  TYPE string.
    DATA mv_nivel   TYPE i.
    DATA mv_forfait TYPE string.
ENDCLASS.

CLASS lcl_esquiador IMPLEMENTATION.

  METHOD constructor.
    mv_nombre  = iv_nombre.
    mv_nivel   = iv_nivel.
    mv_forfait = iv_forfait.
  ENDMETHOD.

  METHOD puede_bajar_pista.
    IF iv_color_pista = 'VERDE'.
      rv_puede = abap_true.
    ELSE.
      rv_puede = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD generar_mensaje_bienvenida.
    rv_mensaje = |Bienvenido { mv_nombre }, tu forfait es { mv_forfait }|.
  ENDMETHOD.

  METHOD get_nombre.
    rv_nombre = mv_nombre.
  ENDMETHOD.

  METHOD get_nivel.
    rv_nivel = mv_nivel.
  ENDMETHOD.

ENDCLASS.



CLASS lcl_principiante DEFINITION INHERITING FROM lcl_esquiador.
  PUBLIC SECTION.
    METHODS puede_bajar_pista REDEFINITION.
ENDCLASS.

CLASS lcl_principiante IMPLEMENTATION.
  METHOD puede_bajar_pista.
    IF mv_nivel = 1 AND ( iv_color_pista = 'VERDE' OR iv_color_pista = 'AZUL' ).
      rv_puede = abap_true.
    ELSE.
      rv_puede = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.



CLASS lcl_monitor DEFINITION INHERITING FROM lcl_esquiador.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre      TYPE string
                iv_nivel       TYPE i
                iv_forfait     TYPE string
                iv_max_alumnos TYPE i.

    METHODS asignar_alumno
      IMPORTING io_alumno TYPE REF TO lcl_esquiador.

    METHODS get_alumnos_asignados  RETURNING VALUE(rv_cantidad) TYPE i.
    METHODS get_capacidad_libre    RETURNING VALUE(rv_libre)    TYPE i.

  PRIVATE SECTION.
    DATA mv_max_alumnos     TYPE i.
    DATA mv_capacidad_libre TYPE i.
    DATA mt_alumnos         TYPE STANDARD TABLE OF REF TO lcl_esquiador WITH EMPTY KEY.
ENDCLASS.

CLASS lcl_monitor IMPLEMENTATION.

  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre iv_nivel = iv_nivel iv_forfait = iv_forfait ).
    mv_max_alumnos     = iv_max_alumnos.
    mv_capacidad_libre = iv_max_alumnos.
  ENDMETHOD.

  METHOD asignar_alumno.
    APPEND io_alumno TO mt_alumnos.
    mv_capacidad_libre = mv_capacidad_libre - 1.
  ENDMETHOD.

  METHOD get_alumnos_asignados.
    rv_cantidad = lines( mt_alumnos ).
  ENDMETHOD.

  METHOD get_capacidad_libre.
    rv_libre = mv_capacidad_libre.
  ENDMETHOD.

ENDCLASS.



CLASS lcl_grupo_esqui DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_nombre_grupo TYPE string
                io_monitor      TYPE REF TO lcl_monitor.

    METHODS sustituir_monitor
      IMPORTING io_nuevo_monitor TYPE REF TO lcl_monitor.

    METHODS get_monitor
      RETURNING VALUE(ro_monitor) TYPE REF TO lcl_monitor.

  PRIVATE SECTION.
    DATA mv_nombre_grupo TYPE string.
    DATA mo_monitor      TYPE REF TO lcl_monitor.
ENDCLASS.

CLASS lcl_grupo_esqui IMPLEMENTATION.

  METHOD constructor.
    mv_nombre_grupo = iv_nombre_grupo.
    mo_monitor      = io_monitor.
  ENDMETHOD.

  METHOD sustituir_monitor.
    mo_monitor = io_nuevo_monitor.
  ENDMETHOD.

  METHOD get_monitor.
    ro_monitor = mo_monitor.
  ENDMETHOD.

ENDCLASS.

