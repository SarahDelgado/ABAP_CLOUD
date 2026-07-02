CLASS zcl_sdm_booking_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_booking
      IMPORTING
                i_travel_id        TYPE /dmo/travel_id
                i_booking_id       TYPE /dmo/booking_id
      RETURNING VALUE(r_resultado) TYPE /dmo/booking
      RAISING
                zcx_sdm_no_booking.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sdm_booking_model IMPLEMENTATION.


  METHOD get_booking.

    SELECT SINGLE FROM /dmo/booking
    FIELDS *
     WHERE travel_id = @i_travel_id
       AND booking_id = @i_booking_id
      INTO @r_resultado.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_sdm_no_booking
        EXPORTING
          travel_id  = i_travel_id
          booking_id = i_booking_id.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
