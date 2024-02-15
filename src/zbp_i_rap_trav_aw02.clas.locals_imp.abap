CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF travel_status,
        open     TYPE c LENGTH 1 VALUE 'O',
        accepted TYPE c LENGTH 1 VALUE 'A',
        canceled TYPE c LENGTH 1 VALUE 'X',
      END OF travel_status.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Travel RESULT result.

    METHODS acceptTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~acceptTravel RESULT result.

    METHODS recalcTotalPrice FOR MODIFY
      IMPORTING keys FOR ACTION Travel~recalcTotalPrice.


    METHODS rejectTravel FOR MODIFY
      IMPORTING keys FOR ACTION Travel~rejectTravel RESULT result.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~calculateTotalPrice.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Travel~setInitialStatus.

    METHODS calculateTravelId FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~calculateTravelId.

    METHODS validateAgency FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateAgency.

    METHODS validateCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateCustomer.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~validateDates.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_features.

      "Read the travel status of the existing travels
    READ ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(travels)
      FAILED failed.


    result =
    VALUE #( FOR travel IN travels
               LET is_accepted = COND #( WHEN travel-Status = travel_status-accepted
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled )
                   is_rejected = COND #( WHEN travel-Status = travel_status-canceled
                                         THEN if_abap_behv=>fc-o-disabled
                                         ELSE if_abap_behv=>fc-o-enabled )
               IN
               (  %tky = travel-%tky
                  %action-acceptTravel = is_accepted
                  %action-rejectTravel = is_rejected
                )  ).
  ENDMETHOD.

  METHOD acceptTravel.

      MODIFY ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        UPDATE
          FIELDS ( Status )
            WITH VALUE #( FOR key IN keys
                  ( %tky = key-%tky
                    Status = travel_status-accepted ) )
  FAILED failed
  REPORTED reported.

    "Fill response table
    READ ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    result = VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                              %param = travel ) ).
  ENDMETHOD.

  METHOD recalcTotalPrice.
  ENDMETHOD.

  METHOD rejectTravel.

     MODIFY ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        UPDATE
          FIELDS ( Status )
            WITH VALUE #( FOR key IN keys
                  ( %tky = key-%tky
                    Status = travel_status-canceled ) )
  FAILED failed
  REPORTED reported.

    "Fill response table
    READ ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    result = VALUE #( FOR travel IN travels ( %tky = travel-%tky
                                              %param = travel ) ).


  ENDMETHOD.

  METHOD calculateTotalPrice.

     MODIFY ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        EXECUTE recalcTotalPrice
        FROM CORRESPONDING #( keys )
      REPORTED DATA(execute_reported).

    reported = CORRESPONDING #( DEEP execute_reported ).

  ENDMETHOD.

  METHOD setInitialStatus.

      "Read relevant travel instance data
    READ ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
       FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    "Remove all travel instance data with defined status
    DELETE travels WHERE Status IS NOT INITIAL.
    CHECK travels IS NOT INITIAL.

    "Set default travel Status
    MODIFY ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        UPDATE
          FIELDS ( Status )
          WITH VALUE #( FOR travel IN travels
                        (  %tky = travel-%tky
                           Status = travel_status-open )  )
     REPORTED DATA(upd_reported).

    reported = CORRESPONDING #( DEEP upd_reported ).


  ENDMETHOD.

  METHOD calculateTravelId.

     "Read relevant travel instance data
    READ ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
       FIELDS ( TravelId ) WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    "Remove all travel instance data with ID
    DELETE travels WHERE TravelId IS NOT INITIAL.
    CHECK travels IS NOT INITIAL.

    "Get last ID
    SELECT SINGLE
      FROM zrap_atrav_aw02
      FIELDS MAX( travel_id ) AS travelID
      INTO @DATA(max_travelID).


    "Set the Travel ID
    MODIFY ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
        UPDATE
          FROM VALUE #( FOR travel IN travels INDEX INTO i (  %tky = travel-%tky
                                                              TravelId = max_travelID + i
                                                              %control-TravelId = if_abap_behv=>mk-on )  )
     REPORTED DATA(upd_reported).

    reported = CORRESPONDING #( DEEP upd_reported ).



  ENDMETHOD.

  METHOD validateAgency.

     "Read relevant travel instance data
    READ ENTITIES OF ZI_RAP_TRAV_AW02 IN LOCAL MODE
      ENTITY Travel
       FIELDS ( AgencyId ) WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    DATA agencies TYPE SORTED TABLE OF /dmo/agency WITH UNIQUE KEY agency_id.

    "Optimization of DB Select: Exctract distinct non-initial agenci IDs
    agencies = CORRESPONDING #( travels DISCARDING DUPLICATES MAPPING agency_id = AgencyId EXCEPT * ).

    DELETE agencies WHERE agency_id IS INITIAL.

    IF agencies IS NOT INITIAL.
      "Check if agency ID exist
      SELECT FROM /dmo/agency FIELDS agency_id
         FOR ALL ENTRIES IN @agencies
       WHERE agency_id = @agencies-agency_id
        INTO TABLE @DATA(agencies_db).
    ENDIF.

    LOOP AT travels INTO DATA(travel).

      "Clear state messages that might exist
      APPEND VALUE #( %tky = travel-%tky
                      %state_area = 'VALIDATE_AGENCY'
                    ) TO reported-travel.

      IF travel-AgencyId IS INITIAL OR NOT line_exists( agencies_db[ agency_id = travel-AgencyId ] ).

        APPEND VALUE #( %tky = travel-%tky ) TO failed-travel.

        APPEND VALUE #( %tky = travel-%tky
                        %state_area = 'VALIDATE_AGENCY'
                        %msg = NEW zcm_rap_aw02( severity = if_abap_behv_message=>severity-error
                                               textid = zcm_rap_aw02=>agency_unkown
                                               agencyid = travel-AgencyId )
                        %element-agencyId = if_abap_behv=>mk-on
                        ) TO reported-travel.

      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD validateCustomer.
  ENDMETHOD.

  METHOD validateDates.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
