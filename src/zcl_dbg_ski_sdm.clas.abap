CLASS zcl_dbg_ski_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dbg_ski_sdm IMPLEMENTATION.

    METHOD if_oo_adt_classrun~main.

    "--- Creamos los esquiadores ---
    DATA(lo_juan)   = NEW lcl_principiante(
                            iv_nombre  = 'Juan'
                            iv_nivel   = 1
                            iv_forfait = 'F-1001' ).

    DATA(lo_ana)    = NEW lcl_esquiador(
                            iv_nombre  = 'Ana'
                            iv_nivel   = 3
                            iv_forfait = 'F-1002' ).

    DATA(lo_sergio) = NEW lcl_monitor(
                            iv_nombre      = 'Sergio'
                            iv_nivel       = 3
                            iv_forfait     = 'F-1003'
                            iv_max_alumnos = 4 ).

    "--- Comprobación 1: ¿puede Juan bajar la pista VERDE? ---
    out->write( |Juan puede bajar VERDE: { lo_juan->puede_bajar_pista( 'VERDE' ) }| ).

    "--- Comprobación 2: ¿qué nivel tiene Ana? ---
    out->write( |Nivel de Ana: { lo_ana->get_nivel( ) }| ).

    "--- Comprobación 3: mensaje de bienvenida de Juan ---
    out->write( lo_juan->generar_mensaje_bienvenida( ) ).

    "--- Comprobación 4: sustituir monitor del grupo ---
    DATA(lo_grupo) = NEW lcl_grupo_esqui(
                           iv_nombre_grupo = 'Grupo Granada'
                           io_monitor      = lo_sergio ).

    out->write( |Monitor inicial del grupo: { lo_grupo->get_monitor( )->get_nombre( ) }| ).

    DATA(lo_elena) = NEW lcl_monitor(
                           iv_nombre      = 'Elena'
                           iv_nivel       = 3
                           iv_forfait     = 'F-9999'
                           iv_max_alumnos = 4 ).

    lo_grupo->sustituir_monitor( lo_elena ).
    out->write( |Monitor tras sustituir: { lo_grupo->get_monitor( )->get_nombre( ) }| ).

    "--- Comprobación 5: capacidad libre del monitor tras asignar alumnos ---
    lo_sergio->asignar_alumno( lo_juan ).
    lo_sergio->asignar_alumno( lo_ana ).
    lo_sergio->asignar_alumno( NEW lcl_esquiador(
                                     iv_nombre  = 'Pablo'
                                     iv_nivel   = 2
                                     iv_forfait = 'F-1004' ) ).

    out->write( |Alumnos asignados a Sergio: { lo_sergio->get_alumnos_asignados( ) }| ).
    out->write( |Huecos libres de Sergio: { lo_sergio->get_capacidad_libre( ) }| ).

  ENDMETHOD.

ENDCLASS.
