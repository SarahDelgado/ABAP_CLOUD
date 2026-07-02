CLASS zcl_bodega_sanlucar_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_negocio_sanlucar_sdm .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bodega_sanlucar_sdm IMPLEMENTATION.


  METHOD zif_negocio_sanlucar_sdm~calcular_precio.
    rv_precio = '12.00'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_descripcion.
    rv_descripcion = 'Manzanilla en rama desde 1792, frente al Guadalquivir'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_nombre.
    rv_nombre = 'Bodega Hidalgo La Gitana'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_tipo.
    rv_tipo = 'Bodega'.
  ENDMETHOD.

ENDCLASS.
