@AbapCatalog.sqlViewName: 'ZSQL_BOOKING_SDM'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS de reservas con campos calculados'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_BOOKING_SDM
  as select from /dmo/booking
{
  key travel_id                              as TravelID,
  key booking_id                             as BookingID,
  key customer_id                            as CustomerID,
      booking_date                           as BookingDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price                           as FlightPrice,
      currency_code                          as CurrencyCode,
      division( flight_price * 110, 100, 2 ) as PrecioConRecargo,
      case
        when flight_price < 500 then 'Economy'
        when flight_price >= 500 and flight_price <= 1500 then 'Business'
        else 'First Class'
      end                                    as CategoriaReserva,
      case
        when booking_date > '20260601' then 'Reciente'
        else 'Histórica'
      end                                    as EstadoAntiguedad
}
