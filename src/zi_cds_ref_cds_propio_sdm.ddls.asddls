@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS que hace referencia a otro CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_CDS_REF_CDS_PROPIO_SDM
  with parameters
    pCountryCode : land1
  as select from /dmo/travel as travel
  association [1..1] to ZI_CDS_ASOCIACION_SDM as _Agency on _Agency.AgencyId = $projection.AgencyID
{
  key travel_id                                                                 as TravelID,
      travel.agency_id                                                          as AgencyID,
      _Agency(pCountryCode : $parameters.pCountryCode )[ City = 'Chicago'].Name as AgencyName
}
