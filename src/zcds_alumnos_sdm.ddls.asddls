@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS de alumnos'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCDS_ALUMNOS_SDM
  as select from zdb_alumnos_sdm
{
      key id as ID,
      nombre as Nombre
}
