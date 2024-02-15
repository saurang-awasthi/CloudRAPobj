CLASS zcl_aw_amdp_prod DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
  PROTECTED SECTION.

    CLASS-METHODS : Getproddata
      IMPORTING VALUE(iP_id)        TYPE zab_de_awas_id
      EXPORTING
                VALUE(ev_price)     TYPE int4
                VALUE(ev_dis_price) TYPE int4.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aw_amdp_prod IMPLEMENTATION.
  METHOD getproddata.

  ENDMETHOD.

ENDCLASS.
