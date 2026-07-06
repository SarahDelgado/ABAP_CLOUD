@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Consumo / Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_biblioteca_sdm
  provider contract transactional_query
  as projection on ZI_BIBLIOTECA_SDM
{
  key BibliotecaId,
      Nombre,
      Direccion,
      Telefono,
      Email,
      Responsable,
      FechaAlta,
      Activa,
      
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,

      _Libros : redirected to composition child ZC_LIBRO_SDM
}
