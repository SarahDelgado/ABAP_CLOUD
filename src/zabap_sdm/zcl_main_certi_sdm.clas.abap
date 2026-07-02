CLASS zcl_main_certi_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_certi_sdm IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( '--------------------------------------------------------' ).
    out->write( '--------------EJERCICIO 5-----------------' ).
    out->write( '--------------------------------------------------------' ).

    DATA(lo_conexion) = NEW zcl_sdm_connections( ).

    out->write( lo_conexion->get_connections( 'HAV' ) ).

    out->write( '--------------------------------------------------------' ).
    out->write( '--------------EJERCICIO 4-----------------' ).
    out->write( '--------------------------------------------------------' ).

    TRY.
        DATA(lo_vuelo) = NEW zcl_sdm_flight(
          i_carrier_id    = 'UA'
          i_connection_id = 58
          i_plane_type    = 'xxx' ).
        out->write( lo_vuelo ).
      CATCH zcx_c_abapd_no_connection.
        out->write( 'No flight found' ).
    ENDTRY.

    TRY.
        DATA(lo_vuelo_hija) = NEW zcl_sdm_passenger_flight(
          i_carrier_id    = 'UA'
          i_connection_id = 58
          i_plane_type    = '747-400' ).
        out->write( lo_vuelo_hija ).
      CATCH zcx_c_abapd_no_connection.
        out->write( 'No flight found' ).
    ENDTRY.

    out->write( '--------------------------------------------------------' ).
    out->write( '--------------EJERCICIO 8-----------------' ).
    out->write( '--------------------------------------------------------' ).

    MESSAGE ID 'ZC_ABAPD_SDM' TYPE 'I' NUMBER '001' INTO DATA(lv_texto).

    out->write( lv_texto ).


  ENDMETHOD.

ENDCLASS.
