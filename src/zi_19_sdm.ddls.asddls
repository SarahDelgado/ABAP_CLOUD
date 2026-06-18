@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'con cl'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_19_sdm
  as select from /dmo/travel as Travel
  association [1..1] to /dmo/customer as _Customer on _Customer.customer_id = $projection.CustomerId
  association [1..1] to /dmo/agency   as _Agency   on _Agency.agency_id   = $projection.AgencyId
{
  key Travel.travel_id   as TravelId,
      Travel.customer_id as CustomerId,
      Travel.agency_id   as AgencyId,
      _Customer,
      _Agency
}
