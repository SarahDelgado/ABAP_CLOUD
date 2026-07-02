"! Motor de gestión de vuelos
"! Clase encargada de la lógica de negocio del sistema de vuelos.
"! Implementa las validaciones de persistencia y el procesamiento analítico de datos.
CLASS zcl_flight_manager_sdm DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.

    INTERFACES zif_flight_manager_sdm .

    "! Constructor de la clase
    "! Permite opcionalmente cargar un listado previo de vuelos.
    "!
    "! @parameter i_flights | Tabla interna opcional con los vuelos iniciales
    METHODS constructor
      IMPORTING
        i_flights TYPE zif_flight_manager_sdm=>tt_flights OPTIONAL.

  PRIVATE SECTION.
    "! Colección interna de vuelos
    DATA flights TYPE zif_flight_manager_sdm=>tt_flights.

ENDCLASS.



CLASS zcl_flight_manager_sdm IMPLEMENTATION.


  METHOD constructor.
    flights = i_flights.
  ENDMETHOD.


  METHOD zif_flight_manager_sdm~add_flight.
    " Valida que el importe del billete no sea cero ni negativo
    " Si es asi, lanza la excepción con un mensaje personalizado
    IF i_flight-precio <= 0.
      RAISE EXCEPTION NEW zcx_flight_error_sdm(
        mensaje = |Error: El precio del vuelo { i_flight-aerolinea }{ i_flight-vuelo } debe ser mayor que cero ({ i_flight-precio }).|
      ).
    ENDIF.

    " Valida que el nuevo registro no exista ya en la tabla usando la clave aerolinea + vuelo
    " Si es asi, lanza la excepción con un mensaje personalizado
    IF line_exists( flights[ KEY k_flight aerolinea = i_flight-aerolinea vuelo = i_flight-vuelo ] ).
      RAISE EXCEPTION NEW zcx_flight_error_sdm(
        mensaje = |Error: Ya existe el vuelo { i_flight-aerolinea }{ i_flight-vuelo } en el sistema.|
      ).
    ENDIF.

    " Guarda el registro en la tabla atributo si supera las validaciones anteriores
    INSERT i_flight INTO TABLE flights.

  ENDMETHOD.


  METHOD zif_flight_manager_sdm~get_flights_by_airline.
    " Filtra usando for where los registros de una misma aerolinea
    rt_flights = VALUE #( FOR v IN flights WHERE ( aerolinea = i_aerolinea ) ( v ) ).
  ENDMETHOD.


  METHOD zif_flight_manager_sdm~get_cheapest_flight.
    " Evalúa fila por fila y actualiza el acumulador local 'min_flight' si encuentra un precio menor
    rs_flight = REDUCE #(
      INIT min_flight = flights[ 1 ]
       FOR v IN flights
      NEXT min_flight = COND #( WHEN v-precio < min_flight-precio THEN v ELSE min_flight )
    ).
  ENDMETHOD.


  METHOD zif_flight_manager_sdm~get_total_revenue.
    " Se suman los precios de todos los vuelos mediante REDUCE
    rv_total = REDUCE decfloat34(
      INIT total = 0
       FOR v IN flights
      NEXT total = total + v-precio
    ).
  ENDMETHOD.

ENDCLASS.

