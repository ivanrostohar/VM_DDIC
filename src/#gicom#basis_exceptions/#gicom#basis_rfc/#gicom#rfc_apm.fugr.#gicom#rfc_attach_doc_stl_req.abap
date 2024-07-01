FUNCTION /GICOM/RFC_ATTACH_DOC_STL_REQ.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_STL_DOC_NO) TYPE  /GICOM/SAP_SM_DOC_NR_SGL
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  CHANGING
*"     VALUE(CT_DOCUMENTS) TYPE  /GICOM/DOCUMENT_DATA_TT
*"----------------------------------------------------------------------

    TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).

      NEW /gicom/cl_dso_sap_settl_mngt( )->attach_docs_to_sap_settl_req(
        EXPORTING
          iv_stl_doc_no = iv_stl_doc_no
        CHANGING
          ct_documents  = ct_documents
      ).

    CATCH /gicom/cx_root INTO DATA(lo_exception).

    ENDTRY.


ENDFUNCTION.
