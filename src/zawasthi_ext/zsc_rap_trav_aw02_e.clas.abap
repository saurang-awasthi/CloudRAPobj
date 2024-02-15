"! <p class="shorttext synchronized" lang="en">Consumption model for client proxy - generated</p>
"! This class has been generated based on the metadata with namespace
"! <em>ZAGENCYCDS_SRV</em>
CLASS zsc_rap_trav_aw02_e DEFINITION
  PUBLIC
  INHERITING FROM /iwbep/cl_v4_abs_pm_model_prov
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      "! <p class="shorttext synchronized" lang="en">Z_TRAVEL_AGENCY_ES5Type</p>
      BEGIN OF tys_z_travel_agency_es_5_type,
        "! <em>Key property</em> AgencyId
        agency_id    TYPE c LENGTH 6,
        "! Name
        name         TYPE c LENGTH 31,
        "! Street
        street       TYPE c LENGTH 30,
        "! PostalCode
        postal_code  TYPE c LENGTH 10,
        "! City
        city         TYPE c LENGTH 25,
        "! Country
        country      TYPE c LENGTH 3,
        "! PhoneNumber
        phone_number TYPE c LENGTH 30,
        "! WebAddress
        web_address  TYPE c LENGTH 255,
      END OF tys_z_travel_agency_es_5_type,
      "! <p class="shorttext synchronized" lang="en">List of Z_TRAVEL_AGENCY_ES5Type</p>
      tyt_z_travel_agency_es_5_type TYPE STANDARD TABLE OF tys_z_travel_agency_es_5_type WITH DEFAULT KEY.


    CONSTANTS:
      "! <p class="shorttext synchronized" lang="en">Internal Names of the entity sets</p>
      BEGIN OF gcs_entity_set,
        "! Z_TRAVEL_AGENCY_ES5
        "! <br/> Collection of type 'Z_TRAVEL_AGENCY_ES5Type'
        z_travel_agency_es_5 TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'Z_TRAVEL_AGENCY_ES_5',
      END OF gcs_entity_set .

    CONSTANTS:
      "! <p class="shorttext synchronized" lang="en">Internal names for entity types</p>
      BEGIN OF gcs_entity_type,
         "! Dummy field - Structure must not be empty
         dummy TYPE int1 VALUE 0,
      END OF gcs_entity_type.


    METHODS /iwbep/if_v4_mp_basic_pm~define REDEFINITION.


  PRIVATE SECTION.

    "! <p class="shorttext synchronized" lang="en">Model</p>
    DATA mo_model TYPE REF TO /iwbep/if_v4_pm_model.


    "! <p class="shorttext synchronized" lang="en">Define Z_TRAVEL_AGENCY_ES5Type</p>
    "! @raising /iwbep/cx_gateway | <p class="shorttext synchronized" lang="en">Gateway Exception</p>
    METHODS def_z_travel_agency_es_5_type RAISING /iwbep/cx_gateway.

ENDCLASS.


CLASS zsc_rap_trav_aw02_e IMPLEMENTATION.

  METHOD /iwbep/if_v4_mp_basic_pm~define.

    mo_model = io_model.
    mo_model->set_schema_namespace( 'ZAGENCYCDS_SRV' ).

    def_z_travel_agency_es_5_type( ).

  ENDMETHOD.


  METHOD def_z_travel_agency_es_5_type.

    DATA:
      lo_complex_property    TYPE REF TO /iwbep/if_v4_pm_cplx_prop,
      lo_entity_type         TYPE REF TO /iwbep/if_v4_pm_entity_type,
      lo_entity_set          TYPE REF TO /iwbep/if_v4_pm_entity_set,
      lo_navigation_property TYPE REF TO /iwbep/if_v4_pm_nav_prop,
      lo_primitive_property  TYPE REF TO /iwbep/if_v4_pm_prim_prop.


    lo_entity_type = mo_model->create_entity_type_by_struct(
                                    iv_entity_type_name       = 'Z_TRAVEL_AGENCY_ES_5_TYPE'
                                    is_structure              = VALUE tys_z_travel_agency_es_5_type( )
                                    iv_do_gen_prim_props         = abap_true
                                    iv_do_gen_prim_prop_colls    = abap_true
                                    iv_do_add_conv_to_prim_props = abap_true ).

    lo_entity_type->set_edm_name( 'Z_TRAVEL_AGENCY_ES5Type' ) ##NO_TEXT.


    lo_entity_set = lo_entity_type->create_entity_set( 'Z_TRAVEL_AGENCY_ES_5' ).
    lo_entity_set->set_edm_name( 'Z_TRAVEL_AGENCY_ES5' ) ##NO_TEXT.


    lo_primitive_property = lo_entity_type->get_primitive_property( 'AGENCY_ID' ).
    lo_primitive_property->set_edm_name( 'AgencyId' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 6 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_key( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'NAME' ).
    lo_primitive_property->set_edm_name( 'Name' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 31 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'STREET' ).
    lo_primitive_property->set_edm_name( 'Street' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'POSTAL_CODE' ).
    lo_primitive_property->set_edm_name( 'PostalCode' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 10 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'CITY' ).
    lo_primitive_property->set_edm_name( 'City' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 25 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'COUNTRY' ).
    lo_primitive_property->set_edm_name( 'Country' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 3 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'PHONE_NUMBER' ).
    lo_primitive_property->set_edm_name( 'PhoneNumber' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 30 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_nullable( ).

    lo_primitive_property = lo_entity_type->get_primitive_property( 'WEB_ADDRESS' ).
    lo_primitive_property->set_edm_name( 'WebAddress' ) ##NO_TEXT.
    lo_primitive_property->set_edm_type( 'String' ) ##NO_TEXT.
    lo_primitive_property->set_max_length( 255 ).
    lo_primitive_property->set_scale_floating( ).
    lo_primitive_property->set_is_nullable( ).

  ENDMETHOD.


ENDCLASS.
