CLASS /gicom/cl_aunit_test DEFINITION FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT
  ABSTRACT
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS:

      BEGIN OF cs_severity,
        low    TYPE int1 VALUE 0,
        medium TYPE int1 VALUE 1,
        high   TYPE int1 VALUE 2,
      END OF cs_severity.

    TYPES:

      gtt_components TYPE STANDARD TABLE OF abap_compname WITH EMPTY KEY.

    CLASS-METHODS:

      global_setup,

      global_teardown,

      "! <p class="shorttext synchronized" lang="en">Version-safe "skip" implementation.</p>
      "!
      "! The method {@link cl_abap_unit_assert.METH:skip} is only available from ABAP 7.53 onwards. This method
      "! will attempt to call the method and fall back to the deprecated {@link cl_abap_unit_assert.METH:abort} method
      "! if the method is not available.
      "!
      "! See {@link cl_abap_unit_assert.METH:skip} for details.
      "!
      "! @parameter iv_message | <p class="shorttext synchronized" lang="en">The message</p>
      skip
        IMPORTING
          iv_message TYPE string,

      "! <p class="shorttext synchronized" lang="en">Version-safe failure a test without quitting it.</p>
      "!
      "! While it is possible to prevent a call to {@link cl_abap_unit_assert.METH:fail} to raise an exception,
      "! effectively stopping the test case, the constant used in {@link if_abap_unit_assert} might not be available
      "! on systems with ABAP version < 7.53.
      "!
      "! This method attempts to identify the correct constant to use by first probing for <strong>if_abap_unit_assert=>quit-no</strong> and
      "! then using <strong>if_aunit_constants=>quit-no</strong> if this fails.
      "!
      "! @parameter iv_message | <p class="shorttext synchronized" lang="en">The message</p>
      fail_without_quitting
        IMPORTING
          iv_message TYPE string,

      "! <p class="shorttext synchronized" lang="en">Asserts that the given exception is of the expected type.</p>
      "!
      "! This will internally check, if the class of the actual exception object is either the same or a sub-class of
      "! the class of the expected exception object.
      "!
      "! Note: In the message, the placeholder '&ACT' can be used to display the class name of the actual exception and
      "! '&EXP' for the class name of the expected class.
      "!
      "! @parameter act | <p class="shorttext synchronized" lang="en">The actual class</p>
      "! @parameter exp | <p class="shorttext synchronized" lang="en">The expected class</p>
      "! @parameter msg | <p class="shorttext synchronized" lang="en">The message</p>
      assert_exception_is_type_of
        IMPORTING
          act TYPE REF TO cx_root
          exp TYPE REF TO cx_root
          msg TYPE string DEFAULT `Wrong exception was thrown: &ACT`,

      "!
      "! <p class="shorttext synchronized" lang="en">Assert equality of two tables.</p>
      "!
      "! This method is based on the method {@link cl_abap_unit_assert.METH:assert_equals} But adds the ability to ignore certain fields.
      "!
      "! @parameter act                  | Data object with current value
      "! @parameter exp                  | Data object with expected type
      "! @parameter ignore_fields        | Ignore these fields
      "! @parameter ignore_Hash_Sequence | Ignore sequence in hash tables
      "! @parameter tol                  | Tolerance range (for directly passed floating numbers)
      "! @parameter msg                  | Description
      "! @parameter level                | Severity (see IF_ABAP_UNIT_CONSTANT=>severity)
      "! @parameter quit                 | Alter control flow/ quit test (see IF_ABAP_UNIT_CONSTANT=>quit)
      "! @parameter assertion_Failed     | Condition was not met (and QUIT = NO)
      assert_table_equals
        IMPORTING
          VALUE(act)              TYPE ANY TABLE
          VALUE(exp)              TYPE ANY TABLE
          ignore_fields           TYPE gtt_components
          ignore_hash_sequence    TYPE abap_bool DEFAULT abap_false
          tol                     TYPE f OPTIONAL
          msg                     TYPE csequence OPTIONAL
          level                   TYPE int1 DEFAULT cs_severity-medium
          quit                    TYPE int1 OPTIONAL
        RETURNING
          VALUE(assertion_failed) TYPE abap_bool
        RAISING
          /gicom/cx_illegal_arguments,

      get_quit_no
        RETURNING
          VALUE(rv_value) TYPE int1,

      get_quit_test
        RETURNING
          VALUE(rv_value) TYPE int1.

  PRIVATE SECTION.

    CLASS-METHODS:

      validate_table_types
        IMPORTING
          io_table_desc_act TYPE REF TO cl_abap_tabledescr
          io_table_desc_exp TYPE REF TO cl_abap_tabledescr
        RAISING
          /gicom/cx_illegal_arguments,

      remove_ignored_fields_tabl_des
        IMPORTING
          io_complete_table_desc TYPE REF TO cl_abap_tabledescr
          it_ignore_fields       TYPE gtt_components
        RETURNING
          VALUE(ro_table_desc)   TYPE REF TO cl_abap_tabledescr
        RAISING
          /gicom/cx_illegal_arguments.

    METHODS:

      setup RAISING cx_static_check,

      teardown RAISING cx_static_check.

ENDCLASS.



CLASS /GICOM/CL_AUNIT_TEST IMPLEMENTATION.


  METHOD setup.
    /gicom/cl_aunit_test=>global_setup( ).
  ENDMETHOD.


  METHOD global_teardown.
    " Placeholder
  ENDMETHOD.


  METHOD assert_table_equals.

    DATA(lv_quit) = quit.

    IF quit IS NOT SUPPLIED.
      lv_quit = /gicom/cl_aunit_test=>get_quit_test( ).
    ENDIF.

    DATA(lo_complete_table_descr_act) = CAST cl_abap_tabledescr( cl_abap_tabledescr=>describe_by_data( act ) ).
    DATA(lo_complete_table_descr_exp) = CAST cl_abap_tabledescr( cl_abap_tabledescr=>describe_by_data( exp ) ).

    /gicom/cl_aunit_test=>validate_table_types(
      EXPORTING
        io_table_desc_act = lo_complete_table_descr_act
        io_table_desc_exp = lo_complete_table_descr_exp
    ).

    DATA(lo_table_descr) = /gicom/cl_aunit_test=>remove_ignored_fields_tabl_des(
       io_complete_table_desc = lo_complete_table_descr_act
       it_ignore_fields       = ignore_fields
     ).

    DATA lr_act TYPE REF TO data.
    DATA lr_exp TYPE REF TO data.

    CREATE DATA lr_act TYPE HANDLE lo_table_descr.
    CREATE DATA lr_exp TYPE HANDLE lo_table_descr.

    FIELD-SYMBOLS <lt_act> TYPE ANY TABLE.
    FIELD-SYMBOLS <lt_exp> TYPE ANY TABLE.

    ASSIGN lr_act->* TO <lt_act>.
    ASSIGN lr_exp->* TO <lt_exp>.

    <lt_act> = CORRESPONDING #( act ).
    <lt_exp> = CORRESPONDING #( exp ).

    assertion_failed = cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = <lt_act>
        exp                  = <lt_exp>
        ignore_hash_sequence = ignore_hash_sequence
        tol                  = tol
        msg                  = msg
        level                = level
        quit                 = lv_quit
    ).

  ENDMETHOD.


  METHOD remove_ignored_fields_tabl_des.

    DATA(lo_complete_struct_descr) = CAST cl_abap_structdescr( io_complete_table_desc->get_table_line_type( ) ).
    DATA(lt_components) = lo_complete_struct_descr->components[].

    LOOP AT it_ignore_fields INTO DATA(lv_ignore).
      DELETE lt_components WHERE name = to_upper( lv_ignore ).

      IF sy-subrc <> 0.
        RAISE EXCEPTION NEW /gicom/cx_illegal_arguments( ).
      ENDIF.
    ENDLOOP.

    DATA(lo_struct_descr) = cl_abap_structdescr=>get( VALUE #(
      FOR ls_components IN lt_components (
        name = ls_components-name
        type = lo_complete_struct_descr->get_component_type( ls_components-name )
      )
    ) ).

    ro_table_desc = cl_abap_tabledescr=>get( p_line_type = lo_struct_descr ).

  ENDMETHOD.


  METHOD validate_table_types.

    DATA(lt_table_line_type_act) = io_table_desc_act->get_table_line_type( ).
    DATA(lt_table_line_type_exp) = io_table_desc_exp->get_table_line_type( ).

    " Only structured tables are allowed
    IF lt_table_line_type_act IS NOT INSTANCE OF cl_abap_structdescr OR
       lt_table_line_type_exp IS NOT INSTANCE OF cl_abap_structdescr.
       RAISE EXCEPTION NEW /gicom/cx_illegal_arguments( ).
    ENDIF.

    DATA(lt_components_act) = CAST cl_abap_structdescr( lt_table_line_type_act )->get_components( ).
    DATA(lt_components_exp) = CAST cl_abap_structdescr( lt_table_line_type_act )->get_components( ).

    " Check that all fields in the exp table also exist in the act table
    LOOP AT lt_components_exp INTO DATA(ls_component_exp).
      ASSERT line_exists( lt_components_act[ name = ls_component_exp-name ] ).
    ENDLOOP.

  ENDMETHOD.


  METHOD get_quit_test.
    FIELD-SYMBOLS <lv_value> TYPE int1.

    " Same as the other method
    ASSIGN ('IF_ABAP_UNIT_CONSTANT=>QUIT-TEST') TO <lv_value>.

    IF <lv_value> IS NOT ASSIGNED.
      ASSIGN ('IF_AUNIT_CONSTANTS=>QUIT-TEST') TO <lv_value>.
    ENDIF.

    IF <lv_value> IS NOT ASSIGNED.
      /gicom/cl_aunit_test=>skip( `[INTERNAL] Failed to identify quit constant` ).
    ENDIF.

    rv_value = <lv_value>.
  ENDMETHOD.


  METHOD assert_exception_is_type_of.
    DATA(lo_descriptor_exp) = CAST cl_abap_classdescr( cl_abap_classdescr=>describe_by_object_ref( exp ) ).

    DATA(lv_message) = msg.

    DATA(lv_result) = lo_descriptor_exp->applies_to( act ).

    IF lv_result <> abap_true.
      IF lv_message CS '&ACT'.
        lv_message = replace( val = lv_message sub = '&ACT' with = cl_abap_classdescr=>describe_by_object_ref( act )->get_relative_name( ) ).
      ENDIF.

      IF lv_message CS '&EXP'.
        lv_message = replace( val = lv_message sub = '&EXP' with = cl_abap_classdescr=>describe_by_object_ref( exp )->get_relative_name( ) ).
      ENDIF.

      cl_abap_unit_assert=>fail( lv_message ).
    ENDIF.
  ENDMETHOD.


  METHOD fail_without_quitting.
    cl_abap_unit_assert=>fail(
      msg  = iv_message
      quit = /gicom/cl_aunit_test=>get_quit_no( )
    ).
  ENDMETHOD.


  METHOD get_quit_no.
    FIELD-SYMBOLS <lv_value> TYPE int1.

    " Try to assign the new constant
    ASSIGN ('IF_ABAP_UNIT_CONSTANT=>QUIT-NO') TO <lv_value>.

    " If we cannot find the new constant, we are probably on an old system.
    " Try again with the old value.
    IF <lv_value> IS NOT ASSIGNED.
      ASSIGN ('IF_AUNIT_CONSTANTS=>QUIT-NO') TO <lv_value>.
    ENDIF.

    " If this still did not work, we have some problems
    IF <lv_value> IS NOT ASSIGNED.
      /gicom/cl_aunit_test=>skip( `[INTERNAL] Failed to identify quit constant` ).
    ENDIF.

    rv_value = <lv_value>.
  ENDMETHOD.


  METHOD global_setup.
    " TODO: Implement some check pls (2021-01-26)
    IF 1 = 2.
      /gicom/cl_aunit_test=>skip( `Test disabled due to system config` ).
    ENDIF.
  ENDMETHOD.


  METHOD skip.
    CONSTANTS cv_method TYPE seomtdname VALUE 'SKIP'.

    TRY.
        " Try to call the new method dynamically
        CALL METHOD cl_abap_unit_assert=>(cv_method)
          EXPORTING
            msg = iv_message.

      CATCH cx_sy_dyn_call_illegal_method.
        " If this fails, we call the old, deprecated "abort" method
        cl_abap_unit_assert=>abort( iv_message ).

    ENDTRY.
  ENDMETHOD.


  METHOD teardown.
    /gicom/cl_aunit_test=>global_teardown( ).
  ENDMETHOD.
ENDCLASS.
