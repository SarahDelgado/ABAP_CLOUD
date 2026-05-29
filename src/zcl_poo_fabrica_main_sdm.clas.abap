CLASS zcl_poo_fabrica_main_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_poo_fabrica_main_sdm IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


**********************************************************************
*Limpieza de la base de datos
**********************************************************************

    DELETE FROM zdb_alumnos_sdm.


**********************************************************************
*Creación del objeto
**********************************************************************
    DATA(lv_objeto) =  NEW zcl_poo_fabrica_sdm( ).

    IF lv_objeto IS BOUND.
**********************************************************************
*Carga en masa de alumnos
**********************************************************************
        DATA lt_nombres TYPE string_table.

      lt_nombres = VALUE #(
        ( `Alba Gómez, Sergio` )
        ( `Anangono Tutasig, Karen Denisse` )
        ( `Ayala Doñas, Alejandro` )
        ( `Barnes Calancha, Lidia` )
        ( `Bureo Osuna, Jesús` )
        ( `Criado Romero, Samuel` )
        ( `Delgado Martín, Sarah` )
        ( `González de la Torre, José Antonio` )
        ( `Maldonado Hernández, Luis` )
        ( `Moreno Cabrera, María Dolores` )
        ( `Palacios Canales, Rebeca` )
        ( `Portillo Moral, Gonzalo` )
        ( `Prados Donaire, Miguel` )
        ( `Rojas Moreno, Antonio` )
        ( `Ruíz Rodríguez, Antonia` )
        ( `Sillero Fernández, David` )
        ( `Torres Albillo, Adrián` )
        ( `Vela Martínez, Rafael` )
      ).

      out->write( lv_objeto->carga_alumnos( lt_nombres ) ).


*--------------------------------------------------------------------
* Carga de un alumno
*--------------------------------------------------------------------
      out->write( lv_objeto->carga_alumno( 'Lunera Cascabelera, Luna' ) ).

*--------------------------------------------------------------------
* Elección aleatoria de un alumno
*--------------------------------------------------------------------
      out->write( |Alumno aleatorio: { lv_objeto->alumno_random(   ) }| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
