FUNCTION /GICOM/DDIF_TABL_PUT .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IS_DD02V_WA) TYPE  DD02V DEFAULT ' '
*"     VALUE(IS_DD09L_WA) TYPE  DD09V DEFAULT ' '
*"  TABLES
*"      DD03P_TAB STRUCTURE  DD03P OPTIONAL
*"      DD05M_TAB STRUCTURE  DD05M OPTIONAL
*"      DD08V_TAB STRUCTURE  DD08V OPTIONAL
*"      DD35V_TAB STRUCTURE  DD35V OPTIONAL
*"      DD36M_TAB STRUCTURE  DD36M OPTIONAL
*"  EXCEPTIONS
*"      TABL_NOT_FOUND
*"      NAME_INCONSISTENT
*"      TABL_INCONSISTENT
*"      PUT_FAILURE
*"      PUT_REFUSED
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_TABL_PUT'
    EXPORTING
      name              = iv_name
      dd02v_wa          = is_dd02v_wa
      dd09l_wa          = is_dd09l_wa
    TABLES
      dd03p_tab         = dd03p_tab
      dd05m_tab         = dd05m_tab
      dd08v_tab         = dd08v_tab
      dd35v_tab         = dd35v_tab
      dd36m_tab         = dd36m_tab
    EXCEPTIONS
      tabl_not_found    = 1
      name_inconsistent = 2
      tabl_inconsistent = 3
      put_failure       = 4
      put_refused       = 5
      OTHERS            = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
