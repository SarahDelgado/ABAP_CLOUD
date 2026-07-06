@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Consumo / Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_LIBRO_SDM
as projection on ZI_LIBRO_SDM
{
  key LibroId,
      BibliotecaId,
      Titulo,
      Autor,
      Genero,
      Isbn,
      FechaPublicacion,
      Editorial,
      Disponible,
      Activo,
      
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
     
      _Biblioteca : redirected to parent ZC_biblioteca_sdm
}
