INTERFACE zif_flight_manager_sdm
  PUBLIC .

  " Estructura con los datos de un vuelo
  TYPES: BEGIN OF ty_flight,
           id        TYPE i,
           aerolinea TYPE string,
           vuelo     TYPE n LENGTH 4,
           pasajero  TYPE string,
           fecha     TYPE d,
           precio    TYPE p LENGTH 8 DECIMALS 2,
           estado    TYPE c LENGTH 1,
         END OF ty_flight,

         " Tabla interna estándar de vuelos optimizada con una clave hash única para búsquedas rápidas por aerolínea y número de vuelo.
         tt_flights TYPE STANDARD TABLE OF ty_flight WITH EMPTY KEY
                    WITH UNIQUE HASHED KEY k_flight COMPONENTS aerolinea vuelo,

         " Tipo para el cálculo de facturación
         ty_revenue TYPE p LENGTH 10 DECIMALS 2.

  "! Añade un vuelo a la colección interna
  "! Registra un nuevo vuelo en el sistema tras aplicar validaciones de negocio básicas.
  "!
  "! @parameter i_flight             | Estructura con los datos del vuelo a añadir.
  "! @raising   zcx_flight_error_sdm | Se lanza si el precio es menor o igual a cero,
  "!                                   o si ya existe un vuelo con la misma combinación aerolínea/vuelo.
  METHODS add_flight
    IMPORTING
      i_flight TYPE ty_flight
    RAISING
      zcx_flight_error_sdm.

  "! Obtiene los vuelos de una aerolínea específica
  "! Filtra la colección interna de vuelos y devuelve únicamente aquellos que coinciden con el código indicado.
  "!
  "! @parameter i_aerolinea       | Código de la aerolínea a filtrar.
  "! @parameter rt_flights        | Tabla con los vuelos filtrados encontrados.
  METHODS get_flights_by_airline
    IMPORTING
      i_aerolinea       TYPE string
    RETURNING
      VALUE(rt_flights) TYPE tt_flights.

  "! Determina el vuelo más barato registrado
  "! Evalúa todos los vuelos del gestor para encontrar el que posee el precio unitario más bajo.
  "!
  "! @parameter rs_flight         | Estructura del vuelo con el precio mínimo
  METHODS get_cheapest_flight
    RETURNING
      VALUE(rs_flight) TYPE ty_flight.

  "! Calcula la facturación total acumulada
  "! Suma los precios de todos los vuelos almacenados en el motor de gestión.
  "!
  "! @parameter rv_total          | Importe total acumulado de la facturación.
  METHODS get_total_revenue
    RETURNING
      VALUE(rv_total) TYPE ty_revenue.

ENDINTERFACE.

