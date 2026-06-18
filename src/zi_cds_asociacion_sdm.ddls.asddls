@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS con Asociacion'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_CDS_ASOCIACION_SDM 
with parameters
//        pCity        : /dmo/city,
        pCountryCode : land1
as select from /dmo/agency
{
    key agency_id as AgencyId,
    name          as Name,
    street        as Street, 
    postal_code   as PostalCode,
    city          as City,
    country_code  as CountryCode,
    phone_number  as PhoneNumber,
    email_address as EmailAddress,
    web_address   as WebAddress,
    attachment    as Attachment,
    mime_type     as MimeType,
    filename      as Filename
}
where country_code = $parameters.pCountryCode;
