CLASS zcl_new_abap_syntax DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    TYPES : BEGIN OF ty_sales,
              customer TYPE c LENGTH 10,
              amount   TYPE int4,
              country  TYPE land1,
            END OF ty_sales,

            BEGIN OF ty_sales_new,
              ship_to_party TYPE c LENGTH 10,
              gross_val     TYPE int4,
              country       TYPE land1,
            END OF ty_sales_new,

            BEGIN OF ty_invoice,
              customer TYPE c LENGTH 10,
              amount   TYPE int4,
              country  TYPE land1,
            END OF ty_invoice,

            BEGIN OF ty_grp,
              customer TYPE c LENGTH 10,
              amount   TYPE int4,
            END OF ty_grp,

            tt_sales     TYPE STANDARD TABLE OF  ty_sales,
            tt_sales_new TYPE STANDARD TABLE OF  ty_sales_new,
            tt_invoice   TYPE STANDARD TABLE OF  ty_invoice,
            tt_grp       TYPE STANDARD TABLE OF  ty_grp,
            tt_inv       TYPE SORTED TABLE OF  ty_invoice WITH UNIQUE KEY customer.


    DATA : tab_sales     TYPE tt_sales,
           wa_sales      TYPE ty_sales,

           tab_sales_new TYPE tt_sales_new,
           wa_sales_new  TYPE ty_sales_new,

           tab_group     TYPE tt_grp,
           wa_group      TYPE ty_grp,

           tab_inv       TYPE tt_invoice,
           tab_inv_srt   TYPE tt_inv,
           wa_inv_new    TYPE ty_invoice.

    METHODS: fill_table,
      print_data IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      learn_corresponding,
      learn_ready_key IMPORTING out TYPE REF TO if_oo_adt_classrun_out,
      new_loop,
      fill_group.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_new_abap_syntax IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    me->fill_table( ).
*    me->learn_corresponding( ).
*    me->learn_ready_key( out = out ).
    me->new_loop( ).
    me->fill_group( ).
    me->print_data( out = out ).

  ENDMETHOD.
  METHOD fill_table.

*Old Code
*    wa_sales-customer = 'SAP'.
*    wa_sales-amount   = 5000.
*    wa_sales-country  = 'DE'.
*    append wa_sales to tab_sales.

*New code 7.4+ syntax

*1. Value # "Here # represent the type of the table to be data inserted into
*APPEND VALUE #( customer = 'SAP' amount = 5000 country = 'DE'  ) to tab_sales.
*APPEND VALUE ty_sales( customer = 'SAP' amount = 5000 country = 'DE'  ) to tab_sales.

*Another way to use value operator to insert multiple records

    tab_sales = VALUE #( ( customer = 'SAP' amount = 5000 country = 'DE'  )
                         ( customer = 'SAP' amount = 6000 country = 'IN'  )
                         ( customer = 'TAPLA' amount = 7000 country = 'US'  )
                         ( customer = 'NESTLE' amount = 8000 country = 'DE'  )
                         ( customer = 'TAPLA' amount = 9000 country = 'IN'  )
                         ( customer = 'NESTLE' amount = 10000 country = 'US'  )

                        ).


  ENDMETHOD.

  METHOD learn_corresponding.

*corresponding when both source & target coloumn name are same with same data type
* tab_inv = CORRESPONDING #( tab_sales ).

* In case where field names does not match for example sales_new & sales
*tab_sales_new = CORRESPONDING #( tab_sales MAPPING ship_to_party = customer
*                                                    gross_val = amount
*                                                    country  = country ).


* In case we want to move only single field
    tab_sales_new = CORRESPONDING #( tab_sales MAPPING ship_to_party = customer
                                                       EXCEPT * ).

*    tab_inv_srt   = CORRESPONDING #( tab_sales DISCARDING DUPLICATES MAPPING customer = customer ).
    tab_inv_srt   = CORRESPONDING #( tab_sales DISCARDING DUPLICATES MAPPING customer = customer EXCEPT * ).

  ENDMETHOD.

  METHOD learn_ready_key.

* Old read syntax
*    READ TABLE tab_sales INTO wa_sales WITH KEY customer = 'SAP'.
*    IF sy-subrc = 0.
*      out->write( 'Data exists' ).
*    ENDIF.


*New Syntax

    IF  line_exists( tab_sales[ customer = 'SAP' ] ).
      out->write( 'Data exists' ).
    ELSE.
      out->write( 'No Data exists' ).

    ENDIF.

  ENDMETHOD.

  METHOD new_loop.
    tab_sales_new = VALUE #( FOR wa IN tab_sales ( ship_to_party = wa-customer
                                                        gross_val = wa-amount
                                                        country  = wa-country )  ).

  ENDMETHOD.

  METHOD print_data.

*    out->write(
*      EXPORTING
*        data   = tab_sales ).
*
*    out->write(
*  EXPORTING
*    data   = tab_sales_new ).
*
*
*    out->write(
*  EXPORTING
*    data   = tab_inv ).
*
*    out->write(
*  EXPORTING
*    data   = tab_inv_srt ).

    out->write(
    EXPORTING
  data   = tab_group ).

  ENDMETHOD.

  METHOD fill_group.
  data : lv_amt type int4.
    LOOP AT tab_sales  INTO DATA(wa_sl) GROUP BY wa_sl-customer INTO DATA(lt_grp).
      LOOP AT GROUP lt_grp INTO DATA(ls_group).
        lv_amt += ls_group-amount.
      ENDLOOP.
       APPEND  value #( customer = lt_grp  amount =  lv_amt ) to tab_group.
      clear : lv_amt.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
