CLASS zcl_aw_demo_data_generate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS fill_master_data.
    METHODS flush.
    METHODS fill_transaction_data.

ENDCLASS.



CLASS zcl_aw_demo_data_generate IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    me->flush( ).
    me->fill_master_data( ).
    me->fill_transaction_data(  ).
    out->write( 'Execution completed, Watch out the data in tables' ).


  ENDMETHOD.




  METHOD fill_master_data.
    DATA: lt_bp   TYPE TABLE OF zaws_00_bp_table,
          lt_prod TYPE TABLE OF zaws_00_product.

    APPEND VALUE #(
                bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                bp_role = '01'
                company_name = 'TACUM'
                street = 'Victoria Street'
                city = 'Kolkatta'
                country = 'IN'
                region = 'APJ'
                )
                TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'SAP'
                    street = 'Rosvelt Street Road'
                    city = 'Walldorf'
                    country = 'DE'
                    region = 'EMEA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'Asia High tech'
                    street = '1-7-2 Otemachi'
                    city = 'Tokyo'
                    country = 'JP'
                    region = 'APJ'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'AVANTEL'
                    street = 'Bosque de Duraznos'
                    city = 'Maxico'
                    country = 'MX'
                    region = 'NA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'Pear Computing Services'
                    street = 'Dunwoody Xing'
                    city = 'Atlanta, Georgia'
                    country = 'US'
                    region = 'NA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'PicoBit'
                    street = 'Fith Avenue'
                    city = 'New York City'
                    country = 'US'
                    region = 'NA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'TACUM'
                    street = 'Victoria Street'
                    city = 'Kolkatta'
                    country = 'IN'
                    region = 'APJ'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'Indian IT Trading Company'
                    street = 'Nariman Point'
                    city = 'Mumbai'
                    country = 'IN'
                    region = 'APJ'
                    )
                    TO lt_bp.

    APPEND VALUE #(
                     product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                     name = 'Blaster Extreme'
                     category = 'Speakers'
                     price = 175
                     currency = 'INR'
                     discount = 3
                     )
                     TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Sound Booster'
                    category = 'Speakers'
                    price = 250
                    currency = 'INR'
                    discount = 2
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Smart Office'
                    category = 'Software'
                    price = 154
                    currency = 'INR'
                    discount = 32
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Smart Design'
                    category = 'Software'
                    price = 240
                    currency = 'INR'
                    discount = 12
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Transcend Carry pocket'
                    category = 'PCs'
                    price = 140
                    currency = 'INR'
                    discount = 7
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Gaming Monster Pro'
                    category = 'PCs'
                    price = 155
                    currency = 'INR'
                    discount = 8
                    )
                    TO lt_prod.

    INSERT zaws_00_bp_table FROM TABLE @lt_bp.
    INSERT zaws_00_product FROM TABLE @lt_prod.
  ENDMETHOD.

  METHOD fill_transaction_data.
    DATA : o_rand    TYPE REF TO cl_abap_random_int,
           n         TYPE i,
           seed      TYPE i,
           lv_date   TYPE timestamp,
           lv_ord_id TYPE zab_de_awas_id,
           lt_so     TYPE TABLE OF zaws_00_so_table,
           lt_so_i   TYPE TABLE OF zaws_00_si_table.

    seed = cl_abap_random=>seed( ).
    cl_abap_random_int=>create(
      EXPORTING
        seed = seed
        min  = 1
        max  = 7
      RECEIVING
        prng = o_rand
    ).
    GET TIME STAMP FIELD lv_date.

    SELECT * FROM zaws_00_bp_table INTO TABLE @DATA(lt_bp).
    SELECT * FROM zaws_00_product INTO TABLE @DATA(lt_prod).

    DO 10 TIMES.
      TRY.
          lv_ord_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32(  ).
        CATCH cx_uuid_error.
          "handle exception
      ENDTRY.
      n = o_rand->get_next( ).
      READ TABLE lt_bp INTO DATA(ls_bp) INDEX n.
      APPEND VALUE #( order_id = lv_ord_id
                      order_no = sy-index
                      buyer = ls_bp-bp_id
                      gross_amount = n * 100
                      currency = 'INR'
                      created_by = sy-uname
                      created_at = lv_date
                     last_changed_by = sy-uname
                     last_changed_at = lv_date
                   )  TO lt_so.
      DO 2 TIMES.
        READ TABLE lt_prod INTO DATA(ls_product) INDEX n.
        n = o_rand->get_next( ).
        TRY.
            APPEND VALUE #( order_id = lv_ord_id
                        item_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32(  )
                        product = ls_product-product_id
                        qty = n
                        uom = 'PC'
                        amount = n * ls_product-price
                        currency = 'INR'
                        created_by = sy-uname
                        created_at = lv_date
                        last_changed_by = sy-uname
                        last_changed_at = lv_date
                     )  TO lt_so_i.
          CATCH cx_uuid_error.
            "handle exception
        ENDTRY.
      ENDDO.
    ENDDO.

    INSERT zaws_00_so_table FROM TABLE @lt_so.
    INSERT ZAWS_00_Si_TABLE FROM TABLE @lt_so_i.


  ENDMETHOD.

  METHOD flush.
    DELETE FROM: zaws_00_bp_table, zaws_00_product,  zaws_00_so_table,  ZAWS_00_Si_TABLE.
  ENDMETHOD.

ENDCLASS.
