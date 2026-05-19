CLASS zcl_funciones_cadenas_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FUNCIONES_CADENAS_SDM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  "Nos devuelve la longitud de la cadena".
  DATA(lv_num) = STRLEN( 'Daniel' ).
  OUT->WRITE( lv_num ).
  DATA(lv_numesp) = STRLEN( '  Daniel  ' ). "Cuenta solo un espacio en blanco de cada lao"
  OUT->WRITE( lv_numesp ).


  DATA lv_var TYPE STRING VALUE 'Experis Experis'.
  "Cuenta el numero de veces que encuentra la subcadena que le indicamos en sub dentro de la cadena que le indicamos en val, discriminando mayusculas de minusculas"
  DATA(lv_count) = COUNT( val = lv_var sub = 'Ex' ).
  OUT->WRITE( lv_count ).

  "Cuenta el numero de veces que encuentra la subcadena que le indicamos en sub dentro de la cadena que le indicamos en val, sin diferenciar las mayusculas de las minusculas
  DATA(lv_countany) = COUNT_ANY_OF( val = lv_var sub = 'Ex' ).
  OUT->WRITE( lv_countany ).

  "Cuenta el numero de letras que no se encuentran en la subcadena que le indicamos en sub dentro de la cadena que le indicamos en val, diferenciando las mayusculas de las minusculas
  DATA(lv_countanynot) = COUNT_ANY_NOT_OF( val = lv_var sub = 'Ex' ).
  OUT->WRITE( lv_countanynot ).

  "Devuelve la primera posicion en la que encuentra la cadena
  DATA(lv_find) = FIND( val = lv_var sub = 'Ex' ).
  OUT->WRITE( lv_find ).

  "Devuelve la primera posicion en la que encuentre cualquiera de las letras de la cadena que le pasamos en sub.
  DATA(lv_findany) = FIND_ANY_OF( val = lv_var sub = 'Ex' ).
  OUT->WRITE( lv_findany ).

  "Devuelve la primera posicion en la que no se encuentra cualquiera de las letras de la cadena que le pasamos en sub.
  DATA(lv_findanynot) = FIND_ANY_NOT_OF( val = lv_var sub = 'Ex' ).
  OUT->WRITE( lv_findanynot ).




  ENDMETHOD.
ENDCLASS.
