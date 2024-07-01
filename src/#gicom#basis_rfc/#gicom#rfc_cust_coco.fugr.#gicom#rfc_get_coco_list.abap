FUNCTION /GICOM/RFC_GET_COCO_LIST.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     VALUE(ET_COCO) TYPE  /GICOM/COMPANY_CODE_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_company_code ).

      et_coco = NEW /gicom/cl_dso_company_code( )->select_company_codes( ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_err).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_err ).

  ENDTRY.



ENDFUNCTION.
