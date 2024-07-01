*"* use this source file for your ABAP unit test classes

" Don't ask
CLASS ltc_lazy_integration_tests DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PUBLIC SECTION.

    METHODS:

      get_set_reset_username FOR TESTING,

      get_given_optional_username FOR TESTING,

      get_set_reset_language FOR TESTING,

      get_set_reset_date FOR TESTING,

      get_given_optional_date FOR TESTING,

      get_time_stamp FOR TESTING,

      get_time_stamp_long FOR TESTING,

      get_set_reset_time FOR TESTING,

      get_set_reset_current_task FOR TESTING,

      get_set_reset_current_message FOR TESTING,

      get_set_reset_process_guid FOR TESTING,

      get_year_month_day FOR TESTING.

  PRIVATE SECTION.

    METHODS:
      setup RAISING cx_static_check.

ENDCLASS.


CLASS ltc_lazy_integration_tests IMPLEMENTATION.

  METHOD setup.
    /gicom/cl_system=>reset_username( ).
    /gicom/cl_system=>reset_time( ).
    /gicom/cl_system=>reset_date( ).
  ENDMETHOD.

  METHOD get_set_reset_username.
    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_username( )
      exp = sy-uname "#EC SY_FIELD
    ).

    /gicom/cl_system=>set_username( '%%DUMMY%%' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_username( )
      exp = '%%DUMMY%%'
    ).

    /gicom/cl_system=>reset_username( ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_username( )
      exp = sy-uname "#EC SY_FIELD
    ).
  ENDMETHOD.

  METHOD get_given_optional_username.
    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_username( )
      exp = sy-uname "#EC SY_FIELD
    ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_username( iv_username = '%DUMMY%USER%' )
      exp = '%DUMMY%USER%'
    ).
  ENDMETHOD.

  METHOD get_set_reset_language.
    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_language( )
      exp = sy-langu
    ).

    /gicom/cl_system=>set_language( 'D' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_language( )
      exp = 'D'
    ).

    " Special case: Empty value also works
    /gicom/cl_system=>set_language( VALUE #( ) ).

    cl_abap_unit_assert=>assert_initial( /gicom/cl_system=>get_language( ) ).

    /gicom/cl_system=>reset_language( ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_language( )
      exp = sy-langu
    ).
  ENDMETHOD.


  METHOD get_set_reset_date.
    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_date( )
      exp = sy-datum "#EC SY_FIELD
    ).

    /gicom/cl_system=>set_date( '19001231' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_date( )
      exp = '19001231'
    ).

    /gicom/cl_system=>reset_date( ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_date( )
      exp = sy-datum "#EC SY_FIELD
    ).
  ENDMETHOD.


  METHOD get_given_optional_date.
    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_date( )
      exp = sy-datum "#EC SY_FIELD
    ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_date( '19011231' )
      exp = '19011231'
    ).
  ENDMETHOD.

  METHOD get_time_stamp.
    " given
    DATA lv_exp_date TYPE syst_datum.
    DATA lv_exp_time TYPE syst_uzeit.
    " freeze current time to compare time stamp
    lv_exp_date = /gicom/cl_system=>get_date( ).
    lv_exp_time = /gicom/cl_system=>get_time( ).
    /gicom/cl_system=>set_date( lv_exp_date ).
    /gicom/cl_system=>set_time( lv_exp_time ).

    " when
    DATA lv_act_time_stamp TYPE string.
    lv_act_time_stamp = /gicom/cl_system=>get_time_stamp( ).

    " then

    " year
    cl_abap_unit_assert=>assert_equals(
      act = lv_exp_date(4)
      exp = substring( val = lv_act_time_stamp len = 4 )
    ).
    " month
    cl_abap_unit_assert=>assert_equals(
      act = lv_exp_date+4(2)
      exp = substring( val = lv_act_time_stamp off = 4 len = 2 )
    ).
    " day
    cl_abap_unit_assert=>assert_equals(
      act = lv_exp_date+6(2)
      exp = substring( val = lv_act_time_stamp off = 6 len = 2 )
    ).

    " hour
    cl_abap_unit_assert=>assert_equals(
      act = lv_exp_time(2)
      exp = substring( val = lv_act_time_stamp off = 8 len = 2 )
    ).
    " minute
    cl_abap_unit_assert=>assert_equals(
      act = lv_exp_time+2(2)
      exp = substring( val = lv_act_time_stamp off = 10 len = 2 )
    ).
    " second
    cl_abap_unit_assert=>assert_equals(
      act = lv_exp_time+4(2)
      exp = substring( val = lv_act_time_stamp off = 12 len = 2 )
    ).
  ENDMETHOD.

  METHOD get_time_stamp_long.
    " given
    DATA lv_exp_date TYPE syst_datum.
    DATA lv_exp_time TYPE syst_uzeit.
    " freeze current time to compare time stamp
    lv_exp_date = /gicom/cl_system=>get_date( ).
    lv_exp_time = /gicom/cl_system=>get_time( ).
    /gicom/cl_system=>set_date( lv_exp_date ).
    /gicom/cl_system=>set_time( lv_exp_time ).

    " when
    DATA lv_act_time_stamp_long TYPE timestampl.
    lv_act_time_stamp_long = /gicom/cl_system=>get_time_stamp_long( ).

    " then
    cl_abap_unit_assert=>assert_equals(
      act = |{ lv_act_time_stamp_long }|
      exp = |{ lv_exp_date }{ lv_exp_time }.0000000|
    ).
  ENDMETHOD.


  METHOD get_set_reset_time.
    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_time( )
      exp = sy-uzeit "#EC SY_FIELD
    ).

    " Invalid value but the only proper way to check that it was overwritten
    /gicom/cl_system=>set_time( '999999' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_time( )
      exp = '999999'
    ).

    /gicom/cl_system=>reset_time( ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_time( )
      exp = sy-uzeit "#EC SY_FIELD
    ).
  ENDMETHOD.


  METHOD get_set_reset_current_task.
    cl_abap_unit_assert=>assert_initial( /gicom/cl_system=>get_current_task( ) ).

    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_task( ) ).
    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_consumer( ) ).

    /gicom/cl_system=>set_current_task( '%%DUMMY%%' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_current_task( )
      exp = '%%DUMMY%%'
    ).

    cl_abap_unit_assert=>assert_true( /gicom/cl_system=>is_running_in_task( ) ).
    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_consumer( ) ).

    /gicom/cl_system=>reset_current_task( ).

    cl_abap_unit_assert=>assert_initial( /gicom/cl_system=>get_current_task( ) ).

    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_task( ) ).
    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_consumer( ) ).
  ENDMETHOD.


  METHOD get_set_reset_current_message.
    cl_abap_unit_assert=>assert_initial( /gicom/cl_system=>get_current_message( ) ).

    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_task( ) ).
    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_consumer( ) ).

    /gicom/cl_system=>set_current_message( '%%DUMMY%%' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_current_message( )
      exp = '%%DUMMY%%'
    ).

    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_task( ) ).
    cl_abap_unit_assert=>assert_true( /gicom/cl_system=>is_running_in_consumer( ) ).

    /gicom/cl_system=>reset_current_message( ).

    cl_abap_unit_assert=>assert_initial( /gicom/cl_system=>get_current_message( ) ).

    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_task( ) ).
    cl_abap_unit_assert=>assert_false( /gicom/cl_system=>is_running_in_consumer( ) ).
  ENDMETHOD.


  METHOD get_set_reset_process_guid.
    cl_abap_unit_assert=>assert_initial( /gicom/cl_system=>get_current_process_guid( ) ).

    " Invalid value but the only proper way to check that it was overwritten
    /gicom/cl_system=>set_current_process_guid( '%%DUMMY%%' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_current_process_guid( )
      exp = '%%DUMMY%%'
    ).

    /gicom/cl_system=>reset_current_process_guid( ).

    cl_abap_unit_assert=>assert_initial( /gicom/cl_system=>get_current_process_guid( ) ).
  ENDMETHOD.


  METHOD get_year_month_day.
    /gicom/cl_system=>set_date( '13370609' ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_year( )
      exp = '1337'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_month( )
      exp = '06'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = /gicom/cl_system=>get_day( )
      exp = '09'
    ).

    /gicom/cl_system=>reset_date( ).
  ENDMETHOD.

ENDCLASS.
