FUNCTION /gicom/rfc_view_maint_low_lvl.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EXTRACT) TYPE  XSTRING
*"     VALUE(IV_TOTAL) TYPE  XSTRING
*"     VALUE(IV_CORR_NUMBER) TYPE  E070-TRKORR DEFAULT ' '
*"     VALUE(IV_FCODE) TYPE  CHAR10 DEFAULT 'RDED'
*"     VALUE(IV_VIEW_ACTION) TYPE  CHAR10 DEFAULT 'S'
*"     VALUE(IV_VIEW_NAME) TYPE  DD02V-TABNAME
*"  EXPORTING
*"     VALUE(EV_ERROR) TYPE  XFELD
*"  TABLES
*"      IT_CORR_KEYTAB STRUCTURE  E071K
*"      IT_DBA_SELLIST STRUCTURE  VIMSELLIST
*"      IT_DPL_SELLIST STRUCTURE  VIMSELLIST
*"      IT_EXCL_CUA_FUNCT STRUCTURE  VIMEXCLFUN
*"      IT_X_HEADER STRUCTURE  VIMDESC
*"      IT_X_NAMTAB STRUCTURE  VIMNAMTAB
*"  EXCEPTIONS
*"      SAVE_FAILED
*"----------------------------------------------------------------------

  DATA: ls_dd25v               TYPE dd25v,
        lt_extract             TYPE REF TO data,
        lt_total               TYPE REF TO data,
        lo_view_struct_type    TYPE REF TO cl_abap_typedescr,
        lo_flagtab_struct_type TYPE REF TO cl_abap_typedescr,
        lo_structure_type      TYPE REF TO cl_abap_datadescr,
        lo_table_type          TYPE REF TO cl_abap_tabledescr,
        lr_extract             TYPE REF TO data,
        lr_total               TYPE REF TO data.

  FIELD-SYMBOLS : <lt_extract> TYPE STANDARD TABLE,
                  <lt_total>   TYPE STANDARD TABLE.


*   Create space for the total table according to structure of the view
  CALL METHOD cl_abap_structdescr=>describe_by_name
    EXPORTING
      p_name         = iv_view_name
    RECEIVING
      p_descr_ref    = lo_view_struct_type
    EXCEPTIONS
      type_not_found = 1
      OTHERS         = 2.
  IF sy-subrc <> 0.
    ASSERT 1 = 0.
  ENDIF.

  CALL METHOD cl_abap_structdescr=>describe_by_name
    EXPORTING
      p_name         = 'VIMFLAGTAB'
    RECEIVING
      p_descr_ref    = lo_flagtab_struct_type
    EXCEPTIONS
      type_not_found = 1
      OTHERS         = 2.
  IF sy-subrc <> 0.
    ASSERT 1 = 0.
  ENDIF.

  DATA(lt_comp_tab) = VALUE abap_component_tab(
                      ( as_include = abap_true
                        type = CAST #( lo_view_struct_type ) )
                      ( as_include = abap_true
                        type = CAST #( lo_flagtab_struct_type ) )
                    ).

  lo_structure_type = cl_abap_structdescr=>create( lt_comp_tab ).
  DATA(lo_table_descr) = cl_abap_tabledescr=>create( lo_structure_type ).

  IF lo_table_descr IS BOUND.
    " Create data of total
    CREATE DATA lr_total TYPE HANDLE lo_table_descr.
    ASSIGN lr_total->* TO <lt_total>.

    " Create data of extract
    CREATE DATA lr_extract TYPE HANDLE lo_table_descr.
    ASSIGN lr_extract->* TO <lt_extract>.

  ENDIF.

  CALL TRANSFORMATION id
      SOURCE XML iv_extract
      RESULT extract = <lt_extract>.

  CALL TRANSFORMATION id
      SOURCE XML iv_total
      RESULT total = <lt_total>.

  TRY.

      CALL FUNCTION 'VIEW_MAINTENANCE_LOW_LEVEL'
        EXPORTING
          corr_number                 = iv_corr_number
          fcode                       = iv_fcode
          view_action                 = iv_view_action
          view_name                   = iv_view_name
***          rfc_destination_for_upgrade = 'NONE'
        TABLES
          corr_keytab                 = it_corr_keytab
          dba_sellist                 = it_dba_sellist
          dpl_sellist                 = it_dpl_sellist
          excl_cua_funct              = it_excl_cua_funct
          extract                     = <lt_extract>
          total                       = <lt_total>
          x_header                    = it_x_header
          x_namtab                    = it_x_namtab
        EXCEPTIONS
          function_not_found          = 1
          missing_corr_number         = 2
          no_value_for_subset_ident   = 3
          saving_correction_failed    = 4
          error_message               = 8.

      IF sy-subrc <> 0.
        "NEED TO RAISE THE MESSAGE
        ev_error = abap_true.

      ELSE.
        COMMIT WORK.
      ENDIF.


    CATCH cx_sy_send_dynpro_no_receiver INTO data(lo_ex).      " to eliminate the transport request dialog issue

      "for now, we are not taking any action, because, we have the feasibility of inserting the entries into TR manually
      ev_error = abap_true.

  ENDTRY.

ENDFUNCTION.
