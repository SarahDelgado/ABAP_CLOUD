CLASS z_prueba_examen_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_prueba_examen_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_reserva1) = NEW zcl_sdm_booking_model(  ).
    DATA(lo_reserva2) = NEW zcl_sdm_booking_model(  ).
    TRY.
        out->write( lo_reserva1->get_booking(
                                 i_travel_id  = 1
                                 i_booking_id = 1
                                 )
                   ).
                   out->write( lo_reserva2->get_booking(
                                 i_travel_id  = 100000
                                 i_booking_id = 278
                                 )
                   ).
      CATCH zcx_sdm_no_booking INTO DATA(lo_excepcion).
        out->write( lo_excepcion->get_text( ) ).
    ENDTRY.



  ENDMETHOD.
ENDCLASS.
