FUNCTION /GICOM/DDIF_TABL_GET .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_STATE) TYPE  DDOBJSTATE DEFAULT 'A'
*"     VALUE(IV_LANGU) TYPE  SY-LANGU DEFAULT ' '
*"  EXPORTING
*"     VALUE(EV_GOTSTATE) TYPE  DDGOTSTATE
*"     VALUE(ES_DD02V_WA) TYPE  DD02V
*"     VALUE(ES_DD09L_WA) TYPE  DD09V
*"  TABLES
*"      DD03P_TAB STRUCTURE  DD03P OPTIONAL
*"      DD05M_TAB STRUCTURE  DD05M OPTIONAL
*"      DD08V_TAB STRUCTURE  DD08V OPTIONAL
*"      DD12V_TAB STRUCTURE  DD12V OPTIONAL
*"      DD17V_TAB STRUCTURE  DD17V OPTIONAL
*"      DD35V_TAB STRUCTURE  DD35V OPTIONAL
*"      DD36M_TAB STRUCTURE  DD36M OPTIONAL
*"  EXCEPTIONS
*"      ILLEGAL_INPUT
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_TABL_GET'
    EXPORTING
      name          = iv_name
      state         = iv_state
      langu         = iv_langu
    IMPORTING
      gotstate      = ev_gotstate
      dd02v_wa      = es_dd02v_wa
      dd09l_wa      = es_dd09l_wa
    TABLES
      dd03p_tab     = dd03p_tab
      dd05m_tab     = dd05m_tab
      dd08v_tab     = dd08v_tab
      dd12v_tab     = dd12v_tab
      dd17v_tab     = dd17v_tab
      dd35v_tab     = dd35v_tab
      dd36m_tab     = dd36m_tab
    EXCEPTIONS
      illegal_input = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
