FUNCTION /GICOM/RLB_DEVCLASS_GET .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_PGMID) TYPE  C
*"     REFERENCE(IV_OBJECT) TYPE  C
*"     REFERENCE(IV_OBJ_NAME) TYPE  ANY
*"  EXPORTING
*"     REFERENCE(ES_DEVCLASS) TYPE  TRDEVCLASS
*"  EXCEPTIONS
*"      NOT_FOUND
*"--------------------------------------------------------------------

  CALL FUNCTION 'RLB_DEVCLASS_GET'
    EXPORTING
      i_pgmid      = iv_pgmid
      i_object     = iv_object
      i_obj_name   = iv_obj_name
    IMPORTING
      e_s_devclass = es_devclass
    EXCEPTIONS
      not_found    = 1
      OTHERS       = 2.

  IF sy-subrc EQ 1.
    RAISE not_found.
  ENDIF.

ENDFUNCTION.
