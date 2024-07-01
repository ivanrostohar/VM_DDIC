FUNCTION /gicom/rfc_get_wbrk_analysis_d.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"     VALUE(ET_WBRK) TYPE  /GICOM/WBRK_TT
*"----------------------------------------------------------------------
  DATA lo_exception TYPE REF TO /gicom/cx_root.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).
      et_wbrk = NEW /gicom/cl_dso_sap_settl_mngt( )->select_wbrk_data( ).

    CATCH /gicom/cx_root INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
