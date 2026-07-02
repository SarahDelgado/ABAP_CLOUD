CLASS zcx_sdm_no_booking DEFINITION
  PUBLIC
  INHERITING FROM cx_no_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF no_reserva,
        msgid TYPE symsgid VALUE 'ZC_MENSAJES_SDM',
        msgno TYPE symsgno VALUE '001',
      END OF no_reserva.

    METHODS constructor
      IMPORTING
        !textid    LIKE if_t100_message=>t100key OPTIONAL
        !previous  LIKE previous OPTIONAL
        travel_id  TYPE /dmo/travel_id
        booking_id TYPE /dmo/booking_id.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_sdm_no_booking IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
      previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key-msgid = no_reserva-msgid.
      if_t100_message~t100key-msgno = no_reserva-msgno.
      if_t100_message~t100key-attr1 = travel_id.
      if_t100_message~t100key-attr2 = booking_id.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
