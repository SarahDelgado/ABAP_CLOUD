CLASS zcl_cp03_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cp03_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " Tarea 3.4.1. Crea una instancia de ZCL_FLIGHT_MANAGER_XX.
    out->write( '-------------------------' ).
    out->write( '------TAREA 3.4.1--------' ).
    out->write( '-------------------------' ).

    DATA(lo_manager) = NEW zcl_flight_manager_sdm( ).

    out->write( 'Instancia creada.' ).

    " Tarea 3.4.2. Añade al menos 5 vuelos.
    out->write( '-------------------------' ).
    out->write( '------TAREA 3.4.2--------' ).
    out->write( '-------------------------' ).

    TRY.
        lo_manager->zif_flight_manager_sdm~add_flight( VALUE #( id = 1 aerolinea = 'LH' vuelo = '0400' pasajero = 'Gomez, Juan'    fecha = '20260702' precio = '250.00' estado = 'A' ) ).
        lo_manager->zif_flight_manager_sdm~add_flight( VALUE #( id = 2 aerolinea = 'LH' vuelo = '0402' pasajero = 'Lopez, Maria'   fecha = '20260702' precio = '180.50' estado = 'A' ) ).
        lo_manager->zif_flight_manager_sdm~add_flight( VALUE #( id = 3 aerolinea = 'AA' vuelo = '0011' pasajero = 'Perez, Carlos'  fecha = '20260703' precio = '520.00' estado = 'A' ) ).
        lo_manager->zif_flight_manager_sdm~add_flight( VALUE #( id = 4 aerolinea = 'AA' vuelo = '0089' pasajero = 'Martinez, Ana'  fecha = '20260703' precio = '410.00' estado = 'P' ) ).
        lo_manager->zif_flight_manager_sdm~add_flight( VALUE #( id = 5 aerolinea = 'IB' vuelo = '3240' pasajero = 'Sanchez, Luis'  fecha = '20260704' precio = '95.00'  estado = 'A' ) ).
        out->write( 'Vuelos añadidos con éxito.' ).
      CATCH zcx_flight_error_sdm INTO DATA(lx_excepcion).
        out->write( lx_excepcion->mensaje ).
    ENDTRY.

    " Tarea 3.4.3. Intenta añadir un vuelo con precio negativo → captura la excepción y muestra el mensaje.
    out->write( '-------------------------' ).
    out->write( '------TAREA 3.4.3--------' ).
    out->write( '-------------------------' ).

    TRY.
        lo_manager->zif_flight_manager_sdm~add_flight( VALUE #(
            id        = 6
            aerolinea = 'UX'
            vuelo     = '1022'
            pasajero  = 'Test Error'
            fecha     = '20260702'
            precio    = '-50.00'
            estado    = 'X'
        ) ).
      CATCH zcx_flight_error_sdm INTO DATA(lx_excepcion_precio).
        out->write( |[EXCEPCIÓN CAPTURADA]: { lx_excepcion_precio->mensaje }| ).
    ENDTRY.

    " Tarea 3.4.4. Intenta añadir un vuelo duplicado → captura la excepción.
    out->write( '-------------------------' ).
    out->write( '------TAREA 3.4.4--------' ).
    out->write( '-------------------------' ).

    TRY.
        " Intentamos añadir un ID nuevo, pero con combinación aerolinea-vuelo repetida
        lo_manager->zif_flight_manager_sdm~add_flight( VALUE #(
            id        = 7
            aerolinea = 'LH'
            vuelo     = '0400'
            pasajero  = 'Repetido, Test'
            fecha     = '20260702'
            precio    = '300.00'
            estado    = 'A'
        ) ).
      CATCH zcx_flight_error_sdm INTO DATA(lx_excepcion_duplicado).
        out->write( |[EXCEPCIÓN CAPTURADA]: { lx_excepcion_duplicado->mensaje }| ).
    ENDTRY.

    " Tarea 3.4.5. Muestra los vuelos de una aerolínea concreta.
    out->write( '-------------------------' ).
    out->write( '------TAREA 3.4.5--------' ).
    out->write( '-------------------------' ).

    DATA(lt_aa_filtro) = lo_manager->zif_flight_manager_sdm~get_flights_by_airline( 'AA' ).
    out->write( 'Vuelos de la aerolínea AA:' ).
    out->write( lt_aa_filtro ).

    " Tarea 3.4.6. Muestra el vuelo más barato.
    out->write( '-------------------------' ).
    out->write( '------TAREA 3.4.6--------' ).
    out->write( '-------------------------' ).

    DATA(ls_mas_barato) = lo_manager->zif_flight_manager_sdm~get_cheapest_flight( ).
    out->write( |El vuelo más barato es:| ).
    out->write( ls_mas_barato ).

    " Tarea 3.4.7. Muestra la facturación total.
    out->write( '-------------------------' ).
    out->write( '------TAREA 3.4.7--------' ).
    out->write( '-------------------------' ).

    DATA(lv_total) = lo_manager->zif_flight_manager_sdm~get_total_revenue( ).
    out->write( |Facturación total: { lv_total } €| ).

  ENDMETHOD.
ENDCLASS.
