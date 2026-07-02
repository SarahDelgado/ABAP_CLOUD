CLASS zcl_probar_reservas_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_probar_reservas_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_reservas) = NEW zcl_gestor_reservas_sdm( ).

    TRY.
        DATA(resultado) = lo_reservas->reservar_pista(
        i_hora          = 10
                                     i_num_jugadores = 4
                                     i_nombre_pista  = 'PISTA_1' ).
        out->write( resultado ).
      CATCH zcx_reserva_no_valida_sdm INTO DATA(lo_excepcion).
        out->write( lo_excepcion->motivo ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
