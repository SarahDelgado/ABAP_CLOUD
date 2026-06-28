@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS de vuelos'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_VUELOS_SDM
  as select from /dmo/flight  as f
    inner join   /dmo/carrier as c on c.carrier_id = f.carrier_id
{
  key f.carrier_id,
      c.name,
      f.connection_id,
      f.flight_date
}
