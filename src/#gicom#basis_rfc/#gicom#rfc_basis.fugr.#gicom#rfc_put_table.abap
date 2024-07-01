FUNCTION /gicom/rfc_put_table.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  DDOBJNAME
*"     VALUE(IV_TRKORR) TYPE  TRKORR OPTIONAL
*"     VALUE(IV_DEVCLASS) TYPE  DEVCLASS
*"     VALUE(IS_DD02V_WA) TYPE  DD02V
*"     VALUE(IS_DD09L_WA) TYPE  DD09V
*"     VALUE(IT_DD03P_TAB) TYPE  DD03PTAB
*"  EXPORTING
*"     VALUE(EV_SUBRC) TYPE  SY-SUBRC
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine  ).

      ev_subrc = NEW /gicom/cl_dso_ddic_eng( )->put_table(
                   EXPORTING
                     iv_tabname   = iv_tabname
                     iv_devclass  = iv_devclass
                     iv_trkorr    = iv_trkorr
                     is_dd02v_wa  = is_dd02v_wa
                     is_dd09l_wa  = is_dd09l_wa
                     it_dd03p_tab = it_dd03p_tab ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
