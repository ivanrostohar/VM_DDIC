FUNCTION /GICOM/RFC_READ_SAP_SETTL_CUST.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_PROCESS_TYPE) TYPE  /GICOM/SAP_SM_PROCESS_TYPE_TT
*"     VALUE(ET_DOCUMENT_TYPE) TYPE  /GICOM/SAP_SM_DOC_TYPE_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA lx_error_exception TYPE REF TO /gicom/cx_root_ds.
  DATA lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->select_settlement_customizing(
        IMPORTING
          et_document_type = et_document_type
          et_process_type = et_process_type
      ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ).
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ).
  ENDTRY.

ENDFUNCTION.
