CLASS zcl_ejercicio_estructura_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejercicio_estructura_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


  "EJERCICIO 1: DECLARACIÓN DE ESTRUCTURAS.

  TYPES: BEGIN OF ty_flights,
         iduser     TYPE char40,
         aircode    TYPE /dmo/carrier_id,
         flightnum  TYPE /dmo/connection_id,
         key        TYPE land1,
         seat       TYPE /dmo/plane_seats_occupied,
         flightdate TYPE /dmo/flight_date,

         END OF TY_FLIGHTS.

   DATA ls_flight TYPE ty_flights.

   out->write( ls_flight ).


   TYPES: BEGIN OF ty_airlines,
         carrid    TYPE /dmo/carrier_id,
         connid    TYPE /dmo/connection_id,
         countryfr TYPE land1,
         cityfrom  TYPE /dmo/city,
         airpfrom   TYPE /dmo/airport_id,
         countryto TYPE land1,

         END OF TY_AIRLINES.

    DATA ls_airline TYPE ty_airlines.

    out->write( ls_airline ).


  "EJERCICIO 2: ESTRUCUTURAS ANIDADAS

  TYPES: BEGIN OF ty_nested,
         flights  TYPE ty_flights,
         airlines TYPE ty_airlines,

         END OF TY_NESTED.

   DATA ls_nested TYPE ty_nested.

   out->write( ls_nested ).


   "EJERCICIO 4: AÑADIR DATOS A LAS ESTRUCTURAS

   ls_flight = VALUE #( iduser = '011' aircode = 'AA' flightnum = '0514' key = 'ES' seat = 125 flightdate = '20260514' ).
   out->write( ls_flight ).
   ls_airline = VALUE #( carrid = 'LH' connid = '0400' countryfr = 'ES' cityfrom = 'Madrid' airpfrom = 'ES' countryto = 'JP' ).
   out->write( ls_airline ).

   ls_nested-flights = ls_flight.
   ls_nested-airlines = ls_airline.
   out->write( ls_nested ).


   "EJERCICIO 5: ESCTRUCTURA INCLUDE

   TYPES: BEGIN OF ty_include_flights,
          INCLUDE TYPE ty_flights.
          INCLUDE TYPE ty_airlines.

   TYPES: END OF ty_include_flights.

   DATA ls_include_flights TYPE ty_include_flights.

   ls_include_flights = CORRESPONDING #( ls_flight ).
   ls_include_flights = CORRESPONDING #( BASE ( ls_include_flights ) ls_airline ).
   out->write( ls_include_flights ).

  " EJERCICIO 6: ELIMINAR LOS DATOS

  CLEAR: ls_nested.
  out->write( ls_nested ).


  ENDMETHOD.
ENDCLASS.
