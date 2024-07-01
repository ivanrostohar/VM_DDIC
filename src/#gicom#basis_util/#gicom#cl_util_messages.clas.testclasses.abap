CLASS ltc_bapi_from_exception_chain DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      full_exception_chain         FOR TESTING RAISING cx_static_check,
      exception_is_not_bound       FOR TESTING RAISING cx_static_check,
      t100_dyn_with_msgty          FOR TESTING RAISING cx_static_check,
      t100_msg_with_msgid_corr     FOR TESTING RAISING cx_static_check,
      t100_msg_with_msgid_false    FOR TESTING RAISING cx_static_check,
      t100_dyn_no_msgty_no_msgid   FOR TESTING RAISING cx_static_check,
      t100_dyn_no_msgty_with_msgid FOR TESTING RAISING cx_static_check,
      not_t100_no_source_pos       FOR TESTING RAISING cx_static_check,
      not_t100_with_source_pos1    FOR TESTING RAISING cx_static_check,
      not_t100_with_source_pos2    FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_bapi_from_exception_chain IMPLEMENTATION.

  METHOD full_exception_chain.
    "given
    "not_t100_with_source_pos - hard coded line 42
    TRY.
        NEW lcl_test_helper_source_pos( )->raise_exception_on_line42( ).

      CATCH lcx_not_t100_with_source_pos INTO DATA(lx_not_t100_with_source_pos).
    ENDTRY.

    "not_t100_with_source_pos - source hack
    DATA(lx_not_t100_with_source_hack) = NEW lcx_not_t100_with_source_hack(
      io_previous = lx_not_t100_with_source_pos
    ).

    "not_t100_no_source_pos
    DATA(lx_not_t100_no_source_pos) = NEW lcx_not_t100_no_source_pos(
      io_previous = lx_not_t100_with_source_hack
    ).

    "t100_dyn_no_msgty_with_msgid
    DATA(lx_dyn_no_msgty_with_msgid) = NEW lcx_dyn_msg(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
      io_previous  = lx_not_t100_no_source_pos
    ).

    "t100_dyn_no_msgty_no_msgid
    DATA(lx_t100_dyn_no_msgty_no_msgid) = NEW lcx_dyn_msg(
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
      io_previous  = lx_dyn_no_msgty_with_msgid
    ).

    "t100_msg_with_msgid_false
    DATA(lx_t100_msg_with_msgid_false) = NEW lcx_msg_wrong_parameter(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
      io_previous  = lx_t100_dyn_no_msgty_no_msgid
    ).

    "t100_msg_with_msgid_corr
    DATA(lx_t100_msg_with_msgid_corr) = NEW lcx_msg(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
      io_previous  = lx_t100_msg_with_msgid_false
    ).

    "t100_dyn_with_msgty
    DATA(lx_t100_dyn_with_msgty) = NEW lcx_dyn_msg(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_msgty     = 'E'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
      io_previous  = lx_t100_msg_with_msgid_corr
    ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_t100_dyn_with_msgty ).

    "then
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      "t100_dyn_with_msgty
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
        message_v1 = '1'
        message_v2 = '2'
        message_v3 = '3'
        message_v4 = '4'
      )
      "t100_msg_with_msgid_corr
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
        message_v1 = '1'
        message_v2 = '2'
        message_v3 = '3'
        message_v4 = '4'
      )
      "t100_msg_with_msgid_false
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
        message_v1 = '1'
        message_v2 = '2'
        message_v3 = '3'
        message_v4 = '4'
      )
      "t100_dyn_no_msgty_no_msgid
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_DYN_MSG'
        message_v2 = 'RS_AUNIT_SBOX_CLASS_TEST_INT'
        message_v3 = ''
        message_v4 = '                                                0'
      )
      "t100_dyn_no_msgty_with_msgid
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
      )
      "not_t100_no_source_pos
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_NOT_T100_NO_SOURCE_POS'
        message_v2 = 'RS_AUNIT_SBOX_CLASS_TEST_INT'
        message_v3 = ''
        message_v4 = '                                                0'
      )
      "not_t100_with_source_pos - source hack
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_NOT_T100_WITH_SOURCE_HACK'
        message_v2 = '/GICOM/CL_UTIL_MESSAGES=======CI'
        message_v3 = '/GICOM/CL_UTIL_MESSAGES=======CCAU'
        message_v4 = '                                               16'
      )
      "not_t100_with_source_pos - hard coded line 42
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_NOT_T100_WITH_SOURCE_POS'
        message_v2 = '/GICOM/CL_UTIL_MESSAGES=======CP'
        message_v3 = '/GICOM/CL_UTIL_MESSAGES=======CCIMP'
        message_v4 = '                                               42'
      )

    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD exception_is_not_bound.
    "given

    "when
    DATA(lt_messages) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( VALUE #( ) ).

    "then
    cl_abap_unit_assert=>assert_initial(
      act = lt_messages
    ).
  ENDMETHOD.

  METHOD t100_dyn_with_msgty.
    "given
    DATA(lx_exception) = NEW lcx_dyn_msg(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_msgty     = 'E'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
    ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_exception ).
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    "then
    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
        message_v1 = '1'
        message_v2 = '2'
        message_v3 = '3'
        message_v4 = '4'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD t100_msg_with_msgid_corr.
    "given
    DATA(lx_exception) = NEW lcx_msg(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
    ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_exception ).
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    "then
    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
        message_v1 = '1'
        message_v2 = '2'
        message_v3 = '3'
        message_v4 = '4'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD t100_msg_with_msgid_false.
    "given
    DATA(lx_exception) = NEW lcx_msg_wrong_parameter(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
    ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_exception ).
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    "then
    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
        message_v1 = '1'
        message_v2 = '2'
        message_v3 = '3'
        message_v4 = '4'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD t100_dyn_no_msgty_no_msgid.
    DATA(lx_exception) = NEW lcx_dyn_msg(
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
    ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_exception ).
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    "then
    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_DYN_MSG'
        message_v2 = 'RS_AUNIT_SBOX_CLASS_TEST_INT'
        message_v3 = ''
        message_v4 = '                                                0'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD t100_dyn_no_msgty_with_msgid.
    DATA(lx_exception) = NEW lcx_dyn_msg(
      iv_msgid     = 'MESSAGE_CLASS'
      iv_msgno     = '001'
      iv_variable1 = '1'
      iv_variable2 = '2'
      iv_variable3 = '3'
      iv_variable4 = '4'
    ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_exception ).
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    "then
    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = 'MESSAGE_CLASS'
        number     = '001'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD not_t100_no_source_pos.
    "given
    DATA(lx_not_t100_no_source_pos) = NEW lcx_not_t100_no_source_pos( ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_not_t100_no_source_pos ).

    "then
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_NOT_T100_NO_SOURCE_POS'
        message_v2 = 'RS_AUNIT_SBOX_CLASS_TEST_INT'
        message_v3 = ''
        message_v4 = '                                                0'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD not_t100_with_source_pos1.
    "given
    DATA(lx_not_t100_with_source_hack) = NEW lcx_not_t100_with_source_hack( ).

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_not_t100_with_source_hack ).

    "then
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_NOT_T100_WITH_SOURCE_HACK'
        message_v2 = '/GICOM/CL_UTIL_MESSAGES=======CI'
        message_v3 = '/GICOM/CL_UTIL_MESSAGES=======CCAU'
        message_v4 = '                                               16'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

  METHOD not_t100_with_source_pos2.
    "given
    TRY.
        NEW lcl_test_helper_source_pos( )->raise_exception_on_line42( ).

      CATCH lcx_not_t100_with_source_pos INTO DATA(lx_not_t100_with_source_pos).
    ENDTRY.

    "when
    DATA(lt_messages_act_full) = /gicom/cl_util_messages=>get_bapi_from_exception_chain( lx_not_t100_with_source_pos ).

    "then
    DATA(lt_messages_act) = CORRESPONDING /gicom/bapiret2_tt( lt_messages_act_full EXCEPT message system log_msg_no ).

    DATA(lt_messages_exp) = VALUE /gicom/bapiret2_tt(
      (
        type       = 'E'
        id         = '/GICOM/MSG_FOUNDAT'
        number     = '033'
        message_v1 = 'LCX_NOT_T100_WITH_SOURCE_POS'
        message_v2 = '/GICOM/CL_UTIL_MESSAGES=======CP'
        message_v3 = '/GICOM/CL_UTIL_MESSAGES=======CCIMP'
        message_v4 = '                                               42'
      )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_messages_exp
      act = lt_messages_act
    ).
  ENDMETHOD.

ENDCLASS.
