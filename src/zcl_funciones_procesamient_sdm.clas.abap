CLASS zcl_funciones_procesamient_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FUNCIONES_PROCESAMIENT_SDM IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.

     "Usar funciones dentro de la funcion de salida out write.
    DATA lv_num TYPE I VALUE 5.
    DATA lv_num2 TYPE I VALUE 10.
    DATA lv_resultado TYPE I.
    lv_resultado = lv_num + lv_num2.
    out->write( lv_resultado ).
    "Seria lo mismo que esto
    out->write( lv_num + lv_num2 ).

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "FUNCIONES DE PROCESAMIENTO

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    DATA lv_var TYPE STRING VALUE 'Hola, este es el curso de ABAP.'.

    "Funcion para cambiar el texto a mayusculas
    out->write( |{ lv_var } a mayusculas -> { to_upper( lv_var ) }| ).

    "Funcion para cambiar el texto a minusculas
    out->write( |{ lv_var } a minusculas -> { to_lower( lv_var ) }| ).

    "Función para poner el texto al reves
    out->write( |{ lv_var } al reves -> { reverse( lv_var ) }| ).

    "Funcion para desplazar texto a la izquierda el numero de posiciones indicadas en places
    out->write( |{ lv_var } desplazado a la izquierda -> { shift_left( val = lv_var places = 5 ) }| ).

    "Funcion para desplazar texto a la derecha el numero de posiciones indicadas en places
    out->write( |{ lv_var } desplazado a la derecha -> { shift_right( val = lv_var places = 5 ) }| ).

    "Funcion para extraer texto de una zona concreta, con off indicamos la posicion concreta y con len cuantas letras extraemos
    out->write( |{ lv_var } substring -> { substring( val = lv_var off = 9 len = 6 ) }| ).

    "Funcion para extraer texto a partir del lugar donde se encuentre una cadena de caracteres en concreto hasta el final
    out->write( |{ lv_var } substring_from -> { substring_from( val = lv_var sub = 'el' ) }| ).

    "Funcion para extraer texto desde el principio de la cadena hasta el lugar donde se encuentre una cadena de caracteres en concreto
    out->write( |{ lv_var } substring_before -> { substring_before( val = lv_var sub = 'el' ) }| ).

    "Funcion para extraer texto que hay desde el lugar donde se encuentre una cadena de caracteres en concreto hasta el final sin incluir la cadena
    out->write( |{ lv_var } substring_after -> { substring_after( val = lv_var sub = 'el' ) }| ).

    "Funcion para eliminar los espacios en blanco del principio y del final de la cadena
    out->write( |{ lv_var } sin espacios en blanco -> { condense( lv_var ) }| ).

    ENDMETHOD.
ENDCLASS.
