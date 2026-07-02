CLASS zcx_reserva_no_valida_sdm DEFINITION
  PUBLIC
  INHERITING FROM cx_no_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    DATA motivo TYPE string.

    METHODS constructor
      IMPORTING
        !textid          LIKE if_t100_message=>t100key OPTIONAL
        !previous        LIKE previous OPTIONAL
        mv_hora_err      TYPE i OPTIONAL
        mv_jugadores_err TYPE i OPTIONAL
        mv_pista_erronea TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_reserva_no_valida_sdm IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
      previous = previous
    ).
    IF mv_hora_err IS NOT INITIAL.
      motivo = | A las { mv_hora_err } no se puede reservar. El horario es de 8 a 23. |.
    ENDIF.
    IF mv_jugadores_err IS SUPPLIED.
      motivo = | Se necesitan 4 jugadores. No se puede reservar con { mv_jugadores_err } . |.
    ENDIF.
    IF mv_pista_erronea IS NOT INITIAL.
      motivo = | La pista { mv_pista_erronea } está ocupada. |.
    ENDIF.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
