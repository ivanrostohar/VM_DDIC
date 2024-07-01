FUNCTION /GICOM/DDIF_DTEL_GET .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_STATE) TYPE  DDOBJSTATE DEFAULT 'A'
*"     VALUE(IV_LANGU) TYPE  SY-LANGU DEFAULT ' '
*"  EXPORTING
*"     VALUE(EV_GOTSTATE) TYPE  DDGOTSTATE
*"     VALUE(ES_DD04V_WA) TYPE  DD04V
*"     VALUE(ES_TPARA_WA) TYPE  TPARA
*"  EXCEPTIONS
*"      ILLEGAL_INPUT
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_DTEL_GET'
    EXPORTING
      name          = iv_name
      state         = iv_state
      langu         = iv_langu
    IMPORTING
      gotstate      = ev_gotstate
      dd04v_wa      = es_dd04v_wa
      tpara_wa      = es_tpara_wa
    EXCEPTIONS
      illegal_input = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
