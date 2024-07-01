FUNCTION /gicom/rfc_read_purchase_grp.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_PURCHASE_GRPS) TYPE  /GICOM/CPURCHASE_GRP_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_purch_grp ).

      NEW /gicom/cl_dso_purchase_grp( )->select_purchase_grps(
      IMPORTING
          et_purchase_grps  = et_purchase_grps ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
