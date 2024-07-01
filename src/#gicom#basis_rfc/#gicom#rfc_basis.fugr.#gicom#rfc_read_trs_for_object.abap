FUNCTION /gicom/rfc_read_trs_for_object.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_OBJECT) TYPE  TROBJTYPE
*"     VALUE(IV_OBJ_NAME) TYPE  TROBJ_NAME
*"  EXPORTING
*"     VALUE(EV_TRKORR) TYPE  TRKORR
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY .

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_tr_engine ).

      ev_trkorr = NEW /gicom/cl_dso_tr_eng( )->select_trans_req_for_object(
         iv_object   = iv_object
         iv_obj_name = iv_obj_name
       ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.



ENDFUNCTION.
