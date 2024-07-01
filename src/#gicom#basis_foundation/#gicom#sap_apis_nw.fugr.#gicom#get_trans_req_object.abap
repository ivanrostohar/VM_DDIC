FUNCTION /gicom/get_trans_req_object.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_PGMID) TYPE  E071-PGMID
*"     REFERENCE(IV_OBJECT) TYPE  E071-OBJECT
*"     REFERENCE(IV_OBJNAME) TYPE  E071-OBJ_NAME
*"     REFERENCE(IV_TABKEY) TYPE  E071K-TABKEY OPTIONAL
*"  EXPORTING
*"     REFERENCE(EV_TRKORR) TYPE  TRKORR
*"----------------------------------------------------------------------

  DATA ltr_trkorr TYPE /gicom/trkorr_rtt.

  IF iv_tabkey IS SUPPLIED.

    "Get TRs in which the given table key has been recorded
    SELECT DISTINCT
       'I' AS sing,
       'EQ' AS option,
       trkorr AS low
      FROM e071k
      INTO TABLE @ltr_trkorr
     WHERE pgmid    = @iv_pgmid
       AND object   = @iv_object
       AND objname  = @iv_objname
       AND tabkey   = @iv_tabkey.

  ELSE.

    "Get TRs in which the given object has been recorded
    SELECT DISTINCT 'I' AS sing,
                   'EQ' AS option,
                 trkorr AS low
      FROM e071
      INTO TABLE @ltr_trkorr
     WHERE pgmid    = @iv_pgmid
       AND object   = @iv_object
       AND obj_name = @iv_objname.

  ENDIF.

  IF NOT ltr_trkorr IS INITIAL.

    SELECT trkorr, as4user, strkorr
      FROM e070
      INTO TABLE @DATA(lt_e070)
     WHERE trkorr IN @ltr_trkorr
       AND trfunction IN ( 'K', 'W', 'T', 'S', 'R', 'Q' )
       AND trstatus NE 'R'.
    IF sy-subrc EQ 0.

      " new logic - always returns main transport
      ASSIGN lt_e070[ 1 ] TO FIELD-SYMBOL(<ls_e070>).
      IF <ls_e070> IS ASSIGNED.
        ev_trkorr = COND #( WHEN <ls_e070>-strkorr IS NOT INITIAL THEN <ls_e070>-strkorr
                            ELSE <ls_e070>-trkorr  ).
      ENDIF.

      " previous logic - returning back the tasks, but need a parent TR for the objects
      IF 1 = 2.
        "Check if any tasks exists for current user
        TRY.
            ev_trkorr = lt_e070[ as4user = /gicom/cl_system=>get_username( ) ]-trkorr.
          CATCH cx_sy_itab_line_not_found.
            "Get the first record and return the value
            TRY.
                DATA(ls_e070) = lt_e070[ 1 ].
                ev_trkorr = COND #( WHEN ls_e070-strkorr IS NOT INITIAL THEN ls_e070-strkorr
                                    ELSE ls_e070-trkorr  ).
              CATCH cx_sy_itab_line_not_found.
            ENDTRY.
        ENDTRY.
      ENDIF.

    ENDIF.

  ENDIF.

ENDFUNCTION.
