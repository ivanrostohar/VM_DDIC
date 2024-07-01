FUNCTION /gicom/rfc_create_sap_setl_doc.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IS_DOCUMENT) TYPE  /GICOM/SAP_SM_MANUAL_DOC_S
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"     VALUE(ET_HEAD_DATA_OUT) TYPE  /GICOM/SAP_SM_MAN_HEAD_OUT_TT
*"     VALUE(ET_ITEM_DATA_OUT) TYPE  /GICOM/SAP_SM_MANUAL_ITEM_TT
*"     VALUE(ET_EXTENSION_OUT) TYPE  /GICOM/CCS_BAPIPAREX_TT
*"----------------------------------------------------------------------
  DATA lx_error_exception TYPE REF TO /gicom/cx_root_ds.
  DATA lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->create_manual_settlement_doc(
        EXPORTING
          is_document       = is_document
        IMPORTING
          et_return         = et_return
          et_head_data_out  = et_head_data_out
          et_item_data_out  = et_item_data_out
          et_extension_out  = et_extension_out
      ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ) TO et_return.
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ) TO et_return.
  ENDTRY.

ENDFUNCTION.
