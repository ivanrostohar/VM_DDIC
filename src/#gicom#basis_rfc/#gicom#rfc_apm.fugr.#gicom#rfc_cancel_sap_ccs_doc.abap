FUNCTION /gicom/rfc_cancel_sap_ccs_doc.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_INVOICE_DATE) TYPE  /GICOM/DATE_POST
*"     VALUE(IV_CANCELLATION_REASON) TYPE  /GICOM/SAP_SM_CANCEL_REASON
*"     VALUE(IV_EXCLUDE_DELETE) TYPE  /GICOM/SAP_SM_X_EXCLUDE_DELETE
*"     VALUE(IT_COND_CNTR_IDENTIFIER) TYPE
*"        /GICOM/CCS_BAPICCIDENTIFIER_TT
*"     VALUE(IT_SETTL_DATE) TYPE  /GICOM/CCS_BAPI_RNGSETLDATE_TT
*"     VALUE(IT_USE_CASE_TYPE) TYPE  /GICOM/CCS_BAPI_RNGUSECASE_TT
*"  EXPORTING
*"     VALUE(ET_CANCEL_DOC) TYPE  /GICOM/CCS_BAPICCTODOC_TT
*"     VALUE(ET_ERROR_CONTRACT) TYPE  /GICOM/CCS_BAPICCTODOC_TT
*"     VALUE(ET_MAP_FOR_EXT_GUID) TYPE  /GICOM/CCS_BAPICCIDENTIFIER_TT
*"     VALUE(ET_MESSAGE) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA lx_error_exception TYPE REF TO /gicom/cx_root_ds.
  DATA lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->cancel_cc_multiple_settlement(
          EXPORTING
              iv_invoice_date         = iv_invoice_date    " Book date
              iv_cancellation_reason  = iv_cancellation_reason     " Activity Reason for Document Cancellation
              iv_exclude_delete       = iv_exclude_delete    " Single character flag
              it_cond_cntr_identifier = it_cond_cntr_identifier    " Table type - Condition Contract Identifier
              it_settl_date           = it_settl_date    " Table type - Settlement date selection
              it_use_case_type        = it_use_case_type " Use case type
          IMPORTING
              et_cancel_doc           = et_cancel_doc    " Table type - Cond. contract and settlement doc.
              et_error_contract       = et_error_contract    " Table type - Cond. contract and settlement doc.
              et_map_for_ext_guid     = et_map_for_ext_guid    " Table type - Condition Contract Identifier
              et_message              = et_message
      ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ) TO et_message.
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ) TO et_message.
  ENDTRY.
ENDFUNCTION.
