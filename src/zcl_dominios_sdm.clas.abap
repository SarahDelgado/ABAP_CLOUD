CLASS zcl_dominios_sdm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_DOMINIOS_SDM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Usamos un elemento de dato y dominio para el ID
    DATA: BEGIN OF ls_empleado_info,

        BEGIN OF info,
            id     TYPE ZDE_ID_SDM VALUE 01,
            nombre TYPE STRING VALUE 'daniel',
        END OF INFO,

        BEGIN OF direccion,
            ciudad TYPE STRING VALUE 'Granada',
            calle  TYPE STRING VALUE 'KK',
            pais   TYPE STRING VALUE 'España',
       END OF DIRECCION,

       BEGIN OF posicion,
            departamento TYPE STRING VALUE 'IT',
            sueldo       TYPE P DECIMALS 2 VALUE '18524.45',
       END OF POSICION,

   END OF ls_empleado_info.

   out->write( ls_empleado_info ).

   "Ejercicio: Crear dominio y elemento de dato para cada uno

   TYPES: BEGIN OF ty_empleado,
         nombre TYPE zde_nombre_sdm,
         edad TYPE I,
         telefono TYPE ZDE_TELEFONO_SDM,
         correo TYPE ZDE_CORREO_SDM,

  END OF TY_EMPLEADO.

  DATA ls_empleado2 TYPE ty_empleado.

  out->write( ls_empleado_info ).


  ENDMETHOD.
ENDCLASS.
