CLASS zcl_bd_cliente_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bd_cliente_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lt_clientes TYPE TABLE OF zbd_cliente_sdm.

    "Rellena la tabla interna con los 6 registros
    lt_clientes = VALUE #(
      ( id_cliente = 1 nombre = 'Alejandro' apellido = 'García'    direccion = 'Calle Mayor 12, Piso 3A, Madrid'            correo = 'alejandro@email.com'   telefono = '600123456' )
      ( id_cliente = 2 nombre = 'María'     apellido = 'López'     direccion = 'Av. de la Constitución 45, Sevilla'         correo = 'maria.lopez@email.com' telefono = '611234567' )
      ( id_cliente = 3 nombre = 'Carlos'    apellido = 'Martínez'  direccion = 'Plaza Polanco 8, CDMX, México'              correo = 'carlos.m@email.com'    telefono = '555123456' )
      ( id_cliente = 4 nombre = 'Ana'       apellido = 'Rodríguez' direccion = 'Calle Florida 150, Depto 4, Buenos Aires'   correo = 'ana.rod@email.com'     telefono = '114321098' )
      ( id_cliente = 5 nombre = 'Luis'      apellido = 'Fernández' direccion = 'Gran Vía 78, Barcelona'                     correo = 'luis.f@email.com'      telefono = '622345678' )
      ( id_cliente = 6 nombre = 'Laura'     apellido = 'Sánchez'   direccion = 'Paseo de la Reforma 200, Piso 15, CDMX'     correo = 'laura.s@email.com'     telefono = '555987654' )
    ).

    "Inserta los registros en la base de datos
    INSERT zbd_cliente_sdm FROM TABLE @lt_clientes.

    IF sy-subrc = 0.
      out->write( '¡6 Registros insertados con éxito en zbd_cliente_sdm!' ).
    ELSE.
      out->write( 'Ocurrió un error al insertar los datos.' ).
    ENDIF.

    "Para usar el bloqueo creado.
    DATA ls_new_registro TYPE zbd_cliente_sdm.
    ls_new_registro = VALUE #( id_cliente = 8
                               nombre = 'luis'
                               apellido = 'gonzalez ramirez'
                               direccion = 'C/mirador de la nava'
                               correo = 'luis@gmail.com'
                               telefono = '958632147' ).

    WAIT UP TO 20 SECONDS.
    MODIFY zbd_cliente_sdm FROM @ls_new_registro.

  ENDMETHOD.
ENDCLASS.
