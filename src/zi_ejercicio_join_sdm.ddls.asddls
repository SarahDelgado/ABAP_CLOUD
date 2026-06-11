@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio de join de dos tablas'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_EJERCICIO_JOIN_SDM 
    as select from /dmo/travel  as travel
    inner join   /dmo/booking as booking on travel.travel_id = booking.travel_id
{
      key travel.travel_id   as travel_id,
      key booking.booking_id as booking_id,
      booking.booking_date as flight_date
      //@Semantics.amount.currencyCode: 'CurrencyCode'
      //travel.total_price as total_price,
      //@Semantics.amount.currencyCode: 'flight_price'
      //booking.flight_price as flight_price
}
