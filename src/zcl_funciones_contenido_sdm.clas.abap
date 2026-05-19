CLASS zcl_funciones_contenido_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FUNCIONES_CONTENIDO_SDM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "FUNCIONES DE CONTENIDO

  DATA: lv_text TYPE STRING,
        lv_pattern TYPE STRING.


  lv_text = 'the employees number is: 123-456-7890'.
  lv_pattern = `\d{3}-\d{3}-\d{4}`.

  "Match busca en un texto que le damos en val un patron determinado que le damos en la variable pcre, y en occ indicamos el numero de resultados que queremos que nos muestre.
  DATA(lv_number) = match( val = lv_text pcre = lv_pattern occ = 1 ).
  out->write( lv_number ).


  IF CONTAINS( val = lv_text pcre = lv_pattern ).
  out->write( 'Tiene numero de telefono' ).
  DATA(lv_count) = COUNT( val = lv_text pcre = lv_pattern ).
  out->write( lv_count ).

  ELSE.
  out->write( 'No tiene numero de telefono' ).

  ENDIF.

  ENDMETHOD.
ENDCLASS.
