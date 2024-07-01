FUNCTION /GICOM/TR_OBJECTS_CHECK .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_NO_STANDARD_EDITOR) LIKE  TRPARI-FLAG DEFAULT ' '
*"     VALUE(IV_NO_SHOW_OPTION) LIKE  TRPARI-FLAG DEFAULT ' '
*"     VALUE(IV_EXTERNALPS) LIKE  CTSPROJECT-EXTERNALPS DEFAULT ' '
*"     VALUE(IV_EXTERNALID) LIKE  CTSPROJECT-EXTERNALID DEFAULT ' '
*"     VALUE(IV_NO_PS) LIKE  TRPARI-FLAG DEFAULT ' '
*"     VALUE(IT_E071K_STR) TYPE  E071K_STRTYP OPTIONAL
*"     REFERENCE(IT_OBJ_ENTRIES) TYPE  CTS_OBJ_ENTRIES OPTIONAL
*"  EXPORTING
*"     VALUE(EV_ORDER) LIKE  E070-TRKORR
*"     VALUE(EV_TASK) LIKE  E070-TRKORR
*"     VALUE(EV_OBJECTS_APPENDABLE) LIKE  TRPARI-S_CHECKED
*"  TABLES
*"      IT_KO200 STRUCTURE  KO200
*"      IT_E071K STRUCTURE  E071K OPTIONAL
*"      TT_TADIR STRUCTURE  TADIR OPTIONAL
*"  EXCEPTIONS
*"      CANCEL_EDIT_OTHER_ERROR
*"      SHOW_ONLY_OTHER_ERROR
*"--------------------------------------------------------------------

  CALL FUNCTION 'TR_OBJECTS_CHECK'
    EXPORTING
      iv_no_standard_editor   = iv_no_standard_editor
      iv_no_show_option       = iv_no_show_option
      iv_externalps           = iv_externalps
      iv_externalid           = iv_externalps
      iv_no_ps                = iv_no_ps
      it_e071k_str            = it_e071k_str
      it_obj_entries          = it_obj_entries
    IMPORTING
      we_order                = ev_order
      we_task                 = ev_task
      we_objects_appendable   = ev_objects_appendable
    TABLES
      wt_ko200                = it_ko200
      wt_e071k                = it_e071k
      tt_tadir                = tt_tadir
    EXCEPTIONS
      cancel_edit_other_error = 1
      show_only_other_error   = 2
      OTHERS                  = 3.
  IF sy-subrc <> 0.

    CASE sy-subrc.

      WHEN 1.

        RAISE cancel_edit_other_error.

      WHEN 2.

        RAISE  show_only_other_error.

    ENDCASE.

  ENDIF.

ENDFUNCTION.
