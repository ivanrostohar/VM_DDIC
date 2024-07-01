FUNCTION /gicom/rfc_tgr_stl_req_msg_out.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_STL_DOC_NO) TYPE  /GICOM/SAP_SM_DOC_NR_SGL
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA:lx_error_exception TYPE REF TO /gicom/cx_root_ds,
       lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      et_return = NEW /gicom/cl_dso_sap_settl_mngt( )->trigger_settl_req_message_out( iv_stl_doc_no ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ) TO et_return.
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ) TO et_return.
  ENDTRY.

ENDFUNCTION.
