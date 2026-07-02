INTERFACE zif_negocio_sanlucar_sdm
  PUBLIC .
  METHODS:
    get_nombre RETURNING VALUE(rv_nombre) TYPE string,
    get_tipo RETURNING VALUE(rv_tipo) TYPE string,
    get_descripcion RETURNING VALUE(rv_descripcion) TYPE string,
    calcular_precio RETURNING VALUE(rv_precio) TYPE decfloat16.

ENDINTERFACE.
