CLASS zcl_cp04_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp04_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    " Definición del tipo de la tabla
*    TYPES: BEGIN OF ty_reserva,
*             id        TYPE i,
*             aerolinea TYPE c LENGTH 2,
*             vuelo     TYPE n LENGTH 4,
*             pasajero  TYPE string,
*             fecha     TYPE d,
*             precio    TYPE p LENGTH 8 DECIMALS 2,
*             estado    TYPE c LENGTH 1,
*           END OF ty_reserva.

    " Tabla Estándar con los datos iniciales
    DATA lt_reservas TYPE STANDARD TABLE OF ZST_BOOKING_SDM WITH EMPTY KEY.

    lt_reservas = VALUE #(
      ( id = 1 aerolinea = 'LH' vuelo = '0400' pasajero = 'Ana García'   fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id = 2 aerolinea = 'IB' vuelo = '3740' pasajero = 'Carlos López' fecha = '20260515' precio = '120.00'  estado = 'A' )
      ( id = 3 aerolinea = 'AA' vuelo = '0017' pasajero = 'John Smith'   fecha = '20260520' precio = '450.50'  estado = 'A' )
      ( id = 4 aerolinea = 'LH' vuelo = '0455' pasajero = 'María Pérez'  fecha = '20260520' precio = '310.75'  estado = 'A' )
      ( id = 5 aerolinea = 'IB' vuelo = '3740' pasajero = 'Pedro Ruiz'   fecha = '20260515' precio = '120.00'  estado = 'C' )
      ( id = 6 aerolinea = 'SQ' vuelo = '0026' pasajero = 'Lisa Tan'     fecha = '20260601' precio = '1250.00' estado = 'A' )
      ( id = 7 aerolinea = 'LH' vuelo = '0400' pasajero = 'Hans Müller'  fecha = '20260515' precio = '899.00'  estado = 'A' )
      ( id = 8 aerolinea = 'AA' vuelo = '0064' pasajero = 'Sarah Jones'  fecha = '20260525' precio = '510.00'  estado = 'A' )
    ).

    out->write( lt_reservas ).



    " Tarea 2.1 – Altas de reservas
    " Añade las siguientes reservas nuevas a la tabla:
    " - ID 9: IB, vuelo 3950, «Elena Martín», fecha 20260601, precio 275.30, estado A
    " - ID 10: LH, vuelo 2030, «Franz Weber», fecha 20260610, precio 95.00, estado A
    " Muestra la tabla completa tras las inserciones.

    out->write( '-----------------------' ).
    out->write( '------TAREA 2.1--------' ).
    out->write( '-----------------------' ).

    " Usamos APPEND para añadir los dos nuevos registros
    APPEND VALUE #( id = 9  aerolinea = 'IB' vuelo = '3950' pasajero = 'Elena Martín' fecha = '20260601' precio = '275.30' estado = 'A' ) TO lt_reservas.
    APPEND VALUE #( id = 10 aerolinea = 'LH' vuelo = '2030' pasajero = 'Franz Weber'  fecha = '20260610' precio = '95.00'  estado = 'A' ) TO lt_reservas.

    " Muestra la tabla con los nuevos registros añadidos
    out->write( lt_reservas ).



    " Tarea 2.2 – Modificaciones
    " Realiza las siguientes modificaciones:
    " 1. Busca la reserva con ID 3 y cambia su precio a 480.00.
    " 2. Para todas las reservas de la aerolínea LH, aplica un descuento del 10%.
    " Muestra los registros modificados.

    out->write( '-----------------------' ).
    out->write( '------TAREA 2.2--------' ).
    out->write( '-----------------------' ).

    " Lee la tabla con READ TABLE buscando el registro con el id = 3
    READ TABLE lt_reservas INTO DATA(ls_reserva) WITH KEY id = 3.

    " Si el resgistro existe, procedemos a realizar la modificación
    IF sy-subrc = 0.
      " Cambia el precio del registro obtenido
      ls_reserva-precio = '480.00'.
      " Cambia el precio del registro con id = 3 usando el precio modificado
      MODIFY lt_reservas FROM ls_reserva TRANSPORTING precio  WHERE id = 3.
    ENDIF.

    " Bucle para buscar e iterar sobre los registros de la aerolinea = 'LH'
    LOOP AT lt_reservas INTO DATA(ls_reserva2) WHERE aerolinea = 'LH'.
      " Aplica el descuento a los precios de la aerolinea = 'LH'
      ls_reserva2-precio = ls_reserva2-precio * '0.90'.
      " Modifica el precio del registro actual usando el id
      MODIFY lt_reservas FROM ls_reserva2 TRANSPORTING precio WHERE id = ls_reserva2-id.
    ENDLOOP.

    " Muestra los registros modificados
    LOOP AT lt_reservas INTO DATA(ls_mostrar) WHERE id = 3 OR aerolinea = 'LH'.
      out->write( ls_mostrar ).
    ENDLOOP.



    " Tarea 2.3 – Cancelaciones y borrados
    " 1. Cambia el estado de la reserva ID 4 a «C» (cancelada).
    " 2. Elimina físicamente de la tabla todas las reservas con estado «C».
    " Muestra la tabla resultante y el número de registros eliminados.

    out->write( '-----------------------' ).
    out->write( '------TAREA 2.3--------' ).
    out->write( '-----------------------' ).

    " Lee la tabla con READ TABLE buscando el registro con el id = 4
    READ TABLE lt_reservas INTO DATA(ls_reserva3) WITH KEY id = 4.
    " Si el resgistro existe, procedemos a realizar la modificación
    IF sy-subrc = 0.
      " Cambia el precio del registro obtenido
      ls_reserva3-estado = 'C'.
      " Cambia el precio del registro con id = 4 usando el precio modificado
      MODIFY lt_reservas FROM ls_reserva3 TRANSPORTING estado WHERE id = 4.
    ENDIF.

    " Guarda la cantidad de registros antes del borrado
    DATA(lv_lineas_antes) = lines( lt_reservas ).

    " Borra los registros que tienen estado = 'C'
    DELETE lt_reservas WHERE estado = 'C'.

    " Calcula la cantidad de resgistros borrados
    DATA(lv_eliminados) = lv_lineas_antes - lines( lt_reservas ).

    " Muestra la tabla después de borrar los registros y el número de registros borrados
    out->write( lt_reservas ).
    out->write( |Registros eliminados: { lv_eliminados }| ).



    " Tarea 2.4 – Búsquedas
    " 1. Busca si existe una reserva para el pasajero «Lisa Tan» (TRANSPORTING NO FIELDS + sy-subrc).
    " 2. Obtén una referencia (REFERENCE INTO) a la reserva con ID 6 y muestra sus datos.
    " 3. Usa la expresión de tabla VALUE #( itab[ ... ] ) para acceder directamente al pasajero de la reserva con ID 1.

    out->write( '-----------------------' ).
    out->write( '------TAREA 2.4--------' ).
    out->write( '-----------------------' ).

    " Busca si existe una reserva para el pasajero «Lisa Tan»
    READ TABLE lt_reservas WITH KEY pasajero = 'Lisa Tan' TRANSPORTING NO FIELDS.
    " Si el registro existe, muestra un mensaje por pantalla, y si no existe muestra otro diferente
    IF sy-subrc = 0.
      out->write( 'Existe una reserva para el pasajero "Lisa Tan".' ).
    ELSE.
      out->write( 'No se encontró la reserva para "Lisa Tan".' ).
    ENDIF.

    " Obtiene la referencia del registro con id = 6
    READ TABLE lt_reservas REFERENCE INTO DATA(lr_reserva) WITH KEY id = 6.
    " Si la referencia existe, muestra sus datos
    IF sy-subrc = 0.
      out->write( |Referencia ID 6 ->| ).
      out->write( |  Aerolínea: { lr_reserva->aerolinea }| ).
      out->write( |  Vuelo:     { lr_reserva->vuelo }| ).
      out->write( |  Pasajero:  { lr_reserva->pasajero }| ).
      out->write( |  Fecha:     { lr_reserva->fecha }| ).
      out->write( |  Precio:    { lr_reserva->precio }| ).
      out->write( |  Estado:    { lr_reserva->estado }| ).
    ENDIF.

    " Muestra la información del pasajero de la reserva con ID 1 usando VALUE #( itab[ ... ] )
    TRY.
        out->write( |El pasajero con ID 1 es {  VALUE #( lt_reservas[ id = 1 ]-pasajero ) }.| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( 'No se encontró ninguna reserva con ID 1.' ).
    ENDTRY.



    " Tarea 2.5 – Agrupación y agregados
    " A partir de las reservas activas restantes:
    " 1. Agrupa por aerolínea usando GROUP BY.
    " 2. Para cada grupo calcula: número de reservas, precio total y precio medio.
    " 3. Muestra un informe por consola con los totales por aerolínea.

    out->write( '-----------------------' ).
    out->write( '------TAREA 2.5--------' ).
    out->write( '-----------------------' ).

    " Define el tipo del informe final
    TYPES: BEGIN OF ty_informe,
             aerolinea    TYPE c LENGTH 2,
             num_reservas TYPE i,
             precio_total TYPE p LENGTH 8 DECIMALS 2,
             precio_medio TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_informe.

    " Inicializa la tabla del informe final
    DATA lt_informe TYPE STANDARD TABLE OF ty_informe WITH EMPTY KEY.

    " Agrupa usando LOOP AT y GROUP BY por aerolínea
    LOOP AT lt_reservas INTO DATA(ls_reserva4)
         GROUP BY ( aerolinea = ls_reserva4-aerolinea )
         INTO DATA(ls_grupo).
      " Crea una estructura vacía para rellenar los datos de la aerolínea actual
      DATA(ls_linea) = VALUE ty_informe( aerolinea = ls_grupo-aerolinea ).
      " Recorre los registros de cada aerolínea para calcular sus totales
      LOOP AT GROUP ls_grupo INTO DATA(ls_miembro).
        " Calcula el total de reservas de cada aerolínea
        ls_linea-num_reservas = ls_linea-num_reservas + 1.
        " Calcula el precio total de cada aerolínea
        ls_linea-precio_total = ls_linea-precio_total + ls_miembro-precio.
      ENDLOOP.

      " Calcula el precio medio de cada aerolínea
      ls_linea-precio_medio = ls_linea-precio_total / ls_linea-num_reservas.

      " Añade el resultado en la tabla del informe final
      APPEND ls_linea TO lt_informe.
    ENDLOOP.

    " Muestra el informe final por pantalla
    out->write( lt_informe ).

  ENDMETHOD.
ENDCLASS.
