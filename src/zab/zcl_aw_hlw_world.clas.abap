CLASS zcl_aw_hlw_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aw_hlw_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  out->write( 'Hello World !' ).

  ENDMETHOD.
ENDCLASS.
