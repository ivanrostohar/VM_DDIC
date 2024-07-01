FUNCTION /GICOM/RS_DD_DELETE_OBJ .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NO_ASK) TYPE  ANY DEFAULT ' '
*"     VALUE(IV_OBJNAME) LIKE  RSEDD0-DDOBJNAME
*"     VALUE(IV_OBJTYPE) LIKE  RSEDD0-DDOBJTYPE
*"  CHANGING
*"     VALUE(CV_CORRNUM) LIKE  E070-TRKORR DEFAULT SPACE
*"  EXCEPTIONS
*"      NOT_EXECUTED
*"      OBJECT_NOT_FOUND
*"      OBJECT_NOT_SPECIFIED
*"      PERMISSION_FAILURE
*"      DIALOG_NEEDED
*"--------------------------------------------------------------------

  CALL FUNCTION 'RS_DD_DELETE_OBJ'
    EXPORTING
      no_ask               = iv_no_ask
      objname              = iv_objname
      objtype              = iv_objtype
    CHANGING
      corrnum              = cv_corrnum
    EXCEPTIONS
      not_executed         = 1
      object_not_found     = 2
      object_not_specified = 3
      permission_failure   = 4
      dialog_needed        = 5
      OTHERS               = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
