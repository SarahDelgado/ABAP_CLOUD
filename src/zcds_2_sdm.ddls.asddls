@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_2_SDM
  as select from /dmo/customer
{
      key customer_id as CustomerId,
      case country_code
        when 'US' then concat('United States - ', concat_with_space( last_name, first_name, 2 ))
        when 'DE' then 'Germany'
        when 'ES' then 'Spain'
        else 'Another Country Code'
      end as case1,
      
      case
      when country_code = 'US' or country_code = 'ES' then case title
                                                                when 'Mr.' then 'US/ES - Mr.'
                                                                when 'Mrs.' then 'US/ES - Mrs.'
                                                                else 'US/ES - Different Title'
                                                                end
     when title = 'Mr.' then last_name
     when cast('20300101' as abap.dats) < dats_add_days($session.system_date, - 30, 'NULL') then 'lowe'
     else 'No condition applied'
     end as case2 
}
