 CLASS zcl_poo2_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION. "Todos los atributos y metodos son publicos y accesibles
    CLASS-DATA lv_moneda TYPE c LENGTH 3. "Es un atributo estático
    DATA lv_region TYPE string.
    METHODS set_cliente
      "Parametros de entrada
      IMPORTING iv_cliente      TYPE string
                iv_localizacion TYPE string
      "Parametros de salida
      EXPORTING ev_status       TYPE string
      "Parametros de cambio
      CHANGING  cv_proceso      TYPE string.

    METHODS get_cliente
      EXPORTING ev_cliente TYPE string.

    CLASS-METHODS:
      set_cntr_type
        IMPORTING iv_cntr_type TYPE string,
      get_cntr_type
        EXPORTING ev_cntr_type TYPE string.



  PROTECTED SECTION. "Es solo accesible para esta clase y las clases hijas
    CLASS-DATA lv_fecha TYPE sydate. "Esto es un atributo estatico

  PRIVATE SECTION. "Es accesible solo esta clase y las clases friends.
    DATA lv_cliente TYPE string. "Esto es un atibuto de instancia

ENDCLASS.



CLASS zcl_poo2_sdm IMPLEMENTATION.


  METHOD set_cliente.

  ENDMETHOD.

  METHOD get_cliente.

  ENDMETHOD.

  METHOD get_cntr_type.

  ENDMETHOD.

  METHOD set_cntr_type.

  ENDMETHOD.

ENDCLASS.
