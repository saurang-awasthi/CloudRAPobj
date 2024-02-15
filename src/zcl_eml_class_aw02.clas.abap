CLASS zcl_eml_class_aw02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eml_class_aw02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**" Case 1 : READ Entities with specified fields
*    READ ENTITIES OF zi_rap_trav_aw02
*    ENTITY Travel
*    FIELDS ( AgencyID CustomerID )
*    WITH VALUE #( ( Travel_UUID = 'E91E1770C2C062D01800A69AD35E4F1B' ) )
*    RESULT DATA(travels)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*
*
*
*    out->write( travels ).
*    out->write( failed ).
*    out->write( reported ).

*" Case 2 : READ Entities for All fields
*
*    READ ENTITIES OF zi_rap_trav_aw02
*    ENTITY Travel
*    ALL FIELDS WITH VALUE #( ( Travel_Uuid = 'E91E1770C2C062D01800A69AD35E4F1B' ) )
*    RESULT DATA(travels)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*
*    out->write( travels ).
*    out->write( failed ).
*    out->write( reported ).

*" Case 3 : READ Entities for All fields for association
*    READ ENTITIES OF zi_rap_trav_aw02
*    ENTITY Travel BY \_Booking
*    ALL FIELDS WITH VALUE #( ( Travel_Uuid = 'E91E1770C2C062D01800A69AD35E4F1B' ) )
*    RESULT DATA(travels)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*
*    out->write( travels ).
*    out->write( failed ).
*    out->write( reported ).


*" Case 4 : Modify Entities for single fields for association
*    MODIFY ENTITIES OF zi_rap_trav_aw02
*    ENTITY Travel
*    UPDATE
*    SET FIELDS WITH VALUE
*    #( (  Travel_UUID = 'E91E1770C2C062D01800A69AD35E4F1B'
*    Description = 'I like Rap' ) )
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*
*    out->write( 'update done' ).
*
*
*    COMMIT ENTITIES
*    RESPONSE OF zi_rap_trav_aw02
*    FAILED DATA(failed_commit)
*    REPORTED DATA(reported_commit).
*
*    out->write( reported_commit ).

" Case 4 : Modify Entities Create for All fields for association

*    MODIFY ENTITIES OF zi_rap_trav_aw02
*    ENTITY Travel
*    CREATE
*    SET FIELDS WITH VALUE
*    #( ( %cid = 'MyContentID_2'
*    AgencyId = '070050'
*    CustomerId = '14'
*    BeginDate = cl_abap_context_info=>get_system_date(  )
*    EndDate   = cl_abap_context_info=>get_system_date(  ) + 10
*    Description = 'I like RAP EML'
*
*    ) )
*     MAPPED DATA(mapped)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*
*    out->write( mapped-travel ).
*
*
*    COMMIT ENTITIES
*    RESPONSE OF zi_rap_trav_aw02
*    FAILED DATA(failed_commit)
*    REPORTED DATA(reported_commit).
*
*    out->write( 'create done' ).


" Case 5 : Modify Entities Delete for All fields for association

*        MODIFY ENTITIES OF zi_rap_trav_aw02
*        ENTITY Travel
*        DELETE FROM
*        VALUE
*        #(  ( Travel_UUID = '261E1770C2C062D01800A69AD35E4F1B' ) )
*        FAILED DATA(failed)
*        REPORTED DATA(reported).
*
*        COMMIT ENTITIES
*            RESPONSE OF zi_rap_trav_aw02
*            FAILED DATA(failed_commit)
*            REPORTED DATA(reported_commit).
*
*        out->write( 'delete done' ).

  ENDMETHOD.
ENDCLASS.
