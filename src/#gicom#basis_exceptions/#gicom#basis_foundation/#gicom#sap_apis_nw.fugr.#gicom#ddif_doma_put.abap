FUNCTION /GICOM/DDIF_DOMA_PUT .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IS_DD01V_WA) TYPE  DD01V DEFAULT ' '
*"  TABLES
*"      DD07V_TAB STRUCTURE  DD07V OPTIONAL
*"  EXCEPTIONS
*"      DOMA_NOT_FOUND
*"      NAME_INCONSISTENT
*"      DOMA_INCONSISTENT
*"      PUT_FAILURE
*"      PUT_REFUSED
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_DOMA_PUT'
    EXPORTING
      name              = iv_name
      dd01v_wa          = is_dd01v_wa
    TABLES
      dd07v_tab         = dd07v_tab
    EXCEPTIONS
      doma_not_found    = 1
      name_inconsistent = 2
      doma_inconsistent = 3
      put_failure       = 4
      put_refused       = 5
      OTHERS            = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
