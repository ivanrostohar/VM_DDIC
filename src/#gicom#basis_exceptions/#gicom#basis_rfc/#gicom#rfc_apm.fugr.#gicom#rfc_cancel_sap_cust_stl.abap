FUNCTION /GICOM/RFC_CANCEL_SAP_CUST_STL.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_INVOICE_DATE) TYPE  /GICOM/DATE_POST
*"     VALUE(IV_CANCELLATION_REASON) TYPE  /GICOM/SAP_SM_CANCEL_REASON
*"     VALUE(IT_HEAD_DATA_IN) TYPE  /GICOM/SAP_SM_CANCEL_HEADIN_TT
*"  EXPORTING
*"     VALUE(ET_MESSAGE) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA lx_error_exception TYPE REF TO /gicom/cx_root_ds.
  DATA lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).
      et_message = NEW /gicom/cl_dso_sap_settl_mngt( )->cancel_consolidate_cust_settl(
          iv_invoice_date        = iv_invoice_date
          iv_cancellation_reason = iv_cancellation_reason
          it_head_data_in        = it_head_data_in
      ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ) TO et_message.
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ) TO et_message.
  ENDTRY.
ENDFUNCTION.
