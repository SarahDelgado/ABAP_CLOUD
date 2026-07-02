CLASS zcl_marisqueria_sanlucar_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_negocio_sanlucar_sdm .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_marisqueria_sanlucar_sdm IMPLEMENTATION.


  METHOD zif_negocio_sanlucar_sdm~calcular_precio.
    rv_precio = '25.00'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_descripcion.
   rv_descripcion = 'Langostinos de Sanlúcar y tortillitas de camarones'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_nombre.
    rv_nombre = 'Casa Bigote'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_tipo.
    rv_tipo = 'Marisquería'.
  ENDMETHOD.
ENDCLASS.
