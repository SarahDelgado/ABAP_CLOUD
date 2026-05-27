CLASS zcl_enum_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_enum_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ENUM ty_color,
             rojo,
             verde,
             azul,
           END OF ENUM ty_color.

    DATA lv_color TYPE ty_color.
    lv_color = rojo.
    "lv_colo2 = amarillo. Da error ya que no está contemplado en el enum

    TYPES: BEGIN OF ENUM ty_vuelos,
             nacional,
             internacional,
             charter,
           END OF ENUM ty_vuelos.

    DATA lv_vuelo TYPE ty_vuelos.
    lv_vuelo = internacional.

    CASE lv_vuelo.
      WHEN nacional.
        out->write( 'Vuelo dentro del país' ).
      WHEN internacional.
        out->write( 'Vuelo fuera del país' ).
      WHEN charter.
        out->write( 'Vuelo especial' ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
