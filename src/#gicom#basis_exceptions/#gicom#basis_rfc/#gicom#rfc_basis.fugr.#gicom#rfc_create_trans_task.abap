FUNCTION /gicom/rfc_create_trans_task.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IS_TR_REQ_COMM) TYPE  /GICOM/TRNSPT_REQ_COMM_S
*"  EXPORTING
*"     VALUE(EV_TASK) TYPE  TRKORR
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------


  TRY .

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_tr_engine ).

      NEW /gicom/cl_dso_tr_eng( )->create_transport_task(
        IMPORTING
          es_tr_req_comm = is_tr_req_comm
        RECEIVING
          rv_task        = ev_task
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
