FUNCTION /gicom/rfc_ins_sap_doc_entry.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IS_DOCUMENT) TYPE  /GICOM/SAP_DOC_ENTRY_S
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"     VALUE(ET_DOCUMENT_HEADER) TYPE  /GICOM/SAP_DOC_ENTRY_HEAD_TT
*"     VALUE(ET_DOCUMENT_ITEMS) TYPE  /GICOM/SAP_DOC_ENTRY_ITEM_TT
*"----------------------------------------------------------------------
  DATA lx_error_exception TYPE REF TO /gicom/cx_root_ds.
  DATA lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->create_doc_entry(
        EXPORTING
          is_document          = is_document
        IMPORTING
          et_return            = et_return
          et_document_header   = et_document_header
          et_document_items    = et_document_items
      ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ) TO et_return.
    CATCH /gicom/cx_root_ds INTO lx_error_exception.
      APPEND LINES OF /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ) TO et_return.
  ENDTRY.

ENDFUNCTION.
