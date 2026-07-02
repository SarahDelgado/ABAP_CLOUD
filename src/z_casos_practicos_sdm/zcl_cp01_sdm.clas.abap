CLASS zcl_cp01_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp01_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Definición del tipo de la tabla interna
    TYPES: BEGIN OF ty_vuelo,
             aerolinea     TYPE c LENGTH 2,
             n_vuelo       TYPE n LENGTH 4,
             origen        TYPE c LENGTH 3,
             destino       TYPE c LENGTH 3,
             precio        TYPE p LENGTH 8 DECIMALS 2,
             plazas_libres TYPE i,
           END OF ty_vuelo,

           tt_vuelos TYPE STANDARD TABLE OF ty_vuelo WITH EMPTY KEY.

    " Declaración e inicialización de la tabla interna con los datos
    DATA(lt_vuelos) = VALUE tt_vuelos(
      ( aerolinea = 'LH' n_vuelo = '0400' origen = 'FRA' destino = 'JFK' precio = '899.00'  plazas_libres = 15 )
      ( aerolinea = 'AA' n_vuelo = '0017' origen = 'JFK' destino = 'SFO' precio = '450.50'  plazas_libres = 0 )
      ( aerolinea = 'IB' n_vuelo = '3740' origen = 'MAD' destino = 'BCN' precio = '120.00'  plazas_libres = 42 )
      ( aerolinea = 'LH' n_vuelo = '0455' origen = 'FRA' destino = 'MAD' precio = '310.75'  plazas_libres = 8 )
      ( aerolinea = 'AA' n_vuelo = '0064' origen = 'SFO' destino = 'JFK' precio = '510.00'  plazas_libres = 3 )
      ( aerolinea = 'IB' n_vuelo = '3950' origen = 'BCN' destino = 'LHR' precio = '275.30'  plazas_libres = 0 )
      ( aerolinea = 'LH' n_vuelo = '2030' origen = 'MUC' destino = 'FRA' precio = '95.00'   plazas_libres = 60 )
      ( aerolinea = 'SQ' n_vuelo = '0026' origen = 'SIN' destino = 'FRA' precio = '1250.00' plazas_libres = 5 )
    ).

    out->write( lt_vuelos ).


    " Tarea 1.1 – Clasificación por precio
    " Para cada vuelo, determina su categoría según el precio utilizando una expresión COND o SWITCH:
    " - Precio < 150 €: Económico
    " - Precio  entre 150 y 500 €: Estándar
    " - Precio entre 500 y 1000 €: Premium
    " - Precio > 1000 € : First Class

    out->write( '-----------------------' ).
    out->write( '------TAREA 1.1--------' ).
    out->write( '-----------------------' ).

    " Bucle para leer cada registro de la tabla y calcular su categoria
    LOOP AT lt_vuelos INTO DATA(ls_vuelo).

      " COND para establecer la categoria de cada vuelo en base al precio
      DATA(lv_categoria) = COND string(
                                     WHEN ls_vuelo-precio < 150   THEN 'Económico'
                                     WHEN ls_vuelo-precio <= 500  THEN 'Estándar'
                                     WHEN ls_vuelo-precio <= 1000 THEN 'Premium'
                                     ELSE 'First Class'
                                      ).
      " Muestra por pantalla cada vuelo con su categoria
      out->write( |Vuelo: { ls_vuelo-aerolinea }{ ls_vuelo-n_vuelo } | &&
              |({ ls_vuelo-origen }->{ ls_vuelo-destino }) - | &&
              |Precio: { ls_vuelo-precio } € - Categoría: { lv_categoria }| ).

    ENDLOOP.


    " Tarea 1.2 – Filtrado con operadores lógicos
    " Filtra y muestra únicamente los vuelos que cumplan TODAS estas condiciones:
    " - Tienen plazas libres (plazas > 0).
    " - El origen o el destino es «FRA» (Fráncfort).
    " - El precio NO supera los 1000 €.

    out->write( '-----------------------' ).
    out->write( '------TAREA 1.2--------' ).
    out->write( '-----------------------' ).

    " Tabla para almacenar los resultados
    DATA lt_vuelos_filtrados TYPE tt_vuelos.

    " Bucle para leer cada registro de la tabla y realizar el filtrado
    LOOP AT lt_vuelos INTO DATA(ls_vuelo2).

      " Condicional con los filtros solicitados utilizando operadores lógicos
      IF ls_vuelo2-plazas_libres > 0 AND
          ( ls_vuelo2-origen = 'FRA' OR ls_vuelo2-destino = 'FRA' ) AND
          ls_vuelo2-precio <= 1000.

        " Añade a la tabla de resultados los vuelos que cumplen las condiciones
        APPEND ls_vuelo2 TO lt_vuelos_filtrados.

      ENDIF.
    ENDLOOP.

    " Muestra los vuelos filtrados
    out->write( lt_vuelos_filtrados ).



    " Tarea 1.3 – Transformación de cadenas
    " Para cada vuelo filtrado en la tarea anterior:
    " 1. Construye un código de vuelo concatenando la aerolínea y el número de vuelo (ejemplo: «LH-0400»).
    " 2. Convierte el destino a minúsculas.
    " 3. Calcula la longitud del código generado.
    " 4. Muestra todo por consola en formato: CÓDIGO | destino_minus | longitud.

    out->write( '-----------------------' ).
    out->write( '------TAREA 1.3--------' ).
    out->write( '-----------------------' ).

    " Bucle para leer cada registro de la tabla de vuelos filtrados de la tarea anterior
    " y mostrar por pantalla los datos con el formato pedido
    LOOP AT lt_vuelos_filtrados INTO DATA(ls_vuelo_filtrado).

      " Construye el código de vuelo concatenando con un guión la aerolínea y el número de vuelo
      DATA(lv_codigo_vuelo) = |{ ls_vuelo_filtrado-aerolinea }-{ ls_vuelo_filtrado-n_vuelo }|.

      " Convierte el destino a minúsculas
      DATA(lv_destino_min) = to_lower( ls_vuelo_filtrado-destino ).

      " Calcula la longitud del código generado
      DATA(lv_longitud) = strlen( lv_codigo_vuelo ).

      " Muestra los resultados con el formato solicitado
      out->write( |{ lv_codigo_vuelo } \| { lv_destino_min } \| { lv_longitud }| ).

    ENDLOOP.



    " Tarea 1.4 – Resumen con funciones numéricas
    " Calcula y muestra:
    " - El precio máximo y mínimo de todos los vuelos.
    " - El precio medio (redondeado a 2 decimales con la función round).
    " - El número total de plazas libres en todos los vuelos.

    out->write( '-----------------------' ).
    out->write( '------TAREA 1.4--------' ).
    out->write( '-----------------------' ).

    " Calcula el precio máximo usando las funciones reduce y nmax
    out->write( |Precio Máximo: {
        REDUCE decfloat34( INIT max = 0
                            FOR v IN lt_vuelos
                           NEXT max = nmax( val1 = max val2 = v-precio ) )
        } €| ).

    " Calcula el precio mínimo usando las funciones reduce y nmin
    DATA(lv_primer_precio) = VALUE #( lt_vuelos[ 1 ]-precio DEFAULT 0 ).
    out->write( |Precio Mínimo: {
        REDUCE decfloat34( INIT min = lv_primer_precio
                            FOR v IN lt_vuelos
                           NEXT min = nmin( val1 = min val2 = v-precio ) )
        } €| ).

    " Calcula la suma de todos los precios usando la funcion reduce
    DATA(lv_suma)   = REDUCE decfloat34( INIT s = 0
                                          FOR v IN lt_vuelos
                                         NEXT s += v-precio ).
    " Calcula el número total de vuelos usando la funcion lines
    DATA(lv_lineas) = lines( lt_vuelos ).
    " Calcula el precio medio usando los valores obtenidos arriba y la funcion round para redondearlo a 2 decimales
    out->write( |Precio Medio:  {
        COND decfloat34( WHEN lv_lineas > 0 THEN round( val = ( lv_suma / lv_lineas ) dec = 2 ) ELSE 0 )
        } €| ).

    " Calcula el total de plazas libres con la funcion reduce
    out->write( |Total Plazas:  {
        REDUCE i( INIT t = 0
                   FOR v IN lt_vuelos
                  NEXT t += v-plazas_libres )
        }| ).


  ENDMETHOD.
ENDCLASS.
