FUNCTION /gicom/rfc_get_cdhdr_for_wbrk.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"     VALUE(ET_CDHDR) TYPE  CDHDR_TAB
*"----------------------------------------------------------------------
  DATA lo_exception TYPE REF TO /gicom/cx_root.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ccs ).
      et_cdhdr = NEW /gicom/cl_dso_sap_settl_mngt( )->select_cdhdr_of_wbrk( ).

    CATCH /gicom/cx_root INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
