FUNCTION /GICOM/RFC_GET_SAP_OBJECT_STAT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CLIENT) TYPE  SYST_MANDT DEFAULT SY-MANDT
*"  EXPORTING
*"     VALUE(EV_FETCH_NUMBERS) TYPE  SYST_TABIX
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  CHANGING
*"     VALUE(CT_SAP_OBJECT) TYPE  /GICOM/SAP_STATUS_OBJECT_TT
*"     VALUE(CT_SAP_OBJECT_DATA) TYPE  /GICOM/SAP_STATUS_OBJ_DATA_TT
*"     VALUE(CT_SAP_OBJECT_STATUS) TYPE  /GICOM/SAP_STATUS_OBJ_STAT_TT
*"----------------------------------------------------------------------
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_sap_basis ).

      NEW /gicom/cl_dso_sap_basis( )->get_status_of_sap_object(
        EXPORTING
          iv_client            = iv_client
        IMPORTING
          ev_fetch_numbers     = ev_fetch_numbers
        CHANGING
          ct_sap_object        = ct_sap_object
          ct_sap_object_data   = ct_sap_object_data
          ct_sap_object_status = ct_sap_object_status
      ).

    CATCH /gicom/cx_internal_error INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
