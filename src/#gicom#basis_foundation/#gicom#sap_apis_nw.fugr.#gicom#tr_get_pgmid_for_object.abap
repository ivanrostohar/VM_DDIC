FUNCTION /GICOM/TR_GET_PGMID_FOR_OBJECT .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_OBJECT) LIKE  E071-OBJECT
*"  EXPORTING
*"     VALUE(ES_TYPE) LIKE  KO100 STRUCTURE  KO100
*"  EXCEPTIONS
*"      ILLEGAL_OBJECT
*"--------------------------------------------------------------------

  CALL FUNCTION 'TR_GET_PGMID_FOR_OBJECT'
    EXPORTING
      iv_object      = iv_object
    IMPORTING
      es_type        = es_type
    EXCEPTIONS
      illegal_object = 1
      OTHERS         = 2.
  IF sy-subrc EQ 1.

    RAISE illegal_object.

  ENDIF.

ENDFUNCTION.
