FUNCTION /gicom/rfc_create_function.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_FUNCNAME) TYPE  RS38L-NAME
*"     VALUE(IV_FUNC_POOL) TYPE  RS38L-AREA
*"     VALUE(IV_SHORT_TEXT) TYPE  RS38L_FTXT OPTIONAL
*"     VALUE(IT_SOURCE) TYPE  RSFB_SOURCE OPTIONAL
*"  EXPORTING
*"     VALUE(EV_FUN_INCLUDE) TYPE  RS38L-INCLUDE
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  CHANGING
*"     VALUE(CV_TRKORR) TYPE  TRKORR
*"     VALUE(CT_EXC_LIST) TYPE  RSFB_EXC OPTIONAL
*"     VALUE(CT_EXP_PARAMS) TYPE  RSFB_EXP OPTIONAL
*"     VALUE(CT_IMP_PARAMS) TYPE  RSFB_IMP OPTIONAL
*"     VALUE(CT_PAR_DOCU) TYPE  SIW_TAB_RSFDO OPTIONAL
*"     VALUE(CT_TAB_PARAMS) TYPE  RSFB_TBL OPTIONAL
*"     VALUE(CT_CHA_PARAMS) TYPE  RSFB_CHA OPTIONAL
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_repos_engine ).

      ev_fun_include = NEW /gicom/cl_dso_repos_eng( )->create_function(
        EXPORTING
           iv_funcname    = iv_funcname
           iv_func_pool   = iv_func_pool
           iv_short_text  = iv_short_text
           it_source      = it_source
        CHANGING
           cv_trkorr      = cv_trkorr
           ct_exc_list    = ct_exc_list
           ct_exp_params  = ct_exp_params
           ct_imp_params  = ct_imp_params
           ct_par_docu    = ct_par_docu
           ct_tab_params  = ct_tab_params
           ct_cha_params  = ct_cha_params
       ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
