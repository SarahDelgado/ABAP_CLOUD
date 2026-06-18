@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejercicio'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_CONNECTION_SDM
  as select from /dmo/connection as Connection
  association [1..1] to /dmo/carrier as _Carrier            on  Connection.carrier_id = _Carrier.carrier_id
  association [1..1] to /dmo/airport as _DepartureAirport   on  Connection.airport_from_id = _DepartureAirport.airport_id
  association [0..*] to /dmo/flight  as _Flights            on  Connection.connection_id = _Flights.connection_id
                                                            and Connection.carrier_id    = _Flights.carrier_id
  association [1..1] to /dmo/airport as _DestinationAirport on  Connection.airport_to_id = _DestinationAirport.airport_id
{
  key Connection.carrier_id      as CarrierId,
  key Connection.connection_id   as ConnectionId,
      Connection.airport_from_id as AirportFromId,
      Connection.airport_to_id   as AirportToId,
      Connection.departure_time  as DepartureTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      Connection.distance        as Distance,
      Connection.distance_unit   as DistanceUnit,
      _Carrier,
      _DepartureAirport,
      _Flights,
      _DestinationAirport
}
