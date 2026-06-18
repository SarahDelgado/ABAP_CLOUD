@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_20_SDM
  as select from /dmo/booking
  association [1..1] to zi_19_sdm as _Travel on _Travel.TravelId = $projection.TravelId
{
  key travel_id     as TravelId,
  key booking_id    as BookingId,
      booking_date  as BookingDate,
      customer_id   as CustomerId,
      carrier_id    as CarrierId,
      connection_id as ConnectionId,
      flight_date   as FlighDate,
      _Travel
}
