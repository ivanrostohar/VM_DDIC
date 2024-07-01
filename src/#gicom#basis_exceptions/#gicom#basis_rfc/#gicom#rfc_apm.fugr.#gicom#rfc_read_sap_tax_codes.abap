FUNCTION /GICOM/RFC_READ_SAP_TAX_CODES.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_TAX_CODES) TYPE  /GICOM/SAP_TAX_CODE_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA lx_error_exception TYPE REF TO /gicom/cx_root_da.
  DATA lx_no_auth_rfc TYPE REF TO /gicom/cx_no_auth_rfc.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_tax  ).

      et_tax_codes = NEW /gicom/cl_dso_tax_code( )->select_tax_codes( ).

    CATCH /gicom/cx_no_auth_rfc INTO lx_no_auth_rfc.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_no_auth_rfc ).
    CATCH /gicom/cx_root_da INTO lx_error_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_error_exception ).
  ENDTRY.

ENDFUNCTION.
