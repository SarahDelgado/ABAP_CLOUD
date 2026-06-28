@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZALUMNOS_SDM'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_ALUMNOS_SDM
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_ALUMNOS_SDM
  association [1..1] to ZR_ALUMNOS_SDM as _BaseEntity on $projection.ALUMNOID = _BaseEntity.ALUMNOID
{
  key AlumnoID,
  Nombre,
  Apellidos,
  Email,
  FechaNac,
  Ciudad,
  CursoActual,
  NotaMedia,
  Activo,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
