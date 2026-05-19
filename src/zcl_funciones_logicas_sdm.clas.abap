CLASS zcl_funciones_logicas_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FUNCIONES_LOGICAS_SDM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "FUNCIONES LÓGICAS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


  "FUNCIÓN IF

  DATA lv_name TYPE STRING VALUE 'daniel'.
  DATA lv_edad TYPE I VALUE 15.

  IF lv_name = 'daniel'.
    IF lv_edad = 5.
        out->write( 'hola danie de 5 años' ).
    ELSEIF lv_edad = 15.
        out->write(  'hola daniel de 15 años' ).
    ENDIF.
  ELSEIF lv_name = 'juan'.
    out->write( 'hola juan' ).
  ELSE.
    out->write( 'tu no eres ni juan ni daniel' ).
  ENDIF.


  "FUNCION CASE

  DATA(lv_edad_aleatoria) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( ) min = 1 max = 100 )->get_next( ).

  CASE lv_edad_aleatoria.

        WHEN 12.
            out->write( lv_edad_aleatoria ).

        WHEN 18.
            out->write( lv_edad_aleatoria ).

        WHEN 45.
            out->write( lv_edad_aleatoria ).

        WHEN OTHERS.
            out->write( |Cualquier otra edad { lv_edad_aleatoria }| ).

    ENDCASE.


"EJERCICIO: PROGRAMA DE DESCUENTOS SEGUN LA EDAD DE LA FUNCION RANDOM, DESCUENTOS PARA MENORES DE 12 AÑOS, PARA ADOLESCENTES Y PARA MAYORES DE 65.
  "OPCION 1
  IF lv_edad_aleatoria < 12.
    out->write( 'Tienes un descuento de 5€' ).
  ELSEIF lv_edad_aleatoria >= 13 AND lv_edad_aleatoria < 18.
    out->write( 'Tienes un descuento de 10€' ).
  ELSEIF lv_edad_aleatoria >= 65.
    out->write( 'Tienes un descuento de 10€' ).
  ELSE.
    out->write( 'Debido a tu edad, no tienes descuento' ).
  ENDIF.
  "OPCION 2
  IF lv_edad_aleatoria <= 12.
    out->write( 'Tiene un precio de 5€' ).
  ELSEIF lv_edad_aleatoria >= 13 AND lv_edad_aleatoria < 18.
    out->write( 'Tiene un precio de 10€' ).
  ELSEIF lv_edad_aleatoria >= 18 AND lv_edad_aleatoria < 65.
    out->write( 'Tiene un precio de 20€' ).
  ELSE.
    out->write( 'Tiene un precio de 10€' ).
  ENDIF.
"OPCION 3
  DATA lv_mensaje TYPE string.
  "Uso de COND con CASE para intervalos
  lv_mensaje = COND #( WHEN lv_edad_aleatoria < 12 THEN 'Tiene un precio de 5€'
                  WHEN lv_edad_aleatoria BETWEEN 12 AND 18 THEN 'Tiene un precio de 10€'
                  WHEN lv_edad_aleatoria BETWEEN 18 AND 65 THEN 'Tiene un precio de 20€'
                  WHEN lv_edad_aleatoria > 65 THEN 'Tiene un precio de 10€'
                  ELSE 'Error' ).
  out->write( lv_mensaje ).



  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  "BUCLES
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " BUCLE DO

  DATA lv_num TYPE I VALUE 0.
  "DATA lv_rep TYPE I VALUE 5.

  " LA CONDICION DE ESTE BUCLE INDICA EL NUMERO DE VECES QUE SE VA A EJECUTAR
  DO 5 TIMES.
  "DO lv_rep TIMES.

    out->write( lv_num ).
    lv_num += 1.
    "lv_num = lv_num + 1.

    "EXIT. Para salir del bucle, para terminarlo antes de que se termine la condicion de acabar.
    IF lv_num = 3.
      EXIT.
    ENDIF.

  ENDDO.


  " BUCLE WHILE, se tiene que cumplir una condicion para que entre en el bucle y para salir de él

  DATA lv_num2 TYPE I VALUE 0.

  WHILE lv_num2 < 10.

    out->write( lv_num2 ).
    lv_num2 += 1.

  ENDWHILE.






  ENDMETHOD.
ENDCLASS.
