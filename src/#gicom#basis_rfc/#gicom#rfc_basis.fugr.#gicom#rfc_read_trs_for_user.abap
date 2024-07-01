FUNCTION /gicom/rfc_read_trs_for_user.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_UNAME) TYPE  TR_AS4USER DEFAULT SY-UNAME
*"     VALUE(IV_CLIENT) TYPE  MANDT DEFAULT SY-MANDT
*"     VALUE(IV_TR_TYPE) TYPE  TRFUNCTION DEFAULT 'K'
*"  EXPORTING
*"     VALUE(ET_E07T) TYPE  TT_E07T
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY .

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_tr_engine ).

      et_e07t = NEW /gicom/cl_dso_tr_eng( )->select_trans_reqs_for_user(
         EXPORTING
           iv_uname   = iv_uname
           iv_client  = iv_client
           iv_tr_type = iv_tr_type
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
