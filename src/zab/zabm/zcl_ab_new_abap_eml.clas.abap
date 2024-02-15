CLASS zcl_ab_new_abap_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ab_new_abap_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA : it_data_create TYPE TABLE FOR CREATE zab_i_trav_aw02_m .

    it_data_create = value #( ( TravelId =  '00004174' AgencyId = '070051'
                              CustomerId = '000002' BeginDate =  cl_abap_context_info=>get_system_date( )
                              EndDate = cl_abap_context_info=>get_system_date( ) + 30
                              BookingFee = 78
                              TotalPrice = 100
                              CurrencyCode = 'USD'
                              Status = 'O'
                              Description = 'TM-AB 13'

                              %control = VALUE #(
                                                   TravelId = if_abap_behv=>mk-on
                                                   AgencyId = if_abap_behv=>mk-on
                                                   CustomerId = if_abap_behv=>mk-on
                                                   BeginDate = if_abap_behv=>mk-on
                                                   EndDate = if_abap_behv=>mk-on
                                                   BookingFee = if_abap_behv=>mk-on
                                                   TotalPrice = if_abap_behv=>mk-on
                                                  CurrencyCode = if_abap_behv=>mk-on
                                                   Status = if_abap_behv=>mk-on
                                                   Description = if_abap_behv=>mk-on

                                                 )

                               ) ).

    MODIFY ENTITIES OF zab_i_trav_aw02_m
    ENTITY Travel
    CREATE FROM it_data_create
    FAILED DATA(it_failed_data)
    REPORTED DATA(it_reported_data).

    if it_failed_data is not INITIAL.
    out->write( 'Data not created ' ).

    endif.


COMMIT ENTITIES.
  ENDMETHOD.
ENDCLASS.
