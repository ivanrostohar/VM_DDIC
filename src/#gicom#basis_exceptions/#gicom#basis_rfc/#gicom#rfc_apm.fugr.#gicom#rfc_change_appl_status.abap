FUNCTION /GICOM/RFC_CHANGE_APPL_STATUS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_APPLICATION_STATUS) TYPE  /GICOM/SAP_SM_APP_STATUS
*"     VALUE(IV_DOCUMENT_NUMBER) TYPE  /GICOM/DOC_NUMBER
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->change_application_status(
        EXPORTING
          iv_application_status = iv_application_status
          iv_document_number    = iv_document_number
        RECEIVING
          rt_return             = et_return
      ).

    CATCH /gicom/cx_no_auth_rfc INTO DATA(lx_no_auth_rfc).
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ) TO et_return.
    CATCH /gicom/cx_root_ds INTO DATA(lx_error_exception).
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ) TO et_return.
  ENDTRY.


ENDFUNCTION.
