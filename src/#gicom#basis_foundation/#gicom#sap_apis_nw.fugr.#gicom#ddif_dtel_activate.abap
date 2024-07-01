FUNCTION /GICOM/DDIF_DTEL_ACTIVATE .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NAME) TYPE  DDOBJNAME
*"     VALUE(IV_AUTH_CHK) TYPE  DDBOOL_D DEFAULT 'X'
*"     VALUE(IV_PRID) TYPE  SY-TABIX DEFAULT -1
*"  EXPORTING
*"     VALUE(EV_RC) TYPE  SY-SUBRC
*"  EXCEPTIONS
*"      NOT_FOUND
*"      PUT_FAILURE
*"--------------------------------------------------------------------

  CALL FUNCTION 'DDIF_DTEL_ACTIVATE'
    EXPORTING
      name        = iv_name
      auth_chk    = iv_auth_chk
      prid        = iv_prid
    IMPORTING
      rc          = ev_rc
    EXCEPTIONS
      not_found   = 1
      put_failure = 2
      OTHERS      = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
