FUNCTION /GICOM/DDIF_DTEL_PUT .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IS_DD04V_WA) TYPE  DD04V DEFAULT ' '
*"  EXCEPTIONS
*"      DTEL_NOT_FOUND
*"      NAME_INCONSISTENT
*"      DTEL_INCONSISTENT
*"      PUT_FAILURE
*"      PUT_REFUSED
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_DTEL_PUT'
    EXPORTING
      name              = iv_name
      dd04v_wa          = is_dd04v_wa
    EXCEPTIONS
      dtel_not_found    = 1
      name_inconsistent = 2
      dtel_inconsistent = 3
      put_failure       = 4
      put_refused       = 5
      OTHERS            = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
