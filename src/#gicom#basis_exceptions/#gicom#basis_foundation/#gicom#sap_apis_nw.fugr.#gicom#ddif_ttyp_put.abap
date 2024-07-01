FUNCTION /GICOM/DDIF_TTYP_PUT .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IS_DD40V_WA) TYPE  DD40V DEFAULT ' '
*"  TABLES
*"      DD42V_TAB STRUCTURE  DD42V OPTIONAL
*"      DD43V_TAB STRUCTURE  DD43V OPTIONAL
*"  EXCEPTIONS
*"      TTYP_NOT_FOUND
*"      NAME_INCONSISTENT
*"      TTYP_INCONSISTENT
*"      PUT_FAILURE
*"      PUT_REFUSED
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_TTYP_PUT'
    EXPORTING
      name              = iv_name
      dd40v_wa          = is_dd40v_wa
    TABLES
      dd42v_tab         = dd42v_tab
      dd43v_tab         = dd43v_tab
    EXCEPTIONS
      ttyp_not_found    = 1
      name_inconsistent = 2
      ttyp_inconsistent = 3
      put_failure       = 4
      put_refused       = 5
      OTHERS            = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
