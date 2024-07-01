*"* use this source file for your ABAP unit test classes

INTERFACE lif_aunit_friend.
ENDINTERFACE.

CLASS /gicom/cl_aunit_test DEFINITION LOCAL FRIENDS lif_aunit_friend.

CLASS ltcl_assert_table_equals DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  INHERITING FROM /gicom/cl_aunit_test.

  PUBLIC SECTION.

    INTERFACES

      lif_aunit_friend.

  PRIVATE SECTION.

    METHODS:

      lazy_test_success     FOR TESTING RAISING /gicom/cx_invalid_arguments,
      lazy_test_fail        FOR TESTING RAISING /gicom/cx_invalid_arguments,
      all_fields_ignored    FOR TESTING RAISING /gicom/cx_invalid_arguments,
      no_ignored_fields     FOR TESTING RAISING /gicom/cx_invalid_arguments,
      unknown_ignored_field FOR TESTING,
      row_type_with_include FOR TESTING,
      row_type_non_struct   FOR TESTING.

ENDCLASS.


CLASS ltcl_assert_table_equals IMPLEMENTATION.

  METHOD lazy_test_success.

    " given
    DATA(lt_messages_act) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'

        message    = 'Hallo'
        system     = 'TEST_SYS'

      )
    ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'

        message    = 'Bonjour'
        system     = 'OTHER_SYS'
      )
    ).

    DATA(lt_ignored_fields) = VALUE /gicom/cl_aunit_test=>gtt_components(
      ( 'message' )
      ( 'system' )
    ).


    " when
    DATA(lv_test_failed) = /gicom/cl_aunit_test=>assert_table_equals(
      EXPORTING
        act           = lt_messages_act
        exp           = lt_messages_exp
        ignore_fields = lt_ignored_fields
    ).

    " then
    cl_abap_unit_assert=>assert_false( lv_test_failed ).

  ENDMETHOD.

  METHOD lazy_test_fail.

    " The assert statement causes the test to always fail. We cant test this unfortunately

*    " given
*    DATA(lt_messages_act) = VALUE /gicom/bapiret2_tt(
*      (
*        id         = 'MSG_UNITTEST'
*        number     = '001'
*        type       = 'W'
*        message_v1 = 'AGR1'
*        message_v2 = 'AGR2'
*        message_v3 = 'AGR3'
*        message_v4 = 'AGR4'
*
*        message    = 'Hallo'
*        system     = 'TEST_SYS'
*
*      )
*    ).
*
*    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
*      (
*        id         = 'MSG_UNITTEST'
*        number     = '001'
*        type       = 'E'
*        message_v1 = 'AGR1'
*        message_v2 = 'AGR2'
*        message_v3 = 'AGR3'
*        message_v4 = 'AGR4'
*
*        message    = 'Bonjour'
*        system     = 'OTHER_SYS'
*      )
*    ).
*
*    DATA(lt_ignored_fields) = VALUE /gicom/cl_aunit_test=>gtt_components(
*      ( 'message' )
*      ( 'system' )
*    ).
*
*
*    " when
*    TRY.
*        /gicom/cl_aunit_test=>assert_table_equals(
*          EXPORTING
*            act           = lt_messages_act
*            exp           = lt_messages_exp
*            ignore_fields = lt_ignored_fields
*        ).
*
*        cl_abap_unit_assert=>fail( ).
*
*      CATCH cx_root INTO DATA(lx_test_failed).
*        cl_abap_unit_assert=>assert_bound( lx_test_failed ).
*
*    ENDTRY.

  ENDMETHOD.

  METHOD all_fields_ignored.

    " given
    DATA(lt_messages_act) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'
        message    = 'Hallo'
        system     = 'TEST_SYS'

      )
    ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST2'
        number     = '002'
        type       = 'E'
        message_v1 = 'AGR11'
        message_v2 = 'AGR21'
        message_v3 = 'AGR31'
        message_v4 = 'AGR41'
        message    = 'Bonjour'
        system     = 'OTHER_SYS'
      )
    ).

    DATA(lt_ignored_fields) = VALUE /gicom/cl_aunit_test=>gtt_components(
      ( 'type' )
      ( 'id' )
      ( 'number' )
      ( 'message' )
      ( 'log_no' )
      ( 'log_msg_no' )
      ( 'message_v1' )
      ( 'message_v2' )
      ( 'message_v3' )
      ( 'message_v4' )
      ( 'parameter' )
      ( 'row' )
      ( 'field' )
      ( 'system' )
    ).


    " when
    TRY.
        /gicom/cl_aunit_test=>assert_table_equals(
          EXPORTING
            act           = lt_messages_act
            exp           = lt_messages_exp
            ignore_fields = lt_ignored_fields
        ).

        cl_abap_unit_assert=>fail( ).

      CATCH cx_sy_struct_attributes cx_sy_no_handler INTO DATA(lx_sy_no_handler).

        cl_abap_unit_assert=>assert_bound( lx_sy_no_handler ).

        /gicom/cl_aunit_test=>assert_exception_is_type_of(
          EXPORTING
            act = lx_sy_no_handler
            exp = NEW cx_sy_no_handler( )
        ).

        DATA(lx_sy_struct_attributes) = lx_sy_no_handler->previous.
        cl_abap_unit_assert=>assert_bound( lx_sy_struct_attributes ).

        /gicom/cl_aunit_test=>assert_exception_is_type_of(
          EXPORTING
            act = lx_sy_struct_attributes
            exp = NEW cx_sy_struct_attributes( )
        ).

    ENDTRY.

  ENDMETHOD.

  METHOD no_ignored_fields.

    " given
    DATA(lt_messages_act) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'
        message    = 'Hallo'
        system     = 'TEST_SYS'

      )
    ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'
        message    = 'Hallo'
        system     = 'TEST_SYS'
      )
    ).

    DATA(lt_ignored_fields) = VALUE /gicom/cl_aunit_test=>gtt_components( ).


    " when
    DATA(lv_test_failed) = /gicom/cl_aunit_test=>assert_table_equals(
      EXPORTING
        act           = lt_messages_act
        exp           = lt_messages_exp
        ignore_fields = lt_ignored_fields
    ).

    " then
    cl_abap_unit_assert=>assert_false( lv_test_failed ).

  ENDMETHOD.

  METHOD unknown_ignored_field.

    " given
    DATA(lt_messages_act) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'

        message    = 'Hallo'
        system     = 'TEST_SYS'

      )
    ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'

        message    = 'Bonjour'
        system     = 'OTHER_SYS'
      )
    ).

    DATA(lt_ignored_fields) = VALUE /gicom/cl_aunit_test=>gtt_components(
      ( 'message' )
      ( 'system' )
      ( 'FooBar' ) " unknown field
    ).


    " when
    TRY.
        /gicom/cl_aunit_test=>assert_table_equals(
          EXPORTING
            act           = lt_messages_act
            exp           = lt_messages_exp
            ignore_fields = lt_ignored_fields
        ).

        cl_abap_unit_assert=>fail( ).

      CATCH /gicom/cx_illegal_arguments INTO DATA(lx_unknown_field).
        cl_abap_unit_assert=>assert_bound( lx_unknown_field ).

    ENDTRY.

  ENDMETHOD.

  METHOD row_type_with_include.

    " given
    DATA(lt_messages_act) = VALUE /gicom/bapiret_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'

        message    = 'Hallo'
        system     = 'TEST_SYS'

      )
    ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret_tt(
      (
        id         = 'MSG_UNITTEST'
        number     = '001'
        type       = 'W'
        message_v1 = 'AGR1'
        message_v2 = 'AGR2'
        message_v3 = 'AGR3'
        message_v4 = 'AGR4'

        message    = 'Bonjour'
        system     = 'OTHER_SYS'
      )
    ).

    DATA(lt_ignored_fields) = VALUE /gicom/cl_aunit_test=>gtt_components(
      ( 'message' )
      ( 'system' )
    ).


    " when
    DATA(lv_test_failed) = /gicom/cl_aunit_test=>assert_table_equals(
      EXPORTING
        act           = lt_messages_act
        exp           = lt_messages_exp
        ignore_fields = lt_ignored_fields
    ).

    " then
    cl_abap_unit_assert=>assert_false( lv_test_failed ).

  ENDMETHOD.

  METHOD row_type_non_struct.

    " given
    DATA(lt_messages_act) = VALUE /gicom/distr_key_guid_tt( ( '1' ) ).

    DATA(lt_messages_exp) = VALUE /gicom/distr_key_guid_tt( ( '1' ) ).

    DATA(lt_ignored_fields) = VALUE /gicom/cl_aunit_test=>gtt_components( ).

    " when
    TRY.
        /gicom/cl_aunit_test=>assert_table_equals(
          EXPORTING
            act           = lt_messages_act
            exp           = lt_messages_exp
            ignore_fields = lt_ignored_fields
        ).

        cl_abap_unit_assert=>fail( ).

      CATCH /gicom/cx_illegal_arguments INTO DATA(lx_illegal_table_type).
        cl_abap_unit_assert=>assert_bound( lx_illegal_table_type ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
