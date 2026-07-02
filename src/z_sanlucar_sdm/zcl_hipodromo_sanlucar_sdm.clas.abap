CLASS zcl_hipodromo_sanlucar_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_negocio_sanlucar_sdm .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hipodromo_sanlucar_sdm IMPLEMENTATION.


  METHOD zif_negocio_sanlucar_sdm~calcular_precio.
    rv_precio = '5.00'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_descripcion.
    rv_descripcion = 'Las carreras más antiguas de España, en la orilla del mar'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_nombre.
    rv_nombre = 'Carreras de Caballos de la Playa'.
  ENDMETHOD.


  METHOD zif_negocio_sanlucar_sdm~get_tipo.
    rv_tipo = 'Hipódromo'.
  ENDMETHOD.
ENDCLASS.
