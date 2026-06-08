@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ejemplo CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_EJEMPLO_SDM as select from /dmo/flight
{
    key carrier_id as AirlineId,
    key connection_id as ConnectionId,
    key flight_date as FlightDate,
    @Semantics.amount.currencyCode : 'Currency'
    @EndUserText.label: 'Price'
    price as Price,
    currency_code as Currency,
    
    'USD' as CurremcyDocument,
    '20300101' as DateString,
    
    cast('20300101' as abap.dats) as dateDate,
    1.2 as FloatingPoint,
    fltp_to_dec(1.2 as abap.dec( 4, 2 )) as DecimalElement
}

// Comentarios para los CDS
