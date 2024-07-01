FUNCTION /GICOM/DDIF_DOMA_GET .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_STATE) TYPE  DDOBJSTATE DEFAULT 'A'
*"     VALUE(IV_LANGU) TYPE  SY-LANGU DEFAULT ' '
*"  EXPORTING
*"     VALUE(EV_GOTSTATE) TYPE  DDGOTSTATE
*"     VALUE(ES_DD01V_WA) TYPE  DD01V
*"  TABLES
*"      DD07V_TAB STRUCTURE  DD07V OPTIONAL
*"  EXCEPTIONS
*"      ILLEGAL_INPUT
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_DOMA_GET'
    EXPORTING
      name          = iv_name
      state         = iv_state
      langu         = iv_langu
    IMPORTING
      gotstate      = ev_gotstate
      dd01v_wa      = es_dd01v_wa
    TABLES
      dd07v_tab     = dd07v_tab
    EXCEPTIONS
      illegal_input = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
