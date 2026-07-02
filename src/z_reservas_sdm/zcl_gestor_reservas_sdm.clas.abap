CLASS zcl_gestor_reservas_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      reservar_pista
        IMPORTING
                  i_hora           TYPE i
                  i_num_jugadores  TYPE i
                  i_nombre_pista   TYPE string
        RETURNING VALUE(rv_result) TYPE string
        RAISING   zcx_reserva_no_valida_sdm.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gestor_reservas_sdm IMPLEMENTATION.

  METHOD reservar_pista.

    IF i_hora < 8 OR i_hora > 23.
      RAISE EXCEPTION TYPE zcx_reserva_no_valida_sdm
        EXPORTING
          mv_hora_err = i_hora.
    ENDIF.

    IF i_num_jugadores <> 4.
      RAISE EXCEPTION NEW zcx_reserva_no_valida_sdm( mv_jugadores_err = i_num_jugadores ).
    ENDIF.

    IF i_nombre_pista = 'PISTA_1'.
      RAISE EXCEPTION NEW zcx_reserva_no_valida_sdm( mv_pista_erronea = i_nombre_pista ).
    ENDIF.

    rv_result = 'Se ha reservado la pista con éxito.'.

  ENDMETHOD.

ENDCLASS.
