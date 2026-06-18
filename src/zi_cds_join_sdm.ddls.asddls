@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Usando CDS para realizar JOINS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_CDS_JOIN_SDM 
as select from /dmo/travel as Travel
association[1..1] to /dmo/customer as _Customer
on _Customer.customer_id = $projection.CustomerID // Se puede sustituir $projection.CustomerID por Travel.customer_id
{
    key Travel.travel_id                                                  as TravelID,
        Travel.customer_id                                                as CustomerID,
        concat_with_space( _Customer.first_name, _Customer.last_name, 2 ) as CustomerName
}
