CLASS /gicom/cl_dso_sap_basis DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_sap_basis.


    ALIASES get_status_of_sap_object
     FOR /gicom/if_dso_sap_basis~get_status_of_sap_object.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      get_badi
        RETURNING
          VALUE(rb_badi) TYPE REF TO /gicom/badi_ds_sap_basis.

ENDCLASS.



CLASS /GICOM/CL_DSO_SAP_BASIS IMPLEMENTATION.


  METHOD get_badi.
    GET BADI rb_badi.
  ENDMETHOD.


  METHOD /gicom/if_dso_sap_basis~get_status_of_sap_object.

    DATA(lo_badi) = me->get_badi( ).

    CALL BADI lo_badi->get_status_of_sap_object
      CHANGING
        ct_sap_object        = ct_sap_object
        ct_sap_object_data   = ct_sap_object_data
        ct_sap_object_status = ct_sap_object_status.

    "DEL TL M.20772 call BADI
*    DATA: lt_sap_object        TYPE STANDARD TABLE OF crm_jsto_pre,
*          lt_sap_object_data   TYPE STANDARD TABLE OF crm_jsto,
*          lt_sap_object_status TYPE STANDARD TABLE OF crm_jest.
*
*    lt_sap_object        = CORRESPONDING #( ct_sap_object ).
*    lt_sap_object_data   = CORRESPONDING #( ct_sap_object_data ).
*    lt_sap_object_status = CORRESPONDING #( ct_sap_object_status ).
*
*    CALL FUNCTION 'CRM_STATUS_PRE_READ_DATA'
*      EXPORTING
*        client            = iv_client
*      IMPORTING
*        number_of_fetches = ev_fetch_numbers
*      TABLES
*        jsto_pre_tab      = lt_sap_object
*        jsto_data_table   = lt_sap_object_data
*        jest_data_table   = lt_sap_object_status.
*
*    ct_sap_object        = CORRESPONDING #( lt_sap_object ).
*    ct_sap_object_data   = CORRESPONDING #( lt_sap_object_data ).
*    ct_sap_object_status = CORRESPONDING #( lt_sap_object_status ).
    "DEL TL M.20772 call BADI

  ENDMETHOD.
ENDCLASS.
