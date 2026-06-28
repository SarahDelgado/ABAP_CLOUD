@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZRECETAS_SDM'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_RECETAS_SDM
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_RECETAS_SDM
  association [1..1] to ZR_RECETAS_SDM as _BaseEntity on $projection.RECETAID = _BaseEntity.RECETAID
{
  key RecetaID,
  NombreReceta,
  Categoria,
  TiempoPrep,
  Dificultad,
  Calorias,
  Publicada,
  Descripcion,
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
