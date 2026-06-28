CLASS zcl_main_experiencias_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_experiencias_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Instanciar Visita a Monumento
    DATA(lo_monumento) = NEW zcl_visita_monumento_sdm(
      iv_nombre       = 'Tour Alhambra Esencial'
      iv_precio_base  = '30.50'
      iv_duracion     = 180
      iv_max_part     = 20
      iv_monumento    = 'Alhambra y Generalife'
      iv_reserva      = abap_true
    ).

    "Instanciar Ruta Gastronómica Nocturna
    DATA(lo_ruta) = NEW zcl_ruta_gastronomica_sdm(
      iv_nombre       = 'Sabores del Albaicín'
      iv_precio_base  = 25
      iv_duracion     = 120
      iv_max_part     = 12
      iv_num_tapas    = 4
      iv_nocturno     = abap_true
    ).

    out->write( '--- GESTIÓN DE EXPERIENCIAS ---' ).
    out->write( '-------------------------------' ).

    " Monumento
    out->write( |Experiencia: { lo_monumento->nombre }| ).
    out->write( |Monumento a visitar: { lo_monumento->nombre_monumento }| ).
    DATA lv_precio_base TYPE decfloat16.
    lo_monumento->get_precio_base( IMPORTING o_precio_base = lv_precio_base ).
    out->write( |Precio base: { lv_precio_base } €| ).
    out->write( |Precio Total para 10 personas (10% Desc. incluido): { lo_monumento->calcular_precio_total( iv_num_personas = 10 ) } €| ).

    out->write( '-------------------------------' ).

    "Ruta Gastronómica
    out->write( |Experiencia: { lo_ruta->nombre }| ).
    out->write( |Número de tapas incluidas: { lo_ruta->num_tapas }| ).
    out->write( |Precio Total para 4 personas (Tarifa nocturna): { lo_ruta->calcular_precio_total( iv_num_personas = 4 ) } €| ).

  ENDMETHOD.
ENDCLASS.
