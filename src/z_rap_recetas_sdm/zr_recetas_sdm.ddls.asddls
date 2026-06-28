@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZRECETAS_SDM'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_RECETAS_SDM
  as select from ZRECETAS_SDM
{
  key receta_id as RecetaID,
  nombre_receta as NombreReceta,
  categoria as Categoria,
  tiempo_prep as TiempoPrep,
  dificultad as Dificultad,
  calorias as Calorias,
  publicada as Publicada,
  descripcion as Descripcion,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}
