CLASS zcl_main_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_main_sdm IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Variable para seleccionar la opción a utilizar
    DATA lt_accion TYPE i VALUE 2.

    " Instancia de la clase creadora de empleados
    DATA(lo_employee) = NEW zcl_creadora_sdm(
            iv_nombre = 'Natalia'
            iv_apellido = 'Ruiz'
            iv_telefono = '666555777'
            iv_experiencia = 4
            iv_certificaciones = 2 ).

    " Case para seleccionar la opción a utilizar
    CASE lt_accion.
      WHEN 1.
        out->write( lo_employee->alta_empleado( ) ).
      WHEN 2.
        out->write( lo_employee->modificacion(
                iv_nombre = 'rrra'
                iv_apellido = 'Ruiz'
                iv_telefono = '666555777'
                iv_experiencia = 4
                iv_certificaciones = 2
                iv_id_empleado = 10 ) ).
      WHEN 3.
        out->write( lo_employee->traer_lt( iv_id_empleado = 0 ) ).
      WHEN 4.
        out->write( lo_employee->traer_n_filas( iv_n_filas = 2 ) ).
    ENDCASE.

  ENDMETHOD.

ENDCLASS.


