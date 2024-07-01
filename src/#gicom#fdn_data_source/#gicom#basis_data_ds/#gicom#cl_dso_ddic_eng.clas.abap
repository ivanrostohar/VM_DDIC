CLASS /gicom/cl_dso_ddic_eng DEFINITION
  PUBLIC
  CREATE PUBLIC .

PUBLIC SECTION.

  INTERFACES /gicom/if_dso_ddic_eng .

  ALIASES activate_dataelement
    FOR /gicom/if_dso_ddic_eng~activate_dataelement .
  ALIASES activate_domain
    FOR /gicom/if_dso_ddic_eng~activate_domain .
  ALIASES activate_table
    FOR /gicom/if_dso_ddic_eng~activate_table .
  ALIASES activate_ttyp
    FOR /gicom/if_dso_ddic_eng~activate_ttyp .
  ALIASES delete_ddic_object
    FOR /gicom/if_dso_ddic_eng~delete_ddic_object .
  ALIASES get_dataelement
    FOR /gicom/if_dso_ddic_eng~get_dataelement .
  ALIASES get_devclass_for_object
    FOR /gicom/if_dso_ddic_eng~get_devclass_for_object .
  ALIASES get_devclass_from_object
    FOR /gicom/if_dso_ddic_eng~get_devclass_from_object .
  ALIASES get_domain
    FOR /gicom/if_dso_ddic_eng~get_domain .
  ALIASES get_fieldinfo
    FOR /gicom/if_dso_ddic_eng~get_fieldinfo .
  ALIASES get_fields_of_structure
    FOR /gicom/if_dso_ddic_eng~get_fields_of_structure .
  ALIASES get_pgmid_for_object
    FOR /gicom/if_dso_ddic_eng~get_pgmid_for_object .
  ALIASES get_shlp_name
    FOR /gicom/if_dso_ddic_eng~get_shlp_name .
  ALIASES get_table
    FOR /gicom/if_dso_ddic_eng~get_table .
  ALIASES get_texttable
    FOR /gicom/if_dso_ddic_eng~get_texttable .
  ALIASES get_view
    FOR /gicom/if_dso_ddic_eng~get_view .
  ALIASES put_dataelement
    FOR /gicom/if_dso_ddic_eng~put_dataelement .
  ALIASES put_domain
    FOR /gicom/if_dso_ddic_eng~put_domain .
  ALIASES put_table
    FOR /gicom/if_dso_ddic_eng~put_table .
  ALIASES put_ttyp
    FOR /gicom/if_dso_ddic_eng~put_ttyp .
  ALIASES select_texttable_data
    FOR /gicom/if_dso_ddic_eng~select_texttable_data .
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_DSO_DDIC_ENG IMPLEMENTATION.


METHOD /gicom/if_dso_ddic_eng~put_dataelement.

   CHECK iv_name IS NOT INITIAL.

   CALL FUNCTION '/GICOM/DDIF_DTEL_PUT'
      EXPORTING
        iv_name           = iv_name    " Name of the Data Element to be Written
        is_dd04v_wa       = is_dd04v    " Sources of the Data Element
      EXCEPTIONS
        dtel_not_found    = 1
        name_inconsistent = 2
        dtel_inconsistent = 3
        put_failure       = 4
        put_refused       = 5
        OTHERS            = 6.
" IF Table successfully saves then put table in requested transport and package
    IF sy-subrc EQ 0.
      lcl_local_helper=>insert_objects_into_tr( VALUE #( trkorr    = iv_trkorr
                                                         pgmid     = 'RT3R'
                                                         object    = 'DTEL'     " 'TABL'
                                                         obj_name  = iv_name
                                                         lockflag  = abap_true
                                                         devclass  = iv_devclass )
                                              ).
    ENDIF.

" Return Subrc Value (if subrc is ' 0 ' >> Data Element is Saved Successfully)
    rv_subrc = sy-subrc.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_domain.

  CHECK iv_name IS NOT INITIAL.

  " Get Domain Information, Fixed Values[] and status

      CALL FUNCTION '/GICOM/DDIF_DOMA_GET'
      EXPORTING
        iv_name       = iv_name     " Name of the Domain to be Read
        iv_state      = 'A'          " Read Status of the Domain
        iv_langu      = iv_lang     " Language in which Texts are Read
      IMPORTING
        ev_gotstate   = ev_state    " Status in which Reading took Place
        es_dd01v_wa   = es_dd01v    " Header of the Domain
      TABLES
        dd07v_tab     = et_dd07v    " Fixed Domain Values
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_table.

   CHECK iv_tabname IS NOT INITIAL.

   CALL FUNCTION '/GICOM/DDIF_TABL_GET'
      EXPORTING
        iv_name       = iv_tabname   " Name of the Table to be Read
        iv_state      = 'A'           " Read Status of the Table
        iv_langu      = iv_lang      " Language in which Texts are Read
      IMPORTING
        ev_gotstate   = ev_state            " Status in which Reading took Place
        es_dd02v_wa   = es_dd02v     " Table Header
        es_dd09l_wa   = es_dd09v     " Technical Settings of the Table
      TABLES
        dd03p_tab     = et_dd03p      " Table Fields
*       dd05m_tab     =              " Foreign Key Fields of the Table
*       dd08v_tab     =              " Foreign Keys of the Table
*       dd12v_tab     =              " Table Indexes
*       dd17v_tab     =              " Index Fields of the Table
*       dd35v_tab     =              " Header of the Search Help Assignments of the Table
*       dd36m_tab     =              " Allocations of the Search Help Assignments of the Table
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~put_ttyp.

   CHECK iv_tabname IS NOT INITIAL.

   CALL FUNCTION '/GICOM/DDIF_TTYP_PUT'
      EXPORTING
        iv_name     = iv_tabname             " Name of Table Type to be Written
        is_dd40v_wa = is_dd40v               " Header of Table Type
*   TABLES
*       DD42V_TAB   =                       " Key Fields of Table Type
*       DD43V_TAB   =                       " Structure for DD43L and DD43T
*   EXCEPTIONS
*       TTYP_NOT_FOUND          = 1
*       NAME_INCONSISTENT       = 2
*       TTYP_INCONSISTENT       = 3
*       PUT_FAILURE = 4
*       PUT_REFUSED = 5
*       OTHERS      = 6
      .

" IF Table successfully saves then put table in requested transport and package
    IF sy-subrc EQ 0.
      lcl_local_helper=>insert_objects_into_tr( VALUE #( trkorr    = iv_trkorr
                                                         pgmid     = 'RT3R'
                                                         object    = 'TTYP'
                                                         obj_name  = iv_tabname
                                                         lockflag  = abap_true
                                                         devclass  = iv_devclass )
                                              ).
    ENDIF.


"Return subrc Value (if subrc is ' 0 ' >>> table type saved successfully )
    rv_subrc = sy-subrc.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~select_texttable_data.

DATA: lv_key_fname   TYPE fieldname,
          lv_lang_fname  TYPE fieldname,
          lv_descr_fname TYPE fieldname,

          lv_source      TYPE string,
          lv_fields      TYPE string,
          lv_where       TYPE string,

          lt_fcat        TYPE lvc_t_fcat,
          lrt_data       TYPE REF TO data.

    FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE.

    "Get field of table
    DATA(lt_fields) = me->get_fieldinfo( iv_structure = iv_tabname ).

    LOOP AT lt_fields ASSIGNING FIELD-SYMBOL(<lwa_field>) WHERE keyflag EQ abap_true
                                                            AND domname NE 'MANDT'.

      APPEND VALUE #( fieldname = <lwa_field>-fieldname
                      ref_field = <lwa_field>-fieldname
                      ref_table = <lwa_field>-tabname
      ) TO lt_fcat.

      lv_key_fname = <lwa_field>-fieldname.

      EXIT.

    ENDLOOP.

    "Get the text table for this..
    DATA(lv_texttab) = me->get_texttable( iv_tabname ).

    IF lv_texttab IS INITIAL.

      "Check description field in current table
      IF  NOT iv_descr_field IS INITIAL
      AND line_exists( lt_fields[ fieldname = iv_descr_field ] ).

        "Collect the description into fcat table
        APPEND VALUE #( fieldname = iv_descr_field
                        ref_field = iv_descr_field
                        ref_table = iv_tabname
        ) TO lt_fcat.

        lv_descr_fname = iv_descr_field.
      ENDIF.

    ELSE.

      "get text fields of a table
      DATA(lt_text_fields) = me->get_fields_of_structure( lv_texttab ).

      "Get the language field from text table
      TRY.
          lv_lang_fname = lt_text_fields[ keyflag = abap_true
                                          domname = 'SPRAS' ]-fieldname.

        CATCH cx_sy_itab_line_not_found.
      ENDTRY.

      "Get description field from text table
      IF NOT iv_descr_field IS INITIAL
      AND line_exists( lt_text_fields[ fieldname = iv_descr_field ] ).
        lv_descr_fname = iv_descr_field.
      ENDIF.

      IF lv_descr_fname IS INITIAL.
        lv_descr_fname = lt_text_fields[ keyflag = space  ].
      ENDIF.

      "Collect the description into fcat table
      IF NOT lv_descr_fname IS INITIAL.
        APPEND VALUE #( fieldname = lv_descr_fname
                        ref_field = lv_descr_fname
                        ref_table = lv_texttab
        ) TO lt_fcat.
      ENDIF.

    ENDIF.

    "create the table dynamically
    cl_alv_table_create=>create_dynamic_table(
      EXPORTING
        it_fieldcatalog           = lt_fcat
      IMPORTING
        ep_table                  = lrt_data
      EXCEPTIONS
        generate_subpool_dir_full = 1
        OTHERS                    = 2
    ).
    IF sy-subrc <> 0.
*   Implement suitable error handling here
    ENDIF.

    CHECK lrt_data IS BOUND.

    ASSIGN lrt_data->* TO <lt_data>.

    CHECK <lt_data> IS ASSIGNED.

    TRY.
        "Security purpose: check table name
        DATA(lv_tabname) = cl_abap_dyn_prg=>check_table_name_tab( val                = iv_tabname
                                               packages           = VALUE string_hashed_table( ( `/GICOM/FDN` ) ( `WZRE` ) )
                                               incl_sub_packages  = abap_true
                                              ).

        "Fetch the data from both the tables
        IF lv_texttab IS INITIAL.

          "Prepare fields to be selected
          IF lv_descr_fname IS INITIAL.
            "Security check
            lv_key_fname = cl_abap_dyn_prg=>check_column_name( lv_key_fname ).

            lv_fields = |{ lv_key_fname }|.
          ELSE.
            "Security check
            lv_key_fname    = cl_abap_dyn_prg=>check_column_name( lv_key_fname ).
            lv_descr_fname  = cl_abap_dyn_prg=>check_column_name( lv_descr_fname ).

            lv_fields = |{ lv_key_fname },{ lv_descr_fname }|.
          ENDIF.

          "Fetch the data
          SELECT (lv_fields)
            FROM (lv_tabname)
            INTO CORRESPONDING FIELDS OF TABLE @<lt_data>.

        ELSE.

          "Prepare fields to be selected
          IF lv_descr_fname IS INITIAL.
            "Security check
            lv_key_fname = cl_abap_dyn_prg=>check_column_name( lv_key_fname ).

            lv_fields = |T1~{ lv_key_fname }|.
          ELSE.
            "Security check
            lv_key_fname    = cl_abap_dyn_prg=>check_column_name( lv_key_fname ).
            lv_descr_fname  = cl_abap_dyn_prg=>check_column_name( lv_descr_fname ).

            lv_fields = |T1~{ lv_key_fname }, T2~{ lv_descr_fname }|.
          ENDIF.

          "Prepare Tables from which data needs to be fetched
          lv_source = |{ lv_tabname } AS T1 INNER JOIN { lv_texttab } AS T2 ON ( T1~{ lv_key_fname } = T2~{ lv_key_fname } )|.

          "prepare where condition
          lv_lang_fname = cl_abap_dyn_prg=>check_column_name( lv_lang_fname ).
          lv_where = |{ lv_lang_fname } EQ { cl_abap_dyn_prg=>quote( iv_langu ) }|.


          "Fetch the data
          SELECT (lv_fields)
            FROM (lv_source)
            INTO CORRESPONDING FIELDS OF TABLE @<lt_data>
           WHERE (lv_where).

          CHECK sy-subrc EQ 0.

        ENDIF.

        LOOP AT <lt_data> ASSIGNING FIELD-SYMBOL(<lwa_data>).

          APPEND INITIAL LINE TO rt_values ASSIGNING FIELD-SYMBOL(<lwa_value>).
          IF <lwa_value> IS ASSIGNED.


            ASSIGN COMPONENT 1
                OF STRUCTURE <lwa_data> TO FIELD-SYMBOL(<lv_field1>).
            IF <lv_field1> IS ASSIGNED.
              <lwa_value>-name = <lv_field1>.
            ENDIF.

            ASSIGN COMPONENT 2
                OF STRUCTURE <lwa_data> TO FIELD-SYMBOL(<lv_field2>).
            IF <lv_field2> IS ASSIGNED.
              <lwa_value>-value = <lv_field2>.
            ENDIF.

          ENDIF.

          UNASSIGN: <lwa_value>, <lv_field1>, <lv_field2>.

        ENDLOOP.

      CATCH cx_sy_dynamic_osql_semantics.
      CATCH cx_abap_invalid_name.
    ENDTRY.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~activate_domain.

   CHECK iv_name IS NOT INITIAL.

   " Activate Domain, then Get Subrc value (is ' 0 ' << Domain is Activated Successfully )

   CALL FUNCTION '/GICOM/DDIF_DOMA_ACTIVATE'
      EXPORTING
        iv_name     = iv_name     " Name of the Domain to be Activated
        iv_auth_chk = 'X'         " 'X': Perform Author. Check for DB Operations
        is_prid     = 0           " ID for Log Writer
      IMPORTING
        ev_rc       = rv_subrc    " Result of Activation
      EXCEPTIONS
        not_found   = 1
        put_failure = 2
        OTHERS      = 3.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~delete_ddic_object.

     CHECK: iv_objname IS NOT INITIAL  AND iv_objtype IS NOT INITIAL.
     DATA(lv_trkorr) = iv_trkorr.

    CALL FUNCTION '/GICOM/RS_DD_DELETE_OBJ'
      EXPORTING
        iv_no_ask            = abap_true
        iv_objname           = iv_objname
        iv_objtype           = iv_objtype
      CHANGING
        cv_corrnum           = lv_trkorr
      EXCEPTIONS
        not_executed         = 1
        object_not_found     = 2
        object_not_specified = 3
        permission_failure   = 4
        dialog_needed        = 5
        OTHERS               = 6.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_pgmid_for_object.

    CHECK iv_objtype IS NOT INITIAL.
    CALL FUNCTION '/GICOM/TR_GET_PGMID_FOR_OBJECT'
      EXPORTING
        iv_object      = iv_objtype
      IMPORTING
        es_type        = rs_type
      EXCEPTIONS
        illegal_object = 1
        OTHERS         = 2.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~put_domain.

   CHECK iv_name IS NOT INITIAL.

   " Save Domain Information and Fixed Values[]
    CALL FUNCTION '/GICOM/DDIF_DOMA_PUT'
      EXPORTING
        iv_name           = iv_name    " Name of the Domain to be Written
        is_dd01v_wa       = is_dd01v    " Header of the Domain
      TABLES
        dd07v_tab         = it_dd07v    " Table Fields
      EXCEPTIONS
        doma_not_found    = 1
        name_inconsistent = 2
        doma_inconsistent = 3
        put_failure       = 4
        put_refused       = 5
        OTHERS            = 6.

"IF Table successfully saves then put table in requested transport and package
    IF sy-subrc EQ 0.
      lcl_local_helper=>insert_objects_into_tr( VALUE #( trkorr    = iv_trkorr
                                                         pgmid     = 'RT3R'
                                                         object    = 'DOMA'       " 'TABL'
                                                         obj_name  = iv_name
                                                         lockflag  = abap_true
                                                         devclass  = iv_devclass )
                                              ).
    ENDIF.


" Return Subrc value (if subrc is ' 0 ' >> Domain is Saved Successfully )
    rv_subrc = sy-subrc.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_devclass_for_object.

    CHECK: iv_objname IS NOT INITIAL AND iv_objtype IS NOT INITIAL.

    CALL FUNCTION '/GICOM/GET_DEVCLASS_FROM_OBJ'
      EXPORTING
        iv_pgmid    = 'R3TR'
        iv_objtype  = iv_objtype
        iv_objname  = iv_objname
      IMPORTING
        ev_devclass = ev_devclass.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_texttable.

    CHECK iv_structure IS NOT INITIAL.

    CALL FUNCTION '/GICOM/DDUT_TEXTTABLE_GET'
      EXPORTING
        iv_tabname   = iv_structure               "Name of table
      IMPORTING
        ev_texttable = rv_text_table.              "Name of text table if it exists
ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_fields_of_structure.
    DATA: lv_structure   TYPE ttrowtype,
          lt_text_fields TYPE dfies_table,
          lwa_dd40v      TYPE dd40v.

    CHECK iv_datatype IS NOT INITIAL.

    TRY .
        cl_abap_typedescr=>describe_by_name(
          EXPORTING
            p_name         = iv_datatype
          RECEIVING
            p_descr_ref    = DATA(lo_abap_typedescr)
          EXCEPTIONS
            type_not_found = 1
            OTHERS         = 2
               ).

        CHECK sy-subrc EQ 0.
    ENDTRY.

    " Get strusture of a tabletype if the data type is a tabletype
    IF lo_abap_typedescr->kind EQ 'T'.

      CALL FUNCTION '/GICOM/DDIF_TTYP_GET'
        EXPORTING
          iv_name       = iv_datatype
          iv_langu      = sy-langu
        IMPORTING
          es_dd40v_wa   = es_ttype_info
        EXCEPTIONS
          illegal_input = 1
          OTHERS        = 2.

      IF sy-subrc EQ 0.
        lv_structure = es_ttype_info-rowtype.
      ENDIF.

    ELSE.
      lv_structure = iv_datatype.
    ENDIF.

    CHECK lv_structure IS NOT INITIAL.

    " Get text table of a table
      DATA(lv_text_table) = me->get_texttable( lv_structure ).

    " Get fields of structure
      rt_fields = me->get_fieldinfo( lv_structure ).

    " Get fields of text table
      IF lv_text_table IS NOT INITIAL.

      lt_text_fields = me->get_fieldinfo( lv_text_table ).

      IF lt_text_fields IS NOT INITIAL.
        LOOP AT lt_text_fields INTO DATA(lwa_field) WHERE keyflag EQ abap_false.
          APPEND lwa_field TO rt_fields.
        ENDLOOP.
      ENDIF.

    ENDIF.
ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_view.

    CHECK iv_name IS NOT INITIAL.

    CALL FUNCTION '/GICOM/DDIF_VIEW_GET'
      EXPORTING
        iv_name       = iv_name
        iv_state      = 'A'
        iv_langu      = iv_langu
      IMPORTING
        ev_gotstate   = ev_state
        es_dd25v_wa   = es_dd25v
        es_dd09l_wa   = es_dd09l
      TABLES
        dd26v_tab     = et_dd26v
        dd27p_tab     = et_dd27p
        dd28j_tab     = et_dd28j
        dd28v_tab     = et_dd28v
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.
ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~put_table.

   CHECK iv_tabname IS NOT INITIAL.

   "Save Table Information and Fields List
   " If want to save a Structure, Don't Pass the technical settings(is_dd09l_wa)
   CALL FUNCTION '/GICOM/DDIF_TABL_PUT'
      EXPORTING
        iv_name           = iv_tabname    " Name of the Table to be Written
        is_dd02v_wa       = is_dd02v_wa    " Table Header
        is_dd09l_wa       = is_dd09l_wa    " Technical Settings of the Table
      TABLES
        dd03p_tab         = it_dd03p_tab    " Table Fields
*       dd05m_tab         =     " Foreign Key Fields of the Table
*       dd08v_tab         =     " Foreign Keys of the Table
*       dd35v_tab         =     " Header of the Search Help Assignments of the Table
*       dd36m_tab         =     " Allocations of the Search Help Assignments of the Table
      EXCEPTIONS
        tabl_not_found    = 1
        name_inconsistent = 2
        tabl_inconsistent = 3
        put_failure       = 4
        put_refused       = 5
        OTHERS            = 6.
"IF Table successfully saves then put table in requested transport and package
    IF sy-subrc EQ 0.
      lcl_local_helper=>insert_objects_into_tr( VALUE #( trkorr    = iv_trkorr
                                                         pgmid     = 'RT3R'
                                                         object    = 'TABL'
                                                         obj_name  = iv_tabname
                                                         lockflag  = abap_true
                                                         author    = /gicom/cl_system=>get_username( )
                                                         devclass  = iv_devclass )
                                              ).
    ENDIF.

"Return Subrc value (if subrc is ' 0 ' >> Table is saved successfully)
    rv_subrc = sy-subrc.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_fieldinfo.

    CHECK iv_structure IS NOT INITIAL.

    " Get fields of structure
    IF iv_langu IS  INITIAL.
      DATA(lv_langu) = sy-langu .
    ELSE .
      lv_langu = iv_langu.
    ENDIF.

    CALL FUNCTION '/GICOM/DDIF_FIELDINFO_GET'
      EXPORTING
        iv_tabname     = iv_structure   "Name of the structure
        iv_fieldname   = iv_fieldname
        iv_langu       = lv_langu
        iv_all_types   = abap_true
      TABLES
        dfies_tab      = rt_fields       "Field of the structure
      EXCEPTIONS
        not_found      = 1
        internal_error = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    IF iv_lvc_fcat_required = abap_true.

      CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
        EXPORTING
          i_structure_name = iv_structure   " Structure name (structure, table, view)
        CHANGING
          ct_fieldcat      = et_lvc_fcat.  " Field Catalog with Field Descriptions

    ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_dataelement.

    CHECK iv_name IS NOT INITIAL.

    " Get Data Element Informatiuon with status
    CALL FUNCTION '/GICOM/DDIF_DTEL_GET'
      EXPORTING
        iv_name       = iv_name       " Name of the Data Element to be Read
        iv_state      = 'A'           " Read Status of the Data Element
        iv_langu      = iv_lang       " Language in which Texts are Read
      IMPORTING
        ev_gotstate   = ev_state      " Status in which Reading took Place
        es_dd04v_wa   = es_dd04v      " Header of the Data Element
*       ES_TPARA_WA   =               " Technical Settings of the Table
      EXCEPTIONS
        illegal_input = 1
        OTHERS        = 2.


ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_devclass_from_object.

       CHECK iv_pgmid IS NOT INITIAL AND
             iv_object IS NOT INITIAL AND
             iv_objname IS NOT INITIAL.

       " Get DevClass Information by object name

     CALL FUNCTION '/GICOM/RLB_DEVCLASS_GET'
      EXPORTING
        iv_pgmid    = iv_pgmid
        iv_object   = iv_object
        iv_obj_name = iv_objname
      IMPORTING
        es_devclass = rs_devclass
      EXCEPTIONS
        not_found   = 1
        OTHERS      = 2.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~activate_ttyp.

   CHECK iv_tabname IS NOT INITIAL.

   " Activate Table type(TTYP), then get subrc value ( '0' >> table type is Activated Successfully )
       CALL FUNCTION '/GICOM/DDIF_TTYP_ACTIVATE'
      EXPORTING
        iv_name     = iv_tabname     " Name of Table Type to be Activated
        iv_prid     = 0              " ID for Log Writer
      IMPORTING
        ev_rc       = rv_subrc       " Result of Activation
      EXCEPTIONS
        not_found   = 1
        put_failure = 2
        OTHERS      = 3.
    IF sy-subrc <> 0.
     " Implement suitable error handling here
    ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~activate_dataelement.

    CHECK iv_name IS NOT INITIAL.

    " Activate Data Element, then get subrc value (' 0 ' >> Data Element is activated Successfully )

    CALL FUNCTION '/GICOM/DDIF_DTEL_ACTIVATE'
      EXPORTING
        iv_name     = iv_name       " Name of the Data Element to be Activated
        iv_auth_chk = 'X'           " 'X': Perform Author. Check for DB Operations
        iv_prid     = 0             " ID for Log Writer
      IMPORTING
        ev_rc       = rv_subrc      " Result of Activation
      EXCEPTIONS
        not_found   = 1
        put_failure = 2
        OTHERS      = 3.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~get_shlp_name.

    CALL FUNCTION '/GICOM/F4IF_DETERMINE_SEARCHHE'
      EXPORTING
        iv_tabname        = iv_tabname   " Name of DDIC structure
        iv_fieldname      = iv_fieldname   " Field from DDIC structure
      IMPORTING
        es_shlp           = es_shlp   " Effective search help for the field
      EXCEPTIONS
        field_not_found   = 1
        no_help_for_field = 2
        inconsistent_help = 3
        OTHERS            = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_ddic_eng~activate_table.

    CHECK iv_tabname IS NOT INITIAL.

    " To Activate Table, then get subrc value ( '0' >> Table is activated successfully )

    CALL FUNCTION '/GICOM/DDIF_TABL_ACTIVATE'
      EXPORTING
        iv_name     = iv_tabname    " Name of the Table to be Activated
*       IV_AUTH_CHK = 'X'           " 'X': Perform Author. Check for DB Operations
        iv_prid     = 0              " ID for Log Writer
*       IV_EXCOMMIT = 'X'           " Specifies whether a commit is to be sent
      IMPORTING
        ev_rc       = rv_subrc       " Result of Activation
      EXCEPTIONS
        not_found   = 1
        put_failure = 2
        OTHERS      = 3.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

ENDMETHOD.
ENDCLASS.
