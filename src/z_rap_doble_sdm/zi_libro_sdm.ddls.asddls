@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Libro - Hijo'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_LIBRO_SDM
  as select from zlibro_sdm
  association to parent ZI_BIBLIOTECA_SDM as _Biblioteca
    on $projection.BibliotecaId = _Biblioteca.BibliotecaId
{
  key libro_id              as LibroId,
      biblioteca_id         as BibliotecaId,
      titulo                as Titulo,
      autor                 as Autor,
      genero                as Genero,
      isbn                  as Isbn,
      fecha_publicacion     as FechaPublicacion,
      editorial             as Editorial,
      disponible            as Disponible,
      activo                as Activo,
      
      // Campos de auditoría (RAP)
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      
      // Exposición de la asociación al padre
      _Biblioteca
}
