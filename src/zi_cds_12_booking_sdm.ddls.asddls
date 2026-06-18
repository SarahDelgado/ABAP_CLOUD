@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'reserva'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_CDS_12_BOOKING_SDM
as select from /dmo/booking as Booking
association[1..1] to /dmo/carrier as _Carrier
on _Carrier.carrier_id = Booking.carrier_id
{
    key booking_id                                             as BookingID,
    carrier_id                                                 as CarrierID,
    flight_date                                                as FlightDate,
    concat_with_space( _Carrier.carrier_id, _Carrier.name, 2 ) as CarrierInfo
}
