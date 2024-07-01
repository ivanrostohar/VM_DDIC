FUNCTION /GICOM/DDIF_TTYP_GET .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_STATE) TYPE  DDOBJSTATE DEFAULT 'A'
*"     VALUE(IV_LANGU) TYPE  SY-LANGU DEFAULT ' '
*"  EXPORTING
*"     VALUE(EV_GOTSTATE) TYPE  DDGOTSTATE
*"     VALUE(ES_DD40V_WA) TYPE  DD40V
*"  TABLES
*"      DD42V_TAB STRUCTURE  DD42V OPTIONAL
*"      DD43V_TAB STRUCTURE  DD43V OPTIONAL
*"  EXCEPTIONS
*"      ILLEGAL_INPUT
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_TTYP_GET'
    EXPORTING
      name          = iv_name
      state         = iv_state
      langu         = iv_langu
    IMPORTING
      gotstate      = ev_gotstate
      dd40v_wa      = es_dd40v_wa
    TABLES
      dd42v_tab     = dd42v_tab
      dd43v_tab     = dd43v_tab
    EXCEPTIONS
      illegal_input = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
