FUNCTION /GICOM/GET_DEVCLASS_FROM_OBJ .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_PGMID) LIKE  TADIR-PGMID
*"     REFERENCE(IV_OBJTYPE) LIKE  TADIR-OBJECT
*"     REFERENCE(IV_OBJNAME) LIKE  TADIR-OBJ_NAME
*"  EXPORTING
*"     REFERENCE(EV_DEVCLASS) LIKE  TDEVC-DEVCLASS
*"--------------------------------------------------------------------

  CLEAR ev_devclass.

  SELECT SINGLE devclass
    FROM tadir
    INTO @ev_devclass
   WHERE ( pgmid    = @iv_pgmid )
     AND ( object   = @iv_objtype )
     AND ( obj_name = @iv_objname ).
  IF ( sy-subrc <> 0 ).
    CLEAR ev_devclass.
    IF  ( iv_pgmid   = 'R3TR' )
    AND ( iv_objtype = 'DEVC' ).
      ev_devclass = iv_objname.
    ENDIF.
  ENDIF.

ENDFUNCTION.
