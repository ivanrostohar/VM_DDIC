FUNCTION /gicom/rfc_read_company_code.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_CUCO) TYPE  /GICOM/COMPANY_CODE_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lo_exception TYPE REF TO /gicom/cx_root_da.
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_company_code ).

      et_cuco = NEW /gicom/cl_dso_company_code( )->select_company_codes( ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.



ENDFUNCTION.
