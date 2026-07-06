@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Biblioteca - Raíz'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_BIBLIOTECA_SDM
  as select from zbiblioteca_sdm
  composition [0..*] of ZI_LIBRO_SDM as _Libros
{
  key biblioteca_id         as BibliotecaId,
      nombre                as Nombre,
      direccion             as Direccion,
      telefono              as Telefono,
      email                 as Email,
      responsable           as Responsable,
      fecha_alta            as FechaAlta,
      activa                as Activa,
      
      // Campos de auditoría (RAP)
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      
      // Exposición de la composición
      _Libros
}
