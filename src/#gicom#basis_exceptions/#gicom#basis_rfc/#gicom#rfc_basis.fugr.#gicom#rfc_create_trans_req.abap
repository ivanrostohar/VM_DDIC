FUNCTION /gicom/rfc_create_trans_req.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_PACKAGE) TYPE  DEVCLASS OPTIONAL
*"     VALUE(IS_TR_REQ_COMM) TYPE  /GICOM/TRNSPT_REQ_COMM_S
*"  EXPORTING
*"     VALUE(ES_TR_REQ_COMM) TYPE  /GICOM/TRNSPT_REQ_COMM_S
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  TRY .

      es_tr_req_comm = is_tr_req_comm.

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_tr_engine ).

      NEW /gicom/cl_dso_tr_eng( )->create_transport_request(
        EXPORTING
          iv_package     = iv_package
        IMPORTING
          es_tr_req_comm = es_tr_req_comm
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
