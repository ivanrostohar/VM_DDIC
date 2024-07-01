CLASS /gicom/cl_util_ddic DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    TYPES:
      tty_dd07v TYPE TABLE OF dd07v .
    TYPES:
      tty_dd03p TYPE TABLE OF dd03p .

    "! Calls conversion exit input --> adding zeros
    "! @raising  /gicom/cx_conversion_error | This exception is raised in case a conversion exit returns a negative sy-subrc.
    "! The exception implements the if_t100_dyn_msg interface and contains the error information.
    "! Error details can be accessed using the method <em>get_text</em>.
    "! <br/>
    "! <strong>Example:</strong> Conversion exit which may influence the sy-subrc <em>CONVERSION_EXIT_CUNIT_INPUT</em>.
    CLASS-METHODS conv_exit_rem_to_loc
      IMPORTING
        !iv_input        TYPE clike
        !iv_conv_exit    TYPE convexit DEFAULT 'ALPHA'
        !iv_language     TYPE sy-langu OPTIONAL
      EXPORTING
        !ev_output    TYPE clike
      RAISING
        /gicom/cx_conversion_error.

    "! Calls conversion exit output --> removing zeros
    "! @raising  /gicom/cx_conversion_error | This exception is raised in case a conversion exit returns a negative sy-subrc.
    "! The exception implements the if_t100_dyn_msg interface and contains the error information.
    "! Error details can be accessed using the method <em>get_text</em>.
    "! <br/>
    "! <strong>Example:</strong> Conversion exit which may influence the sy-subrc <em>CONVERSION_EXIT_CUNIT_OUTPUT</em>.
    CLASS-METHODS conv_exit_loc_to_rem
      IMPORTING
        !iv_input     TYPE clike
        !iv_conv_exit TYPE convexit DEFAULT 'ALPHA'
      EXPORTING
        !ev_output    TYPE clike
      RAISING
        /gicom/cx_conversion_error.

    CLASS-METHODS get_type_name
      IMPORTING
        !iv_field      TYPE any
      CHANGING
        !co_typedescr  TYPE REF TO cl_abap_typedescr OPTIONAL
      RETURNING
        VALUE(rv_type) TYPE string .
    CLASS-METHODS get_domain_name
      IMPORTING
        !iv_field      TYPE any
      EXPORTING
        !ev_type_name  TYPE string
      CHANGING
        !co_typedescr  TYPE REF TO cl_abap_typedescr OPTIONAL
      RETURNING
        VALUE(rv_type) TYPE string
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS get_all_dom_values
      IMPORTING
        !iv_domname      TYPE ddobjname
        !iv_langu        TYPE sy-langu OPTIONAL
      RETURNING
        VALUE(rt_values) TYPE /gicom/dd07v_tt
      RAISING
        /gicom/cx_internal_error
        /gicom/cx_not_found
        /gicom/cx_illegal_arguments.
    CLASS-METHODS get_dom_value_txt
      IMPORTING
        !iv_domname   TYPE ddobjname
        !iv_domvalue  TYPE dd07v-domvalue_l
        !iv_langu     TYPE sy-langu OPTIONAL
      RETURNING
        VALUE(ev_txt) TYPE dd07v-ddtext .
    CLASS-METHODS get_domain_text_from_element
      IMPORTING
        iv_value      TYPE any
        iv_language   TYPE syst_langu DEFAULT sy-langu
      RETURNING
        VALUE(rv_txt) TYPE dd07v-ddtext.
    CLASS-METHODS check_dom_key_exists
      IMPORTING
        !iv_domname         TYPE ddobjname
        !iv_domvalue        TYPE dd07v-domvalue_l
      RETURNING
        VALUE(rv_valid_key) TYPE abap_bool
      RAISING
        /gicom/cx_internal_error
        /gicom/cx_illegal_arguments
        /gicom/cx_not_found .
    CLASS-METHODS get_ddic_def
      IMPORTING
        !iv_obj_name TYPE ddobjname
      CHANGING
        !et_dfies    TYPE /gicom/dfies_tt
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS get_conversion_exit
      IMPORTING
        !iv_type       TYPE any
      RETURNING
        VALUE(rv_exit) TYPE convexit .
    CLASS-METHODS has_conversion_exit_alpha
      IMPORTING
        !iv_type         TYPE any
      RETURNING
        VALUE(rv_result) TYPE abap_bool.

    CLASS-METHODS is_object_reference
      IMPORTING
        !io_obj             TYPE any
      RETURNING
        VALUE(rv_is_object) TYPE abap_bool .

    CLASS-METHODS is_string_like
      IMPORTING
        iv_val           TYPE any
      RETURNING
        VALUE(rv_result) TYPE abap_bool.

    CLASS-METHODS has_caller_same_super
      RETURNING
        VALUE(rv_result) TYPE abap_bool
      RAISING
        /gicom/cx_internal_error .

    CLASS-METHODS conv_shlp_selopt_to_where_exp
      IMPORTING
        VALUE(it_selopt)         TYPE ddshselops
        VALUE(iv_statement)      TYPE char1 DEFAULT '1'
        VALUE(iv_case_sensitive) TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(rv_where_exp)      TYPE string.
    CLASS-METHODS replace_special_chars
      IMPORTING
        VALUE(i_valid_chars)  TYPE clike OPTIONAL
        VALUE(i_xvalid_check) TYPE xfeld DEFAULT 'X'
        VALUE(i_xchar_repl)   TYPE xfeld DEFAULT 'X'
        VALUE(i_xtoupper)     TYPE xfeld DEFAULT 'X'
      CHANGING
        VALUE(c_string)       TYPE clike .

    CLASS-METHODS conv_bo_id_rem_to_loc
      IMPORTING
        !iv_bo_typ    TYPE /gicom/bo_typ
        !iv_input     TYPE clike
        !iv_conv_exit TYPE convexit DEFAULT 'ALPHA'
      EXPORTING
        !ev_output    TYPE clike.

    CLASS-METHODS conv_bo_id_loc_to_rem
      IMPORTING
        !iv_bo_typ    TYPE /gicom/bo_typ
        !iv_input     TYPE clike
        !iv_conv_exit TYPE convexit DEFAULT 'ALPHA'
      EXPORTING
        !ev_output    TYPE clike.

    CLASS-METHODS automatic_conversion_in
      IMPORTING
        iv_input  TYPE any
      EXPORTING
        ev_output TYPE any
      RAISING
        /gicom/cx_conversion_error.


    CLASS-METHODS automatic_conversion_out
      IMPORTING
                !iv_input  TYPE any
      EXPORTING
                !ev_output TYPE any
      RAISING   /gicom/cx_conversion_error.

    CLASS-METHODS conv_input_by_output_format
      IMPORTING
        !iv_input  TYPE any
      EXPORTING
        !ev_output TYPE any
      RAISING
        /gicom/cx_conversion_error
        cx_sy_conversion_overflow
        cx_sy_conversion_no_number.

    CLASS-METHODS convert_range_to_seltab
      IMPORTING
        VALUE(iv_field)  TYPE /gicom/string
        VALUE(it_range)  TYPE ANY TABLE
      RETURNING
        VALUE(rt_seltab) TYPE if_shdb_def=>tt_named_dref.

    CLASS-METHODS:
      describe_structure_ref
        IMPORTING
          ir_data            TYPE REF TO data
        RETURNING
          VALUE(rt_elements) TYPE /gicom/field_descr_element_tt,

      is_boolean
        IMPORTING
          iv_param         TYPE any
        CHANGING
          co_typedescr     TYPE REF TO cl_abap_typedescr OPTIONAL
        RETURNING
          VALUE(rv_result) TYPE abap_bool
        RAISING
          /gicom/cx_internal_error.

  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA sts_domain_details TYPE domain_details_tt .
    CLASS-DATA sts_has_conv_exit TYPE /gicom/has_conv_exit_stt .

    CLASS-METHODS:
      describe_components
        IMPORTING
          is_data             TYPE data
          it_component        TYPE abap_compdescr_tab
          VALUE(iv_parent_id) TYPE i DEFAULT 0
        CHANGING
          cv_index            TYPE i DEFAULT 0
        RETURNING
          VALUE(rt_elements)  TYPE /gicom/field_descr_element_tt,

      get_type
        IMPORTING
          io_element_descriptor TYPE REF TO cl_abap_elemdescr
          iv_component          TYPE any
        RETURNING
          VALUE(rv_type)        TYPE string,

      get_length
        IMPORTING
          io_element_descriptor TYPE REF TO cl_abap_elemdescr
        RETURNING
          VALUE(rv_length)      TYPE int4,

      is_timestamp
        IMPORTING
          iv_component     TYPE any
        RETURNING
          VALUE(rv_result) TYPE abap_bool
        RAISING
          /gicom/cx_internal_error,

      update_domain_val_texts
        IMPORTING
          iv_domname   TYPE ddobjname
          iv_langu     TYPE sy-langu
        CHANGING
          ct_dd07v_tab TYPE dd07v_tab
        RAISING
          /gicom/cx_invalid_arguments .



ENDCLASS.



CLASS /gicom/cl_util_ddic IMPLEMENTATION.


  METHOD automatic_conversion_in.

    DATA(lv_conv_exit) = /gicom/cl_util_ddic=>get_conversion_exit( iv_input ).

    IF "lv_conv_exit IS NOT INITIAL.
      lv_conv_exit EQ 'ALPHA' OR lv_conv_exit EQ 'CUNIT' OR lv_conv_exit EQ 'MATN1'.
      TEST-SEAM auto_c_o_conv_exit_rem_to_loc.
        /gicom/cl_util_ddic=>conv_exit_rem_to_loc(
                 EXPORTING
                    iv_input     = iv_input
                    iv_conv_exit = lv_conv_exit
                 IMPORTING
                    ev_output    = ev_output
                ).
      END-TEST-SEAM.
    ELSE.
      ev_output = iv_input.
    ENDIF.

  ENDMETHOD.


  METHOD automatic_conversion_out.

    DATA(lv_conv_exit) = /gicom/cl_util_ddic=>get_conversion_exit( iv_input ).

    IF "lv_conv_exit IS NOT INITIAL.
      lv_conv_exit EQ 'ALPHA' OR lv_conv_exit EQ 'CUNIT' OR lv_conv_exit = 'MATN1'.
      TEST-SEAM auto_c_o_conv_exit_loc_to_rem.
        /gicom/cl_util_ddic=>conv_exit_loc_to_rem(
           EXPORTING
              iv_input     = iv_input
              iv_conv_exit = lv_conv_exit
           IMPORTING
              ev_output    = ev_output
        ).
      END-TEST-SEAM.

    ELSE.
      ev_output = iv_input.
    ENDIF.


  ENDMETHOD.


  METHOD check_dom_key_exists.

    /gicom/cl_util_ddic=>get_all_dom_values(
      EXPORTING
        iv_domname                    = iv_domname
        iv_langu                      = sy-langu
      RECEIVING
        rt_values                     = DATA(lt_dom_values)
    ).

    READ TABLE lt_dom_values WITH KEY domvalue_l = iv_domvalue TRANSPORTING NO FIELDS.
    CHECK sy-subrc EQ 0.
    rv_valid_key = abap_true.

  ENDMETHOD.


  METHOD convert_range_to_seltab.
    CLEAR rt_seltab.
    CHECK it_range IS NOT INITIAL.

    DATA ls_seltab LIKE LINE OF rt_seltab.
    ls_seltab-name = iv_field.

    FIELD-SYMBOLS <ls_dref> TYPE ANY TABLE.
    CREATE DATA ls_seltab-dref LIKE it_range.

    ASSIGN ls_seltab-dref->* TO <ls_dref>.
    <ls_dref> = it_range.

    APPEND ls_seltab TO rt_seltab.
  ENDMETHOD.


  METHOD conv_bo_id_loc_to_rem.

    DATA: lr_data TYPE REF TO data,
          lv_dtel TYPE rollname.

    FIELD-SYMBOLS: <any> TYPE any.


    ev_output = iv_input.


*** Get data element of business objet id via type
********************************************************************
    TRY .
        lv_dtel = /gicom/cl_util_bo=>get_dtel_for_bo( iv_bo_typ ).
      CATCH /gicom/cx_no_data.
        ev_output = iv_input.
        RETURN.
    ENDTRY.

*** Create data
********************************************************************
    TEST-SEAM loc_to_rem_has_no_conv_alpha.
      CREATE DATA lr_data TYPE (lv_dtel).
      ASSIGN lr_data->* TO <any>.

      <any> = iv_input.
    END-TEST-SEAM.


*** Conversion
********************************************************************
    IF /gicom/cl_util_ddic=>has_conversion_exit_alpha( <any> ) = abap_true.
      TRY.
          TEST-SEAM conv_exit_loc_to_rem.
            /gicom/cl_util_ddic=>conv_exit_loc_to_rem(
             EXPORTING
                iv_input = <any>
             IMPORTING
                ev_output = <any>
            ).
          END-TEST-SEAM.
        CATCH /gicom/cx_conversion_error.
          " We can continue because conv_exit ALPHA throws no exception.
      ENDTRY.

      CONDENSE <any>.

    ENDIF.


***
********************************************************************
    ev_output = <any>.



  ENDMETHOD.


  METHOD conv_bo_id_rem_to_loc.

    DATA: lr_data TYPE REF TO data,
          lv_dtel TYPE rollname.

    FIELD-SYMBOLS: <any> TYPE any.


    ev_output = iv_input.


*** Get data element of business objet id via type
********************************************************************
    TRY .
        lv_dtel = /gicom/cl_util_bo=>get_dtel_for_bo( iv_bo_typ ).
      CATCH /gicom/cx_no_data.
        ev_output = iv_input.
        RETURN.
    ENDTRY.

*** Create data
********************************************************************
    TEST-SEAM has_no_conv_alpha.
      CREATE DATA lr_data TYPE (lv_dtel).
      ASSIGN lr_data->* TO <any>.

      <any> = iv_input.
    END-TEST-SEAM.

*** Conversion
********************************************************************



    IF /gicom/cl_util_ddic=>has_conversion_exit_alpha( <any> ) = abap_true.
      TRY.
          TEST-SEAM conv_exit_rem_to_loc.
            /gicom/cl_util_ddic=>conv_exit_rem_to_loc(
             EXPORTING
                iv_input = <any>
             IMPORTING
                ev_output = <any>
            ).
          END-TEST-SEAM.
        CATCH /gicom/cx_conversion_error.
          " We can continue because conv_exit ALPHA throws no exception.
      ENDTRY.
      CONDENSE <any>.

    ENDIF.


***
********************************************************************
    ev_output = <any>.

    " After the successful conversion, we do some little verification checks which should help us find programming errors
*    CASE iv_bo_typ.
*      WHEN /gicom/if_constants_bo=>cv_bo_ng OR
*           /gicom/if_constants_bo=>cv_bo_cntr_var.
*
*        " For these two cases, neither the last three digits nor the first ten digits of the BO id must be null
*        DATA lv_id TYPE c LENGTH 10.
*        DATA lv_no TYPE c LENGTH 3.
*
*        lv_id = ev_output(10).
*        lv_no = ev_output+10(3).
*
*        ASSERT lv_id IS NOT INITIAL AND lv_id <> '0000000000'.
*        ASSERT lv_no IS NOT INITIAL AND lv_no <> '000'.
*    ENDCASE.

  ENDMETHOD.


  METHOD conv_exit_loc_to_rem.
***********************************************************************************************************************
***
***     Requirement (Mantis-No)       : 11799 - Verhandlungsunterstützung
***     Created by                    : BAUER
***     Created on                    : 14.12.2016
***
***     Description:
***     Conversion exit ALPHA for local (back end) to remote (front-end) conversion.
***
***********************************************************************************************************************

    TRY.
        TEST-SEAM conv_exit_loc_to_rem_conv_op.
          /gicom/cl_sap_conversion=>conversion_exit_var_output(
            EXPORTING
              iv_input = iv_input
              iv_conv_exit = iv_conv_exit
            IMPORTING
              ev_output = ev_output
          ).
        END-TEST-SEAM.

      CATCH /gicom/cx_sap_call_error INTO DATA(lx_error).
        RAISE EXCEPTION NEW /gicom/cx_conversion_error( previous = lx_error ).

    ENDTRY.

  ENDMETHOD.


  METHOD conv_exit_rem_to_loc.
***********************************************************************************************************************
***
***     Requirement (Mantis-No)       : 11799 - Verhandlungsunterstützung
***     Created by                    : BAUER
***     Created on                    : 14.12.2016
***
***     Description:
***     Conversion exit ALPHA for remote (front-end) to local (back end) conversion.
***
***********************************************************************************************************************
    TRY.

        TEST-SEAM conv_exit_rem_to_loc_conv_ip.
          /gicom/cl_sap_conversion=>conversion_exit_var_input(
            EXPORTING
              iv_input       = iv_input
              iv_conv_exit   = iv_conv_exit
              iv_language    = iv_language
            IMPORTING
              ev_output = ev_output
          ).
        END-TEST-SEAM.

      CATCH /gicom/cx_sap_call_error INTO DATA(lx_call_error).
*        IF iv_conv_exit = 'CUNIT'.
*          RAISE EXCEPTION NEW /gicom/cx_cunit_not_found( previous = lx_call_error iv_unit = sy-msgv1 iv_langu = sy-msgv2 ).
*        ENDIF.

        RAISE EXCEPTION NEW /gicom/cx_conversion_error( previous = lx_call_error ).

    ENDTRY.

  ENDMETHOD.


  METHOD conv_shlp_selopt_to_where_exp.
**********************************************************************
*Description:                                                        *
**********************************************************************
*Convert a SAP Searchhelp Select-option to a dynamic where clause,
*which can be used in a loop expression.
**********************************************************************
*Mantis: <Nummer>   <Topic of Mantis>                                *
*Date: 10.01.2017                                                    *
*Creator: Felix Bürling                                              *
**********************************************************************
*Mantis History:                                                     *
**********************************************************************
*******************************************************
*0. Declaration
*******************************************************
    TYPES: BEGIN OF field_help,
             count TYPE i,
             field TYPE fieldname,
           END OF field_help.
    DATA ls_field_help TYPE field_help.
    DATA lt_field_help TYPE TABLE OF field_help.
    DATA lt_generic_selopt TYPE ddshselops.
    DATA lv_count TYPE i.
    DATA lv_countdown TYPE i.
    DATA lv_fieldname TYPE fieldname.
    DATA lv_option    TYPE string.
    DATA lv_where  TYPE string.
    DATA(lv_case_sensitive) = iv_case_sensitive.



    FIELD-SYMBOLS:
      <ls_selopt>     TYPE ddshselopt,
      <ls_field_help> TYPE field_help.

*******************************************************
*1. Exportparameter clearen
*******************************************************
    CLEAR rv_where_exp.

*******************************************************
*1.1 Pass Importparameter without wildcard '*'
*******************************************************
    LOOP AT it_selopt ASSIGNING <ls_selopt> WHERE low NE '*'.
      APPEND <ls_selopt> TO lt_generic_selopt.
    ENDLOOP.

*******************************************************
*1.2 Sort table
*******************************************************
    SORT lt_generic_selopt BY shlpfield.

*******************************************************
*2. Build help table to determine how many entries exit
*   group by shlpfield
*******************************************************
    LOOP AT lt_generic_selopt ASSIGNING <ls_selopt>.

      IF lv_fieldname IS INITIAL.
        lv_fieldname  = <ls_selopt>-shlpfield.
      ENDIF.

      IF <ls_selopt>-shlpfield EQ lv_fieldname.
        lv_count = lv_count + 1.
      ELSE.

        ls_field_help-count = lv_count.
        ls_field_help-field = lv_fieldname.
        APPEND ls_field_help TO lt_field_help.

        CLEAR: lv_count, lv_fieldname.

        lv_fieldname = <ls_selopt>-shlpfield.
        lv_count     = lv_count + 1.
      ENDIF.

    ENDLOOP.
    IF sy-subrc EQ 0 AND lv_count IS NOT INITIAL AND lv_fieldname IS NOT INITIAL.
      ls_field_help-count = lv_count.
      ls_field_help-field = lv_fieldname.
      APPEND ls_field_help TO lt_field_help.

      CLEAR: lv_count, lv_fieldname.
    ENDIF.

    UNASSIGN <ls_selopt>.

*******************************************************
*3. Build where clause
*******************************************************
    LOOP AT lt_generic_selopt ASSIGNING <ls_selopt>.

      CLEAR lv_option.

      IF lv_countdown IS INITIAL.
*******************************************************
*3.2 Determine number of entries group by shlpfield
*    if more than 1 we have to bracket the expression
*******************************************************
        READ TABLE lt_field_help ASSIGNING <ls_field_help> WITH KEY field = <ls_selopt>-shlpfield.
        IF sy-subrc EQ 0.
          IF <ls_selopt>-sign = 'E'.
            IF lv_where IS NOT INITIAL.
              lv_where = |{ lv_where } AND NOT (|.
            ELSE.
              lv_where = |{ lv_where } NOT (|.
            ENDIF.
          ELSE.
            IF <ls_field_help>-count GT 1.

              IF lv_where IS NOT INITIAL.
                CONCATENATE lv_where ' AND (' INTO lv_where.
              ELSE.
                CONCATENATE lv_where ' (' INTO lv_where.
              ENDIF.
            ELSE.
              IF lv_where IS NOT INITIAL.
                CONCATENATE lv_where ' AND' INTO lv_where.
              ENDIF.
            ENDIF.
          ENDIF.

          lv_countdown = <ls_field_help>-count.
        ENDIF. "  IF sy-subrc EQ 0.
      ENDIF." IF lv_countdown IS INITIAL.


*******************************************************
*3.3 set sepcial expression for where clause
*******************************************************
      IF <ls_selopt>-option EQ 'BT'.
        lv_option = 'BETWEEN'.
      ELSEIF <ls_selopt>-option EQ 'NB'.
        lv_option = 'NOT BETWEEN'.
      ELSE.
        lv_option = <ls_selopt>-option.
      ENDIF.


*******************************************************
*3.4 set sepcial expression for SELECT where clause
*******************************************************
      IF iv_statement EQ '2'.
        REPLACE ALL OCCURRENCES OF '*' IN <ls_selopt>-low WITH '%'.
        IF <ls_selopt>-option EQ 'CP'.
          lv_option = 'LIKE'.
        ELSEIF <ls_selopt>-option EQ 'NP'.
          lv_option = 'NOT LIKE'.
        ENDIF.
      ENDIF.


      "For security purpose:  Check field name
      TRY.
          cl_abap_dyn_prg=>check_column_name( <ls_selopt>-shlpfield ).
        CATCH cx_abap_invalid_name INTO DATA(lo_err).
          RAISE EXCEPTION TYPE /gicom/cx_illegal_arguments
            EXPORTING
              previous = lo_err.
      ENDTRY.
*******************************************************
*3.5 BT = BETWEEN and NB = NOT BETWEEN
*******************************************************
      IF lv_option IS NOT INITIAL AND <ls_selopt>-high IS NOT INITIAL.

        CONCATENATE lv_where '' <ls_selopt>-shlpfield ' ' lv_option' ' INTO lv_where SEPARATED BY space.
        lv_where = lv_where && cl_abap_dyn_prg=>quote( <ls_selopt>-low ).   "CONCATENATE lv_where '''' <ls_selopt>-low ''''  INTO lv_where.
        CONCATENATE lv_where 'AND' INTO lv_where SEPARATED BY space.
        CONCATENATE lv_where ' ' INTO lv_where SEPARATED BY space.
        lv_where = lv_where && cl_abap_dyn_prg=>quote( <ls_selopt>-high ).



*******************************************************
*3.6  EQ, NE, CP, GT, LE, LT and NP
*******************************************************
      ELSE.

        IF ( <ls_selopt>-option = 'CP' OR <ls_selopt>-option = 'NP' ) AND lv_case_sensitive EQ abap_false .

          CONCATENATE lv_where ' LOWER(' <ls_selopt>-shlpfield ') ' lv_option ' ' INTO lv_where SEPARATED BY space.
          lv_where = lv_where && cl_abap_dyn_prg=>quote( to_lower( <ls_selopt>-low ) ).

        ELSE.

          CONCATENATE lv_where '' <ls_selopt>-shlpfield ' ' lv_option' ' INTO lv_where SEPARATED BY space.
          lv_where = lv_where && cl_abap_dyn_prg=>quote( <ls_selopt>-low ).
        ENDIF.
      ENDIF.



      lv_countdown = lv_countdown - 1.

      IF lv_countdown GT 0 AND lv_countdown LE <ls_field_help>-count.
        CONCATENATE lv_where ' OR' INTO lv_where.
      ELSEIF lv_countdown EQ 0 AND ( <ls_field_help>-count GT 1 OR <ls_selopt>-sign = 'E' ).
        CONCATENATE lv_where ' )' INTO lv_where.
      ENDIF.

    ENDLOOP.


*******************************************************
*4. Passing the Returning Parameter
*******************************************************
    rv_where_exp = lv_where.

  ENDMETHOD.


  METHOD get_all_dom_values.
***********************************************************************************************************************
***
***     Requirement (Mantis-No)       : 11933   <Verhandlungsunterstützung>
***     Created by                    : BAUER
***     Created on                    : 29.11.2016
***
***     Description:
***     Read all domain text values for a given domainname.
***
***********************************************************************************************************************
    DATA lv_rc TYPE syst_subrc.

    DATA lt_values TYPE dd07v_tab.

    TRY.
        TEST-SEAM get_all_dom_values_dd_domv_get.
          /gicom/cl_sap_ddic=>dd_domvalues_get(
            EXPORTING
              iv_domname        = iv_domname
              iv_text           = 'X'
              iv_langu          = iv_langu
              iv_bypass_buffer  = space
            IMPORTING
              ev_rc             = lv_rc
            CHANGING
              ct_dd07v_tab      = lt_values ).
        END-TEST-SEAM.
      CATCH /gicom/cx_sap_call_error.
        " no exception, just default in error case
        CLEAR lv_rc.
    ENDTRY.

    TRY.
        IF iv_langu NE 'E'.
          /gicom/cl_util_ddic=>update_domain_val_texts(
            EXPORTING
              iv_domname   = iv_domname
              iv_langu     = iv_langu
            CHANGING
              ct_dd07v_tab = lt_values ).
        ENDIF.
      CATCH /gicom/cx_invalid_arguments.
        " no exception, just coninue with English texts
    ENDTRY.

    rt_values = CORRESPONDING #( lt_values ).

*  " Does the domain exist?
*  IF lv_rc <> 0.
*    RAISE EXCEPTION TYPE /gicom/cx_not_found.
*  ENDIF.

** if no fixed values present get value table if present

    IF rt_values IS INITIAL.
      DATA: lwa_valtable    TYPE dd01v,
            lv_valtabletext TYPE dd08v-tabname,
            lv_check        TYPE dd08v-fieldname,
            lt_dfies        TYPE TABLE OF dfies,
            lwa_rtvalues    TYPE /gicom/dd07v_s,
            lo_ref          TYPE REF TO data,
            lo_reftxt       TYPE REF TO data,
            lv_where        TYPE string,
            lwa_where       TYPE edpline,
            lt_where        TYPE TABLE OF edpline,
            lwa_dfies       TYPE dfies,
            lv_temp         TYPE string.
      FIELD-SYMBOLS:<lt_descr> TYPE ANY TABLE.
******************************************************************************
*      get the value table  for the domain
******************************************************************************

      TRY.
          TEST-SEAM get_all_dom_vals_ddif_doma_get.
            /gicom/cl_sap_ddic=>ddif_doma_get(
                EXPORTING
                  iv_name     = iv_domname
                  iv_state    = 'A'
                  iv_langu    = iv_langu
                IMPORTING
                  ev_dd01v_wa = lwa_valtable ).
          END-TEST-SEAM.
        CATCH /gicom/cx_sap_call_error.
          " no exception, just default in error case
          CLEAR lwa_valtable.
      ENDTRY.
******************************************************************************
*      Check value table exists
******************************************************************************
      IF lwa_valtable-entitytab IS NOT INITIAL.
******************************************************************************
*        get the Text table
******************************************************************************
        TEST-SEAM get_all_dom_values_texttable.
          /gicom/cl_sap_ddic=>ddut_texttable_get(
            EXPORTING
              iv_tabname    = lwa_valtable-entitytab
            IMPORTING
              ev_texttable  = lv_valtabletext
              ev_checkfield = lv_check ).
        END-TEST-SEAM.

        FIELD-SYMBOLS <lt_tab> TYPE ANY TABLE.
        FIELD-SYMBOLS <lt_table> TYPE ANY TABLE.
        IF NOT lv_valtabletext IS INITIAL.
          CREATE DATA lo_reftxt TYPE TABLE OF (lv_valtabletext).
          ASSIGN lo_reftxt->* TO <lt_table>.
        ENDIF.

        CREATE DATA lo_ref TYPE TABLE OF (lwa_valtable-entitytab).
        ASSIGN lo_ref->* TO <lt_tab>.
        CHECK <lt_tab> IS ASSIGNED.
***************************************************************************
*        get fields for the value table
***************************************************************************

        TRY.
            TEST-SEAM get_all_dom_values_lt_dfies.
              /gicom/cl_sap_ddic=>ddif_fieldinfo_get(
                  EXPORTING
                    iv_tabname   = lwa_valtable-entitytab
                    iv_langu     = iv_langu
                  CHANGING
                    cs_dfies_tab = lt_dfies ).
            END-TEST-SEAM.
          CATCH /gicom/cx_sap_call_error.
            " no exception, just default in error case
            CLEAR lt_dfies.
        ENDTRY.

**************************************************************************
*        get fieldname for that domain
**************************************************************************
        READ TABLE lt_dfies INTO lwa_dfies
                            WITH KEY domname = iv_domname.

        IF sy-subrc EQ 0.
          lv_temp = lwa_dfies-fieldname.

          TRY.
              DATA(lv_fieldname)  = cl_abap_dyn_prg=>check_column_name( val    = lwa_dfies-fieldname ).
              lv_fieldname        = cl_abap_dyn_prg=>check_whitelist_str( val = lv_fieldname whitelist = lwa_dfies-fieldname ).

              TEST-SEAM get_all_dom_values_error.
                DATA(lv_tabname)    = cl_abap_dyn_prg=>check_table_name_str(
                  val                = lwa_valtable-entitytab
                  packages           = '/GICOM/FDN,BASIS'
                  incl_sub_packages  = abap_true
                ).
              END-TEST-SEAM.

            CATCH cx_abap_not_in_whitelist cx_abap_not_a_table cx_abap_not_in_package cx_abap_invalid_name INTO DATA(lo_ex3).

              RAISE EXCEPTION TYPE /gicom/cx_illegal_arguments
                EXPORTING
                  previous = lo_ex3.
          ENDTRY.


          SELECT (lv_fieldname) FROM (lv_tabname) INTO CORRESPONDING FIELDS OF TABLE <lt_tab>.
*******************************************************************************************
*            get description
*******************************************************************************************
          IF <lt_table> IS  ASSIGNED.
            CONCATENATE '<lt_tab>' lv_fieldname INTO lv_where SEPARATED BY '-'.
            CONCATENATE lv_fieldname '= ' lv_where INTO lwa_where SEPARATED BY space.
            APPEND lwa_where TO lt_where.

            TRY.
                TEST-SEAM get_all_dom_values_error2.
                  DATA(lv_texttabname)    = cl_abap_dyn_prg=>check_table_name_str( val                = lv_valtabletext
                                                                                   packages           = '/GICOM/FDN,BASIS'
                                                                                   incl_sub_packages  = abap_true
                                                                                 ).
                END-TEST-SEAM.

              CATCH cx_abap_not_a_table cx_abap_not_in_package INTO DATA(lo_ex4).
                RAISE EXCEPTION TYPE /gicom/cx_illegal_arguments
                  EXPORTING
                    previous = lo_ex4.

            ENDTRY.


            SELECT * FROM (lv_texttabname) INTO CORRESPONDING FIELDS OF TABLE <lt_table>
                                       FOR ALL ENTRIES IN <lt_tab> WHERE (lt_where).


            IF <lt_table> IS NOT INITIAL.
              DATA(lo_struct_desc) = CAST cl_abap_structdescr( cl_abap_structdescr=>describe_by_name( lv_texttabname ) ).

              DATA(lv_spras_field) = 'SPRAS'.

              IF NOT line_exists( lo_struct_desc->components[ name = lv_spras_field ] ).
                lv_spras_field = 'LANGU'.
              ENDIF.
            ENDIF.
          ENDIF.

****************************************************************************************
*              GET Description from text table
****************************************************************************************
          IF lv_valtabletext IS NOT INITIAL.
            CLEAR: lt_dfies,lwa_dfies.

            TEST-SEAM get_lt_dfies_description.
              TRY.
                  /gicom/cl_sap_ddic=>ddif_fieldinfo_get(
                    EXPORTING
                      iv_tabname   = lv_valtabletext
                      iv_langu     = sy-langu
                    CHANGING
                      cs_dfies_tab = lt_dfies ).
                CATCH /gicom/cx_sap_call_error.
                  CLEAR lt_dfies.
              ENDTRY.
            END-TEST-SEAM.

*****************************************************************************************
*          Read non key field from text table
*****************************************************************************************
            READ TABLE lt_dfies INTO lwa_dfies
                         WITH KEY keyflag = ' '.
          ENDIF.

          LOOP AT <lt_tab> ASSIGNING FIELD-SYMBOL(<lwa_tab>).
            ASSIGN COMPONENT lv_temp OF STRUCTURE <lwa_tab> TO FIELD-SYMBOL(<lv_value>).
            CHECK <lv_value> IS ASSIGNED.

            IF <lt_table> IS ASSIGNED.
              READ TABLE <lt_table> ASSIGNING FIELD-SYMBOL(<lwa_texttable>) WITH KEY (lv_check) = <lv_value>
                                                                                      (lv_spras_field) = iv_langu.

              IF sy-subrc <> 0.
                TRY.
                    ASSIGN <lt_table>[ (lv_check) = <lv_value> (lv_spras_field) = 'E' ] TO <lwa_texttable>.
                  CATCH cx_sy_itab_line_not_found.
                ENDTRY.
              ENDIF.

              ASSIGN COMPONENT lwa_dfies-fieldname OF STRUCTURE <lwa_texttable> TO FIELD-SYMBOL(<lv_ddtext>).
              CHECK <lv_ddtext> IS ASSIGNED.
              lwa_rtvalues-ddtext = <lv_ddtext>.
            ENDIF.

            lwa_rtvalues-domvalue_l = <lv_value>.

            " Also set extended value
            lwa_rtvalues-domvalue_ext = <lv_value>.

            lwa_rtvalues-domname = iv_domname.
            lwa_rtvalues-ddlanguage = iv_langu.
            APPEND lwa_rtvalues TO rt_values .
          ENDLOOP.

        ENDIF.

*         IF SY-SUBRC <> 0.
* Implement suitable error handling here
*         ENDIF.

      ELSE.
****************************************************
*      if domain doesnot have value table and fixed values
***************************************************
        RAISE EXCEPTION TYPE /gicom/cx_not_found.
      ENDIF.

*     IF SY-SUBRC <> 0.
** Implement suitable error handling here
*     ENDIF.

    ENDIF.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error.
    ENDIF.

  ENDMETHOD.


  METHOD get_conversion_exit.
    CLEAR rv_exit.

    DESCRIBE FIELD iv_type EDIT MASK DATA(lv_exit).

    REPLACE ALL OCCURRENCES OF '=' IN lv_exit WITH ''.

    rv_exit = lv_exit.
  ENDMETHOD.


  METHOD get_ddic_def.
**
**  Autor:  Patrick Böhm - gicom GmbH
**  Datum:  30.11.2016
**  Mantis: 12030
**
**  Description:
**    Load definition of an DDIC-Object
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************
    REFRESH: et_dfies.

***********************************************************************************************************
*** 1. Load definition
***********************************************************************************************************

    TRY.
        TEST-SEAM get_ddic_ref_ddif_nametab_get.
          /gicom/cl_sap_ddic=>ddif_nametab_get(
            EXPORTING
              iv_tabname   = iv_obj_name
              iv_all_types = 'X'
            CHANGING
              ct_dfies_tab = et_dfies ).
        END-TEST-SEAM.
      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION TYPE /gicom/cx_internal_error
          MESSAGE ID '/GICOM/MSG_FOUNDAT'
          TYPE 'E'
          NUMBER '000'
          WITH iv_obj_name
          EXPORTING
            previous = lo_ex.

    ENDTRY.

  ENDMETHOD.


  METHOD get_domain_name.

    DATA: lt_domain_details     TYPE TABLE OF dtelinfo.
    DATA: ls_domain_details     TYPE dtelinfo.
    DATA: lv_data_type          TYPE ddobjname.

    TEST-SEAM get_domain_name_ev_type_name.
      ev_type_name = lv_data_type = /gicom/cl_util_ddic=>get_type_name(
          EXPORTING
              iv_field = iv_field
          CHANGING
              co_typedescr = co_typedescr
      ).
    END-TEST-SEAM.

***********************************************************************************************************************
***  We store data type name with domain details in static buffer table to reduce database load
***********************************************************************************************************************
    READ TABLE sts_domain_details WITH KEY type_name = lv_data_type ASSIGNING FIELD-SYMBOL(<ls_>).

    IF sy-subrc EQ 0.
      rv_type = <ls_>-domain_detail_s-refname.
      RETURN.
    ENDIF.

    TEST-SEAM get_domain_name_co_typedescr.
      co_typedescr->get_ddic_header(
        RECEIVING
          p_header = DATA(ls_hdr)
        EXCEPTIONS
          no_ddic_type = 1
          OTHERS = 999
      ).
    END-TEST-SEAM.

    IF sy-subrc EQ 1.
      " in case type eq abap_bool there is no domain value just exit
      RETURN.
    ENDIF.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_FOUNDAT'
        TYPE 'E'
        NUMBER '000'
        WITH lv_data_type.
    ENDIF.

***********************************************************************************************************************
***  We insert domain details into our buffer table if it was unknown before
***********************************************************************************************************************
    INSERT VALUE #( type_name = lv_data_type domain_detail_s = ls_hdr ) INTO TABLE sts_domain_details.

    rv_type = ls_hdr-refname.

  ENDMETHOD.


  METHOD get_dom_value_txt.
***********************************************************************************************************************
***
***     Requirement (Mantis-No)       : 11933   <Verhandlungsunterstützung>
***     Created by                    : BAUER
***     Created on                    : 14.11.2016
***
***     Description:
***     Get text for a specific domain value for a given language.
***
***********************************************************************************************************************

    DATA:   ls_dd07v TYPE dd07v
          , lv_langu TYPE sy-langu
          .

    IF iv_langu IS NOT SUPPLIED OR iv_langu IS INITIAL.
      lv_langu = sy-langu.
    ELSE.
      lv_langu = iv_langu.
    ENDIF.

    TRY.
        TEST-SEAM get_dom_value_ddut_text.
          /gicom/cl_sap_ddic=>ddut_domvalue_text_get(
            EXPORTING
              iv_name          = iv_domname
              iv_value         = iv_domvalue
              iv_langu         = lv_langu
              iv_texts_only    = ' '
            IMPORTING
              es_dd07v_wa      = ls_dd07v ).
        END-TEST-SEAM.
      CATCH /gicom/cx_sap_call_error.
        CLEAR ls_dd07v.
    ENDTRY.

    IF sy-subrc <> 0.
      " No text found
    ENDIF.

    ev_txt = ls_dd07v-ddtext.
  ENDMETHOD.


  METHOD get_type_name.
    IF co_typedescr IS NOT BOUND.
      co_typedescr = cl_abap_typedescr=>describe_by_data( iv_field ).
    ENDIF.

    rv_type = co_typedescr->get_relative_name( ).
  ENDMETHOD.


  METHOD has_caller_same_super.

    DATA lv_name TYPE abap_abstypename.

    rv_result = abap_false.

    DATA lt_call_stack TYPE sys_callst.

    TEST-SEAM has_same_super_sys_callstack.
      /gicom/cl_sap_standard=>system_callstack(
        EXPORTING
          iv_max_level    = 3
        IMPORTING
          et_callstack = lt_call_stack ).
    END-TEST-SEAM.


    "ENDIF.
***********************************************************************************************************
*** 1. Get class description of checking class
***********************************************************************************************************
    READ TABLE lt_call_stack ASSIGNING FIELD-SYMBOL(<call_stack_checker>) INDEX 2.  "Fix index 3 --> Checker

    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error.
    ENDIF.

    "Extract class name (eliminate =========CP)
    lv_name = cl_oo_classname_service=>get_clsname_by_include( <call_stack_checker>-progname ).

    IF lv_name IS INITIAL.
      "--> no class
      rv_result = abap_false.
      RETURN.
    ENDIF.

    "get class_descriptor
    DATA(lo_class_descr_checker) = CAST cl_abap_classdescr( cl_abap_classdescr=>describe_by_name( lv_name ) ).



***********************************************************************************************************
*** 2. Get class description of calling class
***********************************************************************************************************
    READ TABLE lt_call_stack ASSIGNING FIELD-SYMBOL(<call_stack_caller>) INDEX 3.  "Fix index 3 --> Caller
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error.
    ENDIF.

    lv_name = cl_oo_classname_service=>get_clsname_by_include( <call_stack_caller>-progname ).

    IF lv_name IS INITIAL.
      "--> no class
      rv_result = abap_false.
      RETURN.
    ENDIF.


    "get class_descriptor
    DATA(lo_class_descr_caller) = CAST cl_abap_classdescr( cl_abap_classdescr=>describe_by_name( lv_name ) ).



***********************************************************************************************************
*** 3. Compare super class name
***********************************************************************************************************
    IF lo_class_descr_caller->get_super_class_type( )->absolute_name EQ lo_class_descr_checker->get_super_class_type( )->absolute_name.
      rv_result = abap_true.
    ENDIF.



  ENDMETHOD.


  METHOD has_conversion_exit_alpha.
    rv_result = xsdbool( /gicom/cl_util_ddic=>get_conversion_exit( iv_type ) = 'ALPHA' ).
  ENDMETHOD.


  METHOD is_object_reference.
    CHECK cl_abap_typedescr=>describe_by_data( io_obj )->kind EQ cl_abap_typedescr=>kind_class.
    rv_is_object = abap_true.
  ENDMETHOD.


  METHOD is_string_like.
    DESCRIBE FIELD iv_val TYPE DATA(lv_type).

    IF lv_type = 'C' OR lv_type = 'g'.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD replace_special_chars.

    IF NOT i_xchar_repl IS INITIAL.

      TRY.
          TEST-SEAM scp_replace_strange_chars.
            /gicom/cl_sap_conversion=>scp_replace_strange_chars(
                EXPORTING
                  iv_intext  = c_string
                IMPORTING
                  ev_outtext = c_string ).
          END-TEST-SEAM.

        CATCH /gicom/cx_sap_call_error.
          CLEAR c_string.
      ENDTRY.
    ENDIF.

    IF NOT i_xtoupper IS INITIAL.
      TRANSLATE c_string TO UPPER CASE.
    ENDIF.

    IF NOT ( i_xvalid_check IS INITIAL OR i_valid_chars IS INITIAL ).
      WHILE c_string CN i_valid_chars.
        WRITE space TO c_string+sy-fdpos(1).
      ENDWHILE.
    ENDIF.

  ENDMETHOD.


  METHOD get_domain_text_from_element.
    DATA(lo_descr) = cl_abap_datadescr=>describe_by_data( iv_value ).

    IF NOT lo_descr IS INSTANCE OF cl_abap_elemdescr.
      RAISE EXCEPTION NEW /gicom/cx_illegal_arguments( ).
    ENDIF.

    DATA(lo_elemdescr) = CAST cl_abap_elemdescr( lo_descr ).

    IF NOT lo_elemdescr->is_ddic_type( ).
      " If this is not a DDIC type, we cannot read the domain values
      RETURN.
    ENDIF.

    rv_txt = /gicom/cl_util_ddic=>get_dom_value_txt(
      iv_domname  = lo_elemdescr->get_ddic_header( )-refname
      iv_domvalue = CONV domvalue_l( iv_value )
      iv_langu    = iv_language
    ).
  ENDMETHOD.


  METHOD describe_structure_ref.
    ASSIGN ir_data->* TO FIELD-SYMBOL(<ls_data>).

    DATA(lo_type_ref) = cl_abap_typedescr=>describe_by_data_ref( ir_data ).

    DATA(lo_struct_descr) = CAST cl_abap_structdescr( lo_type_ref ).

    DATA(lt_struct_components) = lo_struct_descr->components.

    rt_elements = /gicom/cl_util_ddic=>describe_components(
      is_data      = <ls_data>
      it_component = lt_struct_components
    ).
  ENDMETHOD.


  METHOD describe_components.
    DATA:
      ls_line TYPE REF TO data.
    FIELD-SYMBOLS:
      <ls_table> TYPE ANY TABLE,
      <ls_line>  TYPE any.

    LOOP AT it_component ASSIGNING FIELD-SYMBOL(<ls_struct_component>).
      ASSIGN COMPONENT <ls_struct_component>-name OF STRUCTURE is_data TO FIELD-SYMBOL(<lv_component>).

      IF <lv_component> IS NOT ASSIGNED. "we are the element of a table (hopefully..)
        ASSIGN is_data TO <ls_table>.
        CREATE DATA ls_line LIKE LINE OF <ls_table>. "just works (tm)
        ASSIGN ls_line->* TO <ls_line>.
        ASSIGN COMPONENT <ls_struct_component>-name OF STRUCTURE <ls_line> TO FIELD-SYMBOL(<lv_comp>).

        DATA(lo_c_descr) = cl_abap_typedescr=>describe_by_data( <lv_comp> ).
        DATA(lo_e_descr) = CAST cl_abap_elemdescr( lo_c_descr ).
        cv_index = cv_index + 1.

        APPEND VALUE #(
          id = cv_index
          name = <ls_struct_component>-name
          type = /gicom/cl_util_ddic=>get_type(
            io_element_descriptor = lo_e_descr
            iv_component = <lv_comp>
          )
          length = /gicom/cl_util_ddic=>get_length( lo_e_descr )
          decimals = lo_e_descr->decimals
          parent_id = iv_parent_id
        ) TO rt_elements.

        CONTINUE.
      ENDIF.

      DATA(lo_component_descr) = cl_abap_typedescr=>describe_by_data( <lv_component> ).

      IF lo_component_descr IS INSTANCE OF cl_abap_tabledescr.
        DATA(lo_comp_table_descr) = CAST cl_abap_tabledescr( lo_component_descr ).
        cv_index = cv_index + 1.
        READ TABLE lo_comp_table_descr->key INDEX 1 INTO DATA(lo_first_column).
        IF lo_first_column-name EQ  'TABLE_LINE'. "If the table is a plain table it has no column name instead it has TABLE_LINE which gets checked here
          APPEND VALUE #(
           id = cv_index
           name = <ls_struct_component>-name
           type = '_P'
           length = 0
           decimals = 0
           parent_id = iv_parent_id
         ) TO rt_elements.

        ELSE.
          APPEND VALUE #(
            id = cv_index
            name = <ls_struct_component>-name
            type = '_T'
            length = 0
            decimals = 0
            parent_id = iv_parent_id
          ) TO rt_elements.
        ENDIF.
        DATA(lo_table_line_descr) = lo_comp_table_descr->get_table_line_type( ).
        IF lo_table_line_descr IS INSTANCE OF cl_abap_structdescr.

          DATA(lo_table_line_struc_descr) = CAST cl_abap_structdescr( lo_table_line_descr ).
          DATA(lt_table_line_struc_components) = lo_table_line_struc_descr->components.

          APPEND LINES OF /gicom/cl_util_ddic=>describe_components(
            EXPORTING
              is_data      = <lv_component>
              it_component = lt_table_line_struc_components
              iv_parent_id = cv_index
            CHANGING
              cv_index     = cv_index
          ) TO rt_elements.

        ELSE.

          DATA(lo_table_line_elem_descr) = CAST cl_abap_elemdescr( lo_table_line_descr ).
          cv_index = cv_index + 1.

          APPEND VALUE #(
            id = cv_index
            name = lo_table_line_elem_descr->get_relative_name( )
            type = /gicom/cl_util_ddic=>get_type(
              io_element_descriptor = lo_table_line_elem_descr
              iv_component = <lv_component>
            )
            length = /gicom/cl_util_ddic=>get_length( lo_table_line_elem_descr )
            decimals = lo_table_line_elem_descr->decimals
            parent_id = cv_index - 1
          ) TO rt_elements.
        ENDIF.

      ELSEIF lo_component_descr IS INSTANCE OF cl_abap_structdescr.

        cv_index = cv_index + 1.
        APPEND VALUE #(
          id = cv_index
          name = <ls_struct_component>-name
          type = '_S'
          length = 0
          decimals = 0
          parent_id = iv_parent_id
        ) TO rt_elements.

        DATA(lo_comp_struc_descr) = CAST cl_abap_structdescr( lo_component_descr ).
        DATA(lt_comp_struc_components) = lo_comp_struc_descr->components.

        APPEND LINES OF /gicom/cl_util_ddic=>describe_components(
          EXPORTING
            is_data      = <lv_component>
            it_component = lt_comp_struc_components
            iv_parent_id = cv_index
          CHANGING
            cv_index     = cv_index
        ) TO rt_elements.

      ELSE. "element

        DATA(lo_comp_elem_descr) = CAST cl_abap_elemdescr( lo_component_descr ).
        cv_index = cv_index + 1.

        APPEND VALUE #(
          id = cv_index
          name = <ls_struct_component>-name
          type = /gicom/cl_util_ddic=>get_type(
            io_element_descriptor = lo_comp_elem_descr
            iv_component = <lv_component>
          )
          length = /gicom/cl_util_ddic=>get_length( lo_comp_elem_descr )
          decimals = lo_comp_elem_descr->decimals
          parent_id = iv_parent_id
        ) TO rt_elements.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.


  METHOD get_type.
    CASE io_element_descriptor->type_kind.
      WHEN cl_abap_typedescr=>typekind_int OR
           cl_abap_typedescr=>typekind_int1 OR
           cl_abap_typedescr=>typekind_int2 OR
           cl_abap_typedescr=>typekind_int8.
        rv_type = '_I'.

      WHEN cl_abap_typedescr=>typekind_char.
        rv_type = '_C'.
        TRY.
            IF /gicom/cl_util_ddic=>is_boolean( iv_component ).
              rv_type = '_B'.
            ENDIF.
          CATCH /gicom/cx_internal_error.
            "I guess we do not have a boolean then...
        ENDTRY.

      WHEN cl_abap_typedescr=>typekind_clike OR
           cl_abap_typedescr=>typekind_csequence OR
           cl_abap_typedescr=>typekind_string OR
           cl_abap_typedescr=>typekind_xstring.
        rv_type = '_C'.

      WHEN cl_abap_typedescr=>typekind_num OR
           cl_abap_typedescr=>typekind_numeric OR
           cl_abap_typedescr=>typekind_decfloat OR
           cl_abap_typedescr=>typekind_decfloat16 OR
           cl_abap_typedescr=>typekind_decfloat34 OR
           cl_abap_typedescr=>typekind_float OR
           cl_abap_typedescr=>typekind_packed.
        rv_type = '_N'.

        TRY.
            IF /gicom/cl_util_ddic=>is_timestamp( iv_component ).
              rv_type = '_t'.
            ENDIF.
          CATCH /gicom/cx_internal_error.
            "No timestamp to be found..
        ENDTRY.

      WHEN OTHERS.
        rv_type = io_element_descriptor->type_kind.
    ENDCASE.
  ENDMETHOD.


  METHOD get_length.
    CASE io_element_descriptor->type_kind.
*      WHEN cl_abap_typedescr=>typekind_packed.
*
*        DATA(lv_length) = ( io_element_descriptor->length - '0.5' ) * 2.
*        rv_length = round( val = lv_length dec = 0 ).

      WHEN OTHERS.
        rv_length = io_element_descriptor->output_length.
    ENDCASE.
  ENDMETHOD.


  METHOD is_timestamp.
    /gicom/cl_util_ddic=>get_domain_name(
        EXPORTING
            iv_field = iv_component
        IMPORTING
            ev_type_name = DATA(lv_type_name)
        RECEIVING
            rv_type = DATA(lv_domain_name)
    ).
    CASE lv_domain_name.
      WHEN 'TZNTSTMPS'.
        rv_result = abap_true.
      WHEN OTHERS.
        CASE lv_type_name.
          WHEN '/GICOM/TIMESTMPS'.
            rv_result = abap_true.
          WHEN OTHERS.
            rv_result = abap_false.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.


  METHOD is_boolean.
***********************************************************************************************************************
*** Checks whether the given parameter is an abap_boolean
***********************************************************************************************************************

    /gicom/cl_util_ddic=>get_domain_name(
        EXPORTING
            iv_field = iv_param
        IMPORTING
            ev_type_name = DATA(lv_type_name)
        CHANGING
            co_typedescr = co_typedescr
        RECEIVING
            rv_type = DATA(lv_domain_name)
    ).

    CASE lv_domain_name.
      WHEN '/GICOM/ABAP_BOOL'.
        rv_result = abap_true.
      WHEN 'XFELD'.
        rv_result = abap_true.
      WHEN OTHERS.
        CASE lv_type_name.
          WHEN 'ABAP_BOOL'.
            rv_result = abap_true.
          WHEN OTHERS.
            rv_result = abap_false.
        ENDCASE.
    ENDCASE.

  ENDMETHOD.


  METHOD conv_input_by_output_format.

    DATA(lv_conv_exit) = /gicom/cl_util_ddic=>get_conversion_exit( ev_output ).

    IF lv_conv_exit EQ 'ALPHA' OR lv_conv_exit EQ 'CUNIT' OR lv_conv_exit EQ 'MATN1'.
      /gicom/cl_util_ddic=>conv_exit_rem_to_loc(
        EXPORTING
          iv_input     = iv_input
          iv_conv_exit = lv_conv_exit
        IMPORTING
          ev_output    = ev_output ).
    ELSE.
      ev_output = iv_input.
    ENDIF.

  ENDMETHOD.

  METHOD update_domain_val_texts.

    IF iv_langu EQ 'E'.

      "Process only when logon language different than English
      "raise invalid arguments exception
      RAISE EXCEPTION NEW /gicom/cx_invalid_arguments( ).

    ENDIF.

    TRY.
        DATA(ls_dd07v) = ct_dd07v_tab[ ddtext = '' ].
      CATCH cx_sy_itab_line_not_found.
        RETURN.
    ENDTRY.

    DATA: lt_values TYPE dd07v_tab,
          lv_rc     TYPE syst_subrc.

    IF ls_dd07v IS NOT INITIAL.
      TRY.
          /gicom/cl_sap_ddic=>dd_domvalues_get(
            EXPORTING
              iv_domname        = iv_domname
              iv_text           = 'X'
              iv_langu          = 'E'
              iv_bypass_buffer  = space
            IMPORTING
              ev_rc             = lv_rc
            CHANGING
              ct_dd07v_tab      = lt_values ).
        CATCH /gicom/cx_sap_call_error.
          " no exception, just default in error case
          CLEAR lv_rc.
      ENDTRY.

      LOOP AT ct_dd07v_tab ASSIGNING FIELD-SYMBOL(<ls_dd07v_tab>) WHERE ddtext IS INITIAL.
        TRY.
            <ls_dd07v_tab>-ddtext = lt_values[ valpos = <ls_dd07v_tab>-valpos ]-ddtext.
          CATCH cx_sy_itab_line_not_found.
            CONTINUE.
        ENDTRY.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
