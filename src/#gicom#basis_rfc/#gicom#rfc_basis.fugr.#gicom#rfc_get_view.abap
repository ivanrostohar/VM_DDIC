FUNCTION /gicom/rfc_get_view.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_LANGU) TYPE  SY-LANGU
*"  EXPORTING
*"     VALUE(EV_STATE) TYPE  DDGOTSTATE
*"     VALUE(ES_DD25V) TYPE  DD25V
*"     VALUE(ES_DD09L) TYPE  DD09V
*"     VALUE(ET_DD26V) TYPE  DD26VTAB
*"     VALUE(ET_DD27P) TYPE  DD27PTAB
*"     VALUE(ET_DD28J) TYPE  /GICOM/DD28J_TT
*"     VALUE(ET_DD28V) TYPE  DD28VTAB
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      NEW /gicom/cl_dso_ddic_eng( )->get_view(
        EXPORTING
          iv_name  = iv_name
          iv_langu = iv_langu
        IMPORTING
          ev_state = ev_state
          es_dd25v = es_dd25v
          es_dd09l = es_dd09l
          et_dd26v = et_dd26v
          et_dd27p = et_dd27p
          et_dd28j = et_dd28j
          et_dd28v = et_dd28v
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.



ENDFUNCTION.
