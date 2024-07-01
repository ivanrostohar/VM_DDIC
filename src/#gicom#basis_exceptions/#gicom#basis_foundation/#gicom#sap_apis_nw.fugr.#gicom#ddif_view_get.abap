FUNCTION /gicom/ddif_view_get.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_STATE) TYPE  DDOBJSTATE DEFAULT 'A'
*"     VALUE(IV_LANGU) TYPE  SY-LANGU DEFAULT ' '
*"  EXPORTING
*"     VALUE(EV_GOTSTATE) TYPE  DDGOTSTATE
*"     VALUE(ES_DD25V_WA) TYPE  DD25V
*"     VALUE(ES_DD09L_WA) TYPE  DD09V
*"  TABLES
*"      DD26V_TAB STRUCTURE  DD26V OPTIONAL
*"      DD27P_TAB STRUCTURE  DD27P OPTIONAL
*"      DD28J_TAB STRUCTURE  DD28J OPTIONAL
*"      DD28V_TAB STRUCTURE  DD28V OPTIONAL
*"  EXCEPTIONS
*"      ILLEGAL_INPUT
*"----------------------------------------------------------------------

  CALL FUNCTION 'DDIF_VIEW_GET'
    EXPORTING
      name          = iv_name
      state         = iv_state
      langu         = iv_langu
    IMPORTING
      gotstate      = ev_gotstate
      dd25v_wa      = es_dd25v_wa
      dd09l_wa      = es_dd09l_wa
    TABLES
      dd26v_tab     = dd26v_tab
      dd27p_tab     = dd27p_tab
      dd28j_tab     = dd28j_tab
      dd28v_tab     = dd28v_tab
    EXCEPTIONS
      illegal_input = 1
      OTHERS        = 2.

ENDFUNCTION.
