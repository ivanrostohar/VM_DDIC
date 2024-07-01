FUNCTION /GICOM/RFC_GET_DATAELEMENT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_LANG) TYPE  SY-LANGU
*"  EXPORTING
*"     VALUE(EV_STATE) TYPE  DDGOTSTATE
*"     VALUE(ES_DD04V) TYPE  DD04V
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      NEW /gicom/cl_dso_ddic_eng( )->get_dataelement(
                                      EXPORTING
                                        iv_name  = iv_name
                                        iv_lang  = iv_lang
                                      IMPORTING
                                        ev_state = ev_state
                                        es_dd04v = es_dd04v
                                           ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
