FUNCTION /GICOM/RFC_CREATE_SAP_CCS_DOC.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EXTERNAL_GUID) TYPE  /GICOM/CCS_WCB_EXT_GUID
*"     VALUE(IV_SETTLEMENT_DATE) TYPE  /GICOM/CCS_WB2_SETTLEMENT_DATE
*"     VALUE(IV_SETTLEMENT_DATE_TYPE) TYPE
*"        /GICOM/STL_DATE_TYPE_STETTLE
*"     VALUE(IV_INVOICE_DATE) TYPE  /GICOM/DATE_POST
*"     VALUE(IV_DOCUMENT_DATE) TYPE  /GICOM/DATE_DOCUMENT
*"     VALUE(IV_WITH_ITEMS) TYPE  /GICOM/SAP_SM_X_SETL_WITH_ITEM
*"     VALUE(IV_TESTRUN) TYPE  /GICOM/SAP_SM_X_TESTRUN
*"  EXPORTING
*"     VALUE(ES_SETTLE_HEAD_OUT) TYPE  /GICOM/SAP_SM_CC_SETTL_HEAD_S
*"     VALUE(ET_SETTLE_DOC_OUT) TYPE  /GICOM/SAP_SM_STL_DOC_OUT_TT
*"     VALUE(ET_HEAD_DATA_OUT) TYPE  /GICOM/SAP_SM_STL_HEAD_OUT_TT
*"     VALUE(ET_ITEM_DATA_OUT) TYPE  /GICOM/SAP_SM_STL_ITEM_OUT_TT
*"     VALUE(ET_EXTENSION_OUT) TYPE  /GICOM/CCS_BAPIPAREX_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA lx_error_exception TYPE REF TO /gicom/cx_root_ds.
  DATA lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.
  DATA lx_sap_call_error TYPE REF TO /gicom/cx_sap_call_error.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->create_sap_coco_settl_document(
        EXPORTING
          iv_external_guid         = iv_external_guid
          iv_settlement_date       = iv_settlement_date
          iv_settlement_date_type  = iv_settlement_date_type
          iv_invoice_date          = iv_invoice_date
          iv_document_date         = iv_document_date
          iv_with_items            = iv_with_items
          iv_testrun               = iv_testrun
        IMPORTING
          es_settle_head_out       = es_settle_head_out
          et_settle_doc_out        = et_settle_doc_out
          et_head_data_out         = et_head_data_out
          et_item_data_out         = et_item_data_out
          et_extension_out         = et_extension_out
          et_return                = et_return
      ).
    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ) TO et_return.
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ) TO et_return.
  ENDTRY.

ENDFUNCTION.
