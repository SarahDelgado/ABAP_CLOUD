CLASS zcl_cds_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cds_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM zi_20_sdm AS Booking
    FIELDS Booking~TravelId,
    Booking~BookingId,
    \_Travel-AgencyId,
    \_Travel\_Agency-name AS AgencyName,
    \_Travel\_Customer-customer_id AS customer_id,
    concat_with_space( \_Travel\_Customer-first_name, \_Travel\_Customer-last_name, 2 ) AS customerName
    WHERE booking~CarrierId = 'AA'
    INTO TABLE @DATA(lt_resultados)
    UP TO 5 ROWS.

    IF sy-subrc = 0.

      out->write( lt_resultados ).

    ENDIF.

  ENDMETHOD.
ENDCLASS.
