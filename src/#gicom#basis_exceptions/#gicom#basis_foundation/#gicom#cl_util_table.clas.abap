CLASS /gicom/cl_util_table DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.


    TYPES:

      gtt_table_batch TYPE STANDARD TABLE OF REF TO data WITH EMPTY KEY.

    CLASS-METHODS:

      "! <p>Prevents errors caused by empty ranges meaning "everything" instead of nothing.<p>
      "! <p>Internally, this method will check if the supplied range is empty and, if so, add
      "!    a single line to the range that excludes everything.</p>
      "! @parameter ct_range | The range table
      prevent_empty_range
        CHANGING
          ct_range TYPE STANDARD TABLE,

      move_structure
        IMPORTING
          !is_source          TYPE any
          !iv_ignore_initials TYPE abap_bool DEFAULT abap_false
        EXPORTING
          !es_destination     TYPE any,

      "! Moves elements from one table to an other. Should be used in case the constructor imports an structure
      "! in which is then mapped to an object structure
      "! <br/> <br/>
      "! <em> This method should be used across the product, so we have a central point for adjustments.</em>
      move_table
        IMPORTING
          !it_source      TYPE ANY TABLE
        EXPORTING
          !et_destination TYPE ANY TABLE,

      "! Returns a range table based on a type descriptor
      "! @parameter er_range_t    | Generated range table
      "! @parameter er_range_s    | Reference to a generated structure corresponding to the range table
      create_range_table_from_type
        IMPORTING
          io_type    TYPE  REF TO cl_abap_typedescr
        EXPORTING
          er_range_s TYPE REF TO data
          er_range_t TYPE REF TO data,

      get_range_from_table
        IMPORTING
          !it_table       TYPE STANDARD TABLE
          !iv_sign        TYPE /gicom/sign DEFAULT 'I'
        EXPORTING
          !et_range_table TYPE STANDARD TABLE,

      create_table_from_datadescr
        IMPORTING
          !io_datadescr TYPE REF TO cl_abap_datadescr
        RETURNING
          VALUE(ro_tab) TYPE REF TO data,

      cast_table
        IMPORTING
          !it_table TYPE ANY TABLE
          !iv_type  TYPE abap_abstypename
        EXPORTING
          !rt_table TYPE STANDARD TABLE,

      create_structure_from_strdescr
        IMPORTING
          !io_structdescr TYPE REF TO cl_abap_structdescr
        RETURNING
          VALUE(eo_struc) TYPE REF TO data,

      create_structure_from_apiparam
        IMPORTING
          !it_params      TYPE /gicom/api_params
        RETURNING
          VALUE(ro_struc) TYPE REF TO data,

      get_delta_of_two_tables
        IMPORTING
          !iv_exit_first_different TYPE /gicom/abap_bool OPTIONAL
          !it_table1               TYPE table
          VALUE(it_table2)         TYPE table
        EXPORTING
          !et_delta                TYPE table
          !ev_delta_flag           TYPE /gicom/abap_bool,

      compare_two_tbl_accept_initial
        IMPORTING
          !iv_exit_first_different  TYPE /gicom/abap_bool OPTIONAL
          !iv_table1_accept_initial TYPE /gicom/abap_bool OPTIONAL
          !iv_table2_accept_initial TYPE /gicom/abap_bool OPTIONAL
          !it_table1                TYPE table
          !it_table2                TYPE table
        EXPORTING
          !et_delta                 TYPE table
          !ev_delta_flag            TYPE /gicom/abap_bool,

      get_primary_keys
        IMPORTING
          !iv_db_name            TYPE /gicom/db_name
        RETURNING
          VALUE(rt_primary_keys) TYPE ddfields
        RAISING
          /gicom/cx_invalid_db_name,

      get_where_clause_for_any_pk
        IMPORTING
          !iv_db_name            TYPE /gicom/db_name
          !iv_primary_key_only   TYPE /gicom/abap_bool DEFAULT abap_true
          !it_primary_keys       TYPE /gicom/primary_key_tt
        RETURNING
          VALUE(rv_where_clause) TYPE string
        RAISING
          /gicom/cx_invalid_db_name,

      get_simple_selopts
        IMPORTING
          it_field_value   TYPE /gicom/field_value_tt
        RETURNING
          VALUE(rt_selopt) TYPE ddshselops
        RAISING
          /gicom/cx_illegal_arguments,

      get_keys
        IMPORTING
          !iv_db_name            TYPE /gicom/db_name
        RETURNING
          VALUE(rt_primary_keys) TYPE ddfields,

      create_table_from_string
        IMPORTING
          iv_string      TYPE string
          iv_tabl_length TYPE i
        EXPORTING
          et_table       TYPE table,

      split_table_to_batches
        IMPORTING
          it_table          TYPE ANY TABLE
          iv_batch_size     TYPE i
        RETURNING
          VALUE(rt_batches) TYPE gtt_table_batch,

      get_table_batch_count
        IMPORTING
          it_table          TYPE STANDARD TABLE
          iv_batch_size     TYPE i
        RETURNING
          VALUE(rv_batches) TYPE i,

      get_table_batch
        IMPORTING
          it_table       TYPE STANDARD TABLE
          iv_batch_size  TYPE i
          iv_batch_index TYPE i
        CHANGING
          ct_batch       TYPE ANY TABLE,

      table_is_subset_of
        IMPORTING
          it_subset           TYPE ANY TABLE
          it_set              TYPE ANY TABLE
        RETURNING
          VALUE(rv_is_subset) TYPE /gicom/abap_bool
        RAISING
          /gicom/cx_illegal_arguments.

  PRIVATE SECTION.

    CLASS-DATA:

        gt_direct_move TYPE TABLE OF string.

ENDCLASS.



CLASS /gicom/cl_util_table IMPLEMENTATION.


  METHOD cast_table.


**********************************************************************
    RAISE EXCEPTION TYPE /gicom/cx_not_implemented.
**********************************************************************


*    DATA:
*      lv_class TYPE abap_abstypename,
*      lo_ref   TYPE REF TO data,
*      lo_obj   TYPE REF TO object,
*      lo_type  TYPE REF TO cl_abap_typedescr.
**      DATA: lt_type type STANDARD TABLE OF REF TO /gicom/cl_negotround.
*    DATA: lt_result TYPE STANDARD TABLE OF REF TO object.
*
*    FIELD-SYMBOLS:
*        <fs_line> TYPE REF TO object.
*
*    LOOP AT it_table ASSIGNING FIELD-SYMBOL(<fs>).
*      IF <fs> IS NOT BOUND.
*        CONTINUE.
*      ENDIF.
*
*      ASSIGN <fs> TO <fs_line> CASTING.
*
*      IF sy-subrc <> 0.
*        CONTINUE.
*      ENDIF.
*
*      lo_obj = <fs_line>.
*
*      lv_class = cl_abap_classdescr=>get_class_name( lo_obj ).
*      lv_class = lv_class+7.
*
*      IF lv_class EQ iv_type.
*        APPEND lo_obj TO lt_result.
*      ENDIF.
*
*    ENDLOOP.
*
*    "TODO: rt_table = lt_result. lt_result dynamisch aufbauen.

  ENDMETHOD.


  METHOD compare_two_tbl_accept_initial.

    /gicom/cl_util_table=>get_delta_of_two_tables(
      EXPORTING
        iv_exit_first_different = iv_exit_first_different
        it_table1               = it_table1
        it_table2               = it_table2
      IMPORTING
        et_delta                = et_delta
        ev_delta_flag           = ev_delta_flag
           ).

***********************************************************************************************************************
    " iv_table1_accept_initial is set 'X': if in Table1 is an empty entry, we accept all compares.
    " Empy entry means accept ALL.
***********************************************************************************************************************
    IF   ev_delta_flag IS NOT INITIAL AND iv_table1_accept_initial IS SUPPLIED AND iv_table1_accept_initial IS NOT INITIAL.
      IF line_index( it_table1[ table_line = '' ] ) GT 0.
        CLEAR ev_delta_flag .
      ENDIF.
***********************************************************************************************************************
      " iv_table2_accept_initial is set 'X': if in Table2 is an empty entry, we accept all compares.
      " Empy entry means accept ALL.
***********************************************************************************************************************
    ELSEIF  ev_delta_flag IS NOT INITIAL AND iv_table2_accept_initial IS SUPPLIED AND iv_table2_accept_initial IS NOT INITIAL.
      IF line_index( it_table2[ table_line = '' ] ) GT 0.
        CLEAR ev_delta_flag .
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD create_range_table_from_type.
    DATA:
      lt_components     TYPE abap_component_tab
    , ls_components     TYPE LINE OF abap_component_tab
    , lo_structdescr    TYPE REF TO cl_abap_structdescr
    , lo_datadescr      TYPE REF TO cl_abap_datadescr
    , lr_tab            TYPE REF TO data
    .

    FIELD-SYMBOLS:
      <fs_range>    TYPE table
    .


    CHECK io_type IS BOUND.

    ls_components-name = 'SIGN'.
    ls_components-type ?= cl_abap_elemdescr=>get_c( p_length = 1 ).
    INSERT ls_components INTO TABLE lt_components.

    ls_components-name = 'OPTION'.
    ls_components-type ?= cl_abap_elemdescr=>get_c( p_length = 2 ).
    INSERT ls_components INTO TABLE lt_components.

    ls_components-name = 'LOW'.
    ls_components-type ?= io_type.
    INSERT ls_components INTO TABLE lt_components.

    ls_components-name = 'HIGH'.
    ls_components-type ?= io_type.
    INSERT ls_components INTO TABLE lt_components.



    lo_structdescr ?= cl_abap_structdescr=>create( lt_components ).

    IF er_range_s IS SUPPLIED.
      er_range_s = /gicom/cl_util_table=>create_structure_from_strdescr( lo_structdescr ).
    ENDIF.

    lo_datadescr ?= lo_structdescr.
    er_range_t = /gicom/cl_util_table=>create_table_from_datadescr( lo_datadescr ).



  ENDMETHOD.


  METHOD create_structure_from_apiparam.

    DATA: ls_components TYPE cl_abap_structdescr=>component,
          lt_components TYPE cl_abap_structdescr=>component_table,
          lo_struct     TYPE REF TO cl_abap_structdescr.

    CHECK it_params IS NOT INITIAL.

    LOOP AT it_params INTO DATA(ls_params).

      ls_components-name = ls_params-parameter.
      ls_components-type ?= cl_abap_typedescr=>describe_by_name( ls_params-tabname ).

      APPEND ls_components TO lt_components.

    ENDLOOP.

    TRY.
        lo_struct = cl_abap_structdescr=>get(
            p_components = lt_components
*    p_strict     = TRUE
               ).
      CATCH cx_sy_struct_creation .
    ENDTRY.

    CREATE DATA ro_struc TYPE HANDLE lo_struct.

  ENDMETHOD.


  METHOD create_structure_from_strdescr.

    CREATE DATA eo_struc TYPE HANDLE io_structdescr.

  ENDMETHOD.


  METHOD create_table_from_datadescr.
***********************************************************************************************************************
***   This method creates an internal table based on a given datadescriptor
***     After retrieving ro_tab assign it to a field-symbol of type table
***     ASSIGN ro_tab->* TO <fs_range>.
***********************************************************************************************************************

    DATA lo_tabledescr TYPE REF TO cl_abap_tabledescr.

    TRY.
        lo_tabledescr ?= cl_abap_tabledescr=>create( io_datadescr ).
      CATCH cx_sy_table_creation.
        RETURN.
    ENDTRY.

    CREATE DATA ro_tab TYPE HANDLE lo_tabledescr.

  ENDMETHOD.


  METHOD create_table_from_string.


    DATA: lv_length      TYPE i,
          lv_offset      TYPE i,
          lv_full_lines  TYPE i,
          lv_last_length TYPE i.

    lv_length = strlen( iv_string ).
    lv_full_lines  = lv_length DIV iv_tabl_length.
    lv_last_length = lv_length MOD iv_tabl_length.


    DO lv_full_lines TIMES.
      DATA(ls_line) = iv_string+lv_offset(iv_tabl_length).
      APPEND ls_line TO et_table.
      lv_offset = lv_offset + iv_tabl_length.
    ENDDO.

    DATA(ls_last) = iv_string+lv_offset(lv_last_length).
    APPEND ls_last TO et_table.

  ENDMETHOD.


  METHOD get_delta_of_two_tables.
    DATA lv_index TYPE i.


    CLEAR et_delta.

    LOOP AT it_table1 ASSIGNING FIELD-SYMBOL(<ls_sender>).

      lv_index = line_index( it_table2[ table_line = <ls_sender> ] ).
      IF lv_index NE 0.
        DELETE it_table2 INDEX lv_index.
      ELSE.
        IF et_delta IS SUPPLIED.
          APPEND <ls_sender> TO et_delta.
        ENDIF.

        ev_delta_flag = abap_true.

        IF iv_exit_first_different EQ 'X'.
          EXIT.
        ENDIF.
      ENDIF.

    ENDLOOP.

    IF it_table2 IS NOT INITIAL.
      IF et_delta IS SUPPLIED.
        APPEND LINES OF it_table2 TO et_delta.
      ENDIF.
      ev_delta_flag = abap_true.
    ENDIF.


  ENDMETHOD.


  METHOD get_keys.
    DATA: lo_strucdescr TYPE REF TO cl_abap_structdescr,
          lt_tab_field  TYPE ddfields.

    lo_strucdescr ?= cl_abap_elemdescr=>describe_by_name( iv_db_name ).

* Check if input is a DDIC table
    CHECK lo_strucdescr->is_ddic_type( ) = 'X'.

* Get the details of the table fields
    lt_tab_field = lo_strucdescr->get_ddic_field_list( ).

*Return the Key fields of the table
    LOOP AT lt_tab_field ASSIGNING FIELD-SYMBOL(<ls_tab_field>) WHERE rollname NE 'MANDT'
                                                                AND   rollname NE 'CLNT'.
      APPEND <ls_tab_field> TO rt_primary_keys.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_primary_keys.
    DATA: lo_strucdescr TYPE REF TO cl_abap_structdescr,
          lt_tab_field  TYPE ddfields.


    DATA lo_decr_ref TYPE REF TO cl_abap_typedescr.
    CALL METHOD cl_abap_elemdescr=>describe_by_name
      EXPORTING
        p_name         = iv_db_name
      RECEIVING
        p_descr_ref    = lo_decr_ref
      EXCEPTIONS
        type_not_found = 1.

    IF sy-subrc = 1.
      RAISE EXCEPTION TYPE /gicom/cx_invalid_db_name
        EXPORTING
          iv_db_name = iv_db_name.
    ENDIF.
    lo_strucdescr ?= lo_decr_ref.


* Check if input is a DDIC table
    CHECK lo_strucdescr->is_ddic_type( ) = 'X'.

* Get the details of the table fields
    lt_tab_field = lo_strucdescr->get_ddic_field_list( ).

*Return the Key fields of the table
    LOOP AT lt_tab_field ASSIGNING FIELD-SYMBOL(<ls_tab_field>) WHERE keyflag = abap_true
                                                                AND   rollname NE 'MANDT'
                                                                AND   rollname NE 'CLNT'.
      APPEND <ls_tab_field> TO rt_primary_keys.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_range_from_table.
    " Never clear the EXPORTING table here, because this will break callers that
    " supply the same table to both parameters (which, for example, the AUTH classes will do).
    " CLEAR et_range_table.

    IF it_table IS INITIAL.
      RETURN.
    ENDIF.

    FIELD-SYMBOLS <ls_range> TYPE any.
    FIELD-SYMBOLS <lt_range> TYPE STANDARD TABLE.

    " Create new instance of exporting table
    DATA lr_range TYPE REF TO data.
    CREATE DATA lr_range LIKE et_range_table.

    ASSIGN lr_range->* TO <lt_range>.

    " Create a line of the exporting table to work with
    DATA lr_range_line TYPE REF TO data.
    CREATE DATA lr_range_line LIKE LINE OF et_range_table.

    ASSIGN lr_range_line->* TO <ls_range>.

    " Assign the individual components of said line
    ASSIGN COMPONENT 'SIGN' OF STRUCTURE <ls_range> TO FIELD-SYMBOL(<lv_sign>).
    CHECK sy-subrc EQ 0.
    <lv_sign> = iv_sign.

    ASSIGN COMPONENT 'OPTION' OF STRUCTURE <ls_range> TO FIELD-SYMBOL(<lv_option>).
    CHECK sy-subrc EQ 0.
    <lv_option> = 'EQ'.

    ASSIGN COMPONENT 'LOW' OF STRUCTURE <ls_range> TO FIELD-SYMBOL(<lv_low>).
    CHECK sy-subrc EQ 0.

    " We do not need HIGH

    DATA(lv_check_asterisk) = abap_undefined.

    " Now fill the range table item-by-item
    LOOP AT it_table ASSIGNING FIELD-SYMBOL(<lv_item>).
      IF lv_check_asterisk = abap_undefined.
        DESCRIBE FIELD <lv_item> TYPE DATA(lv_item_type).

        " cl_abap_typedescr=>typekind_char = 'C'
        " cl_abap_typedescr=>typekind_clike = '&'
        " cl_abap_typedescr=>typekind_date = 'D'
        " cl_abap_typedescr=>typekind_num = 'N'
        " cl_abap_typedescr=>typekind_time = 'T'
        " cl_abap_typedescr=>typekind_struct1 = 'u'

        " Determine if we have to check for asterisks in this value, for some data types,
        " e.g. GUIDs, it does not make a lot of sense.
        "
        " For this, we check if the item type is one of the valid data types
        " (see the list above for the whole name thingy of these types).
        "
        " Also, we use only one CO operation here instead of lots of '=' with OR,
        " because we reduce the amount of operations hence making this a teeny tiny bit
        " faster.
        lv_check_asterisk = xsdbool( lv_item_type CO 'C&DNTu' ).
      ENDIF.

      " We shouldn't try to exec CS '*' with lv_type 'x' which is a raw used e.g. for guids
      IF lv_check_asterisk = abap_true.
        IF <lv_item> CS '*'.
          <lv_option> = 'CP'.
        ELSE.
          <lv_option> = 'EQ'.
        ENDIF.
      ENDIF.

      <lv_low> = <lv_item>.

      APPEND <ls_range> TO <lt_range>.
    ENDLOOP.

    et_range_table = <lt_range>.
  ENDMETHOD.


  METHOD get_simple_selopts.
    IF it_field_value IS INITIAL.
      RAISE EXCEPTION TYPE /gicom/cx_illegal_arguments.
    ENDIF.

    CLEAR rt_selopt.

    LOOP AT it_field_value ASSIGNING FIELD-SYMBOL(<fs_entry>).
      APPEND VALUE #(
        shlpfield = to_upper( <fs_entry>-field )
        sign      = 'I'
        option    = COND #( WHEN <fs_entry>-value CS '*' THEN 'CP' ELSE 'EQ' )
        low       = <fs_entry>-value
      ) TO rt_selopt.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_where_clause_for_any_pk.
    TYPES: BEGIN OF group_keys,
             count      TYPE i,
             group_keys TYPE /gicom/group_keys,
           END OF group_keys.
    DATA: ls_group_keys_help TYPE group_keys,
          lt_group_keys_help TYPE TABLE OF group_keys,
          lv_where           TYPE string,
          lv_field_type      TYPE REF TO data,
          lv_option          TYPE string,
          lv_group_key       TYPE /gicom/group_keys,
          lv_count           TYPE i,
          lv_countdown       TYPE i.

    CLEAR rv_where_clause.


    IF it_primary_keys IS INITIAL.
      RETURN.
    ENDIF.

    "to do , import different options
    CLEAR lv_option.

    lv_option = 'EQ'.


*******************************************************
*1. Build help table to determine how many entries exit
*group by group_keys
*******************************************************
    LOOP AT it_primary_keys ASSIGNING FIELD-SYMBOL(<ls_primary_key>).

      IF lv_group_key IS INITIAL.
        lv_group_key = <ls_primary_key>-group_key.
      ENDIF.

      IF <ls_primary_key>-group_key EQ lv_group_key.
        lv_count = lv_count + 1.
      ELSE.

        ls_group_keys_help-count = lv_count.
        ls_group_keys_help-group_keys = lv_group_key.
        APPEND ls_group_keys_help TO lt_group_keys_help.

        CLEAR: lv_count, lv_group_key.

        lv_group_key = <ls_primary_key>-group_key.
        lv_count     = lv_count + 1.
      ENDIF.
    ENDLOOP.
    "The rest of the best
    IF sy-subrc EQ 0 AND lv_count IS NOT INITIAL AND lv_group_key IS NOT INITIAL.
      ls_group_keys_help-count = lv_count.
      ls_group_keys_help-group_keys = lv_group_key.
      APPEND ls_group_keys_help TO lt_group_keys_help.

      CLEAR: lv_count, lv_group_key.
    ENDIF.

*******************************************************
*2. Get all primary keys/columns of any table
*******************************************************
    TEST-SEAM table_keys.
      IF iv_primary_key_only EQ abap_true.
        DATA(lt_keys) = /gicom/cl_util_table=>get_primary_keys( iv_db_name ).
      ELSE.
        lt_keys = /gicom/cl_util_table=>get_keys( iv_db_name ).
      ENDIF.
    END-TEST-SEAM.

    LOOP AT it_primary_keys ASSIGNING <ls_primary_key>.


      READ TABLE lt_keys ASSIGNING FIELD-SYMBOL(<ls_key>) WITH KEY fieldname = <ls_primary_key>-fieldname.
      IF sy-subrc EQ 0.

*******************************************************
*3. Create data type of primary key
*   assign value to new data type
*******************************************************
        CREATE DATA lv_field_type TYPE (<ls_key>-rollname).
        ASSIGN lv_field_type->* TO FIELD-SYMBOL(<lv_field_value>).
        ASSIGN <ls_primary_key>-fieldvalue->* TO <lv_field_value>.





        IF lv_countdown IS INITIAL.
*******************************************************
*3.1 Determine number of entries group by group_keys
*    if more than 1 we have to bracket the expression
*******************************************************
          READ TABLE lt_group_keys_help ASSIGNING FIELD-SYMBOL(<ls_group_keys_help>) WITH KEY group_keys = <ls_primary_key>-group_key.
          IF sy-subrc EQ 0.
            "IF COUNT GT 1 means to build the following where : ( ID = 3 AND COUNTRY = DE )
            IF <ls_group_keys_help>-count GT 1.
              IF lv_where IS NOT INITIAL.
                CONCATENATE lv_where ' OR (' INTO lv_where.
              ELSE.
                CONCATENATE lv_where ' (' INTO lv_where.
              ENDIF.
            ELSE. " "IF COUNT EQ 1 means to build the following where :  ID = 3
              IF lv_where IS NOT INITIAL.
                CONCATENATE lv_where ' OR' INTO lv_where.
              ENDIF.
            ENDIF.

            lv_countdown = <ls_group_keys_help>-count.
          ENDIF. "  IF sy-subrc EQ 0.
        ENDIF." IF lv_countdown IS INITIAL.

*******************************************************
*3.2 Build Where Clause with primary key and value
*******************************************************
        "For security purpose:  Check field name
        TRY.
            cl_abap_dyn_prg=>check_column_name( <ls_key>-fieldname ).

          CATCH cx_abap_invalid_name INTO DATA(lx_err).
            RAISE EXCEPTION NEW /gicom/cx_illegal_arguments( previous = lx_err ).

        ENDTRY.

        CONCATENATE lv_where '' <ls_key>-fieldname ' ' lv_option' ' INTO lv_where SEPARATED BY space.
        lv_where = lv_where && cl_abap_dyn_prg=>quote( <lv_field_value> ).    "CONCATENATE lv_where '''' <lv_field_value> ''''  INTO lv_where.


        lv_countdown = lv_countdown - 1.

        IF lv_countdown GT 0 AND lv_countdown LE <ls_group_keys_help>-count.
          CONCATENATE lv_where ' AND' INTO lv_where.
        ELSEIF lv_countdown EQ 0 AND <ls_group_keys_help>-count GT 1.
          CONCATENATE lv_where ' )' INTO lv_where.
        ENDIF.


      ENDIF.

    ENDLOOP.




    rv_where_clause  =  lv_where.

  ENDMETHOD.


  METHOD move_structure.
***********************************************************************************************************************
***
***     Requirement (Mantis-No)       : VU
***     Created by                    : BAUER
***     Created on                    : 01.12.2016
***
***     Description:
***     Moves elements from one structure to an other. Should be used in case the constructor imports an stucture
***     in which is then mapped to an object stucture
***     E.g. Input structure /gicom/ngr_st_s mapped to /gicom/ngr_st_o
***
***     ! This method should be used across the product, so we have a central point for adjustments !
***
***********************************************************************************************************************

    DATA:   lo_descr_inp        TYPE REF TO cl_abap_typedescr
          , lo_descr_out        TYPE REF TO cl_abap_typedescr
          .

    FIELD-SYMBOLS:      <inp>   TYPE any
                    ,   <out>   TYPE any
                    .

***********************************************************************************************************************
*** Dynamic assignment of object attributes from structure
***********************************************************************************************************************

    "***************************************************************************************
    "*** a) Possibility 1: not always working (but maybe faster)
    "***************************************************************************************
*    es_destination = CORRESPONDING #( is_source ).

    TRY.
        MOVE-CORRESPONDING EXACT is_source TO es_destination.
        RETURN.

      CATCH cx_sy_conversion_error.
        " Do not return and carry on.
    ENDTRY.

    "***************************************************************************************
    "*** b) Possibility 2
    "***************************************************************************************
    DATA lo_struc_descr TYPE REF TO cl_abap_structdescr.
    DATA(lo_inp_descr) = cl_abap_typedescr=>describe_by_data( is_source ).

    lo_struc_descr ?= lo_inp_descr.

    DATA(lv_direct_move) = abap_true.

    LOOP AT lo_struc_descr->components ASSIGNING FIELD-SYMBOL(<ls_>).

      ASSIGN COMPONENT <ls_>-name OF STRUCTURE is_source TO <inp>.
      IF sy-subrc NE 0.
        CONTINUE.
      ENDIF.

      ASSIGN COMPONENT <ls_>-name OF STRUCTURE es_destination TO <out>.
      IF sy-subrc NE 0.
        CONTINUE.
      ENDIF.

      lo_descr_inp  = cl_abap_typedescr=>describe_by_data( <inp> ).
      lo_descr_out  = cl_abap_typedescr=>describe_by_data( <out> ).

      DATA(lv_kind) = lo_descr_inp->type_kind.

      DATA(lv_type_inp) = lo_descr_inp->get_relative_name( ).
      DATA(lv_type_out) = lo_descr_out->get_relative_name( ).


      "*** Parameter assignment if type matches
      "***************************************************
      IF lv_type_inp = lv_type_out AND lo_descr_inp->type_kind = lo_descr_out->type_kind.
        IF <inp> IS NOT INITIAL OR iv_ignore_initials = abap_false.
          <out> = <inp>.
        ENDIF.
      ELSE.
        lv_direct_move = abap_false.
        CONTINUE.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.


  METHOD move_table.
***********************************************************************************************************************
***
***     Requirement (Mantis-No)       :
***     Created by                    : Nikolas Heitkamp
***     Created on                    : 11.01.2017
***
***     Description:
***     Moves elements from one table to an other. Should be used in case the constructor imports an stucture
***     in which is then mapped to an object stucture
***
***     ! This method should be used across the product, so we have a central point for adjustments !
***
***********************************************************************************************************************
    DATA: lr_destination TYPE REF TO data.
    FIELD-SYMBOLS: <ls_destination> TYPE any.


***********************************************************************************************************************
*** Dynamic assignment of object attributes from table
***********************************************************************************************************************

    "***************************************************************************************
    "*** a) Possibility 1: not always working (but maybe faster)
    "***************************************************************************************
*    et_destination = CORRESPONDING #( it_source ).


    "***************************************************************************************
    "*** b) Possibility 2
    "***************************************************************************************
    CREATE DATA lr_destination LIKE LINE OF et_destination.
    ASSIGN lr_destination->* TO <ls_destination>.

    LOOP AT it_source ASSIGNING FIELD-SYMBOL(<ls_source>).

      CLEAR <ls_destination>.
      TEST-SEAM move_structure.
        /gicom/cl_util_table=>move_structure( EXPORTING is_source       = <ls_source>
                                              IMPORTING es_destination  = <ls_destination> ).
      END-TEST-SEAM.
      INSERT <ls_destination> INTO TABLE et_destination.

    ENDLOOP.



  ENDMETHOD.


  METHOD prevent_empty_range.
    " If the range already contains a row, we can just exit.
    IF ct_range IS NOT INITIAL.
      RETURN.
    ENDIF.

    " Otherwise, we have to create an empty row that excludes everything.

    " Start with some dereferencing magic
    DATA lr_line TYPE REF TO data.
    CREATE DATA lr_line LIKE LINE OF ct_range.

    FIELD-SYMBOLS <ls_line> TYPE any.
    ASSIGN lr_line->* TO <ls_line>.

    " Assign the relevant components
    ASSIGN COMPONENT 'SIGN' OF STRUCTURE <ls_line> TO FIELD-SYMBOL(<lv_sign>).
    CHECK sy-subrc = 0.

    ASSIGN COMPONENT 'OPTION' OF STRUCTURE <ls_line> TO FIELD-SYMBOL(<lv_option>).
    CHECK sy-subrc = 0.

    ASSIGN COMPONENT 'LOW' OF STRUCTURE <ls_line> TO FIELD-SYMBOL(<lv_low>).
    CHECK sy-subrc = 0.

    " Now we fill the fields to create an entry that reads "not like *":
    <lv_sign>   = 'I'.
    <lv_option> = 'NP'.
    <lv_low>    = '*'.

    " Add the line to the table and then we are done
    INSERT <ls_line> INTO TABLE ct_range.
  ENDMETHOD.


  METHOD split_table_to_batches.
    FIELD-SYMBOLS <lt_current> TYPE ANY TABLE.

    LOOP AT it_table ASSIGNING FIELD-SYMBOL(<ls_line>).
      IF ( sy-tabix - 1 ) MOD iv_batch_size = 0.
        DATA lr_data TYPE REF TO data.
        CREATE DATA lr_data LIKE it_table.

        ASSIGN lr_data->* TO <lt_current>.

        INSERT lr_data INTO TABLE rt_batches.
      ENDIF.

      INSERT <ls_line> INTO TABLE <lt_current>.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_table_batch.
    DATA(lv_start_idx) = ( iv_batch_index - 1 ) * iv_batch_size + 1.
    DATA(lv_end_idx)   = lv_start_idx + iv_batch_size - 1.

    CLEAR ct_batch.

    LOOP AT it_table FROM lv_start_idx TO lv_end_idx ASSIGNING FIELD-SYMBOL(<ls_line>).
      INSERT <ls_line> INTO TABLE ct_batch.
    ENDLOOP.
  ENDMETHOD.

  METHOD table_is_subset_of.

    rv_is_subset = abap_true.

    IF it_set IS INITIAL.
      RAISE EXCEPTION TYPE /gicom/cx_illegal_arguments.
    ELSE.
      LOOP AT it_subset ASSIGNING FIELD-SYMBOL(<ls_subset>).

        IF NOT line_exists( it_set[ table_line = <ls_subset> ] ).
          CLEAR rv_is_subset.
          EXIT.
        ENDIF.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD get_table_batch_count.
    rv_batches = ceil( CONV f( lines( it_table ) ) / CONV f( iv_batch_size ) ).
  ENDMETHOD.
ENDCLASS.
