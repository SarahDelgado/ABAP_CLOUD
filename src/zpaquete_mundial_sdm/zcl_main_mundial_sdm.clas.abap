CLASS zcl_main_mundial_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_mundial_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Instanciar Jugador
    DATA(lo_jugador) = NEW zcl_jugador_sdm(
      iv_nombre         = 'Lamine Yamal'
      iv_pais           = 'España'
      iv_fecha          = '20261231'
      iv_num            = 'J-199-FIFA'
      iv_dorsal         = 19
      iv_posicion       = zcl_jugador_sdm=>delantero
      iv_esta_convocado = abap_true
    ).

    "Instanciar Periodista
    DATA(lo_periodista) = NEW zcl_periodista_sdm(
      iv_nombre            = 'Luna Lunera'
      iv_pais              = 'España'
      iv_fecha             = '20261231'
      iv_num               = 'P-554-RADIO'
      iv_medio_com         = 'Canal Sur Radio'
      iv_tipo_prensa       = zcl_periodista_sdm=>radio
      iv_acceso_zona_mixta = abap_true
    ).

    "Mostrar los resultados
    out->write( '=== SISTEMA DE ACREDITACIONES MUNDIAL ===' ).

    "Muestra la descripción del pase del jugador
    out->write( lo_jugador->describir_pase( ) ).

    out->write( '--------------------------------------------------' ).

    "Muestra la descripción del pase del periodista
    out->write( lo_periodista->describir_pase( ) ).

  ENDMETHOD.
ENDCLASS.
