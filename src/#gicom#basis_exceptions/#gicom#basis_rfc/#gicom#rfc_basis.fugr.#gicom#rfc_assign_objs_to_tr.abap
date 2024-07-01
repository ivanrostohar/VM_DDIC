FUNCTION /gicom/rfc_assign_objs_to_tr.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TRKORR) TYPE  TRKORR
*"  EXPORTING
*"     VALUE(EV_TRKORR) TYPE  TRKORR
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  CHANGING
*"     VALUE(CT_E071) TYPE  TREDT_OBJECTS
*"     VALUE(CT_E071K) TYPE  TREDT_KEYS OPTIONAL
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------
  TRY .

      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_tr_engine ).

      ev_trkorr = NEW /gicom/cl_dso_tr_eng( )->assign_objs_to_transport_req(
        EXPORTING
          iv_trkorr = iv_trkorr
        CHANGING
          ct_e071   = ct_e071
          ct_e071k  = ct_e071k
      ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
