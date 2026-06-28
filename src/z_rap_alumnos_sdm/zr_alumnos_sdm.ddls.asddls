@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZALUMNOS_SDM'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_ALUMNOS_SDM
  as select from ZALUMNOS_SDM
{
  key alumno_id as AlumnoID,
  nombre as Nombre,
  apellidos as Apellidos,
  email as Email,
  fecha_nac as FechaNac,
  ciudad as Ciudad,
  curso_actual as CursoActual,
  nota_media as NotaMedia,
  activo as Activo,
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
