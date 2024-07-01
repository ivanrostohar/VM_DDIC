*"* use this source file for your ABAP unit test classes
CLASS ltcl_is_15_of_month DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      _15th_of_month FOR TESTING RAISING cx_static_check,
      _1st_of_month FOR TESTING RAISING cx_static_check,
      _invalid_date FOR TESTING RAISING cx_static_check,
      _add_1_d_to_9th_of_month FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_is_15_of_month IMPLEMENTATION.

  METHOD _1st_of_month.
    cl_abap_unit_assert=>assert_false(
      EXPORTING
        act = /gicom/cl_util_time_date=>is_15th_of_month( '20200501' )
        msg = 'Expected given date to not be 15th of month'
    ).
  ENDMETHOD.


  METHOD _invalid_date.
    cl_abap_unit_assert=>assert_false(
          EXPORTING
            act = /gicom/cl_util_time_date=>is_15th_of_month( '20201599' )
            msg = 'Expected given date to not be 15th of month'
    ).
  ENDMETHOD.


  METHOD _15th_of_month.
    cl_abap_unit_assert=>assert_true(
      EXPORTING
        act = /gicom/cl_util_time_date=>is_15th_of_month( '20200515' )
        msg = 'Expected given date to be 15th of month'
    ).
  ENDMETHOD.


  METHOD _add_1_d_to_9th_of_month.
    cl_abap_unit_assert=>assert_equals(
      act   = /gicom/cl_util_time_date=>add_time_to_date( iv_add = 1 iv_type = 'D' iv_date = '20200509' )
      exp   = CONV dats( '20200510' )
      msg   = 'Expected 09 + 1 to equal 10'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_round_to_year DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      last_day_of_year FOR TESTING RAISING cx_static_check,
      first_day_of_year FOR TESTING RAISING cx_static_check,
      first_half_of_year FOR TESTING RAISING cx_static_check,
      last_half_of_year FOR TESTING RAISING cx_static_check,
      middle_of_year FOR TESTING RAISING cx_static_check,
      middle_of_leap_year FOR TESTING RAISING cx_static_check,
      start_of_world FOR TESTING RAISING cx_static_check,
      end_of_world FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_round_to_year IMPLEMENTATION.

  METHOD last_day_of_year.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '20201231'
        iv_round_mode =  /gicom/cl_util_time_date=>round_up
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '2021'
        msg = 'Expected different rounding result for end of year'
    ).
  ENDMETHOD.


  METHOD first_day_of_year.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '20200101'
        iv_round_mode = /gicom/cl_util_time_date=>round_off
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '2019'
        msg = 'Expected different rounding result for start of year'
    ).
  ENDMETHOD.


  METHOD middle_of_year.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '20190702'
        iv_round_mode =  /gicom/cl_util_time_date=>round_up
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '2020'
        msg = 'Expected different rounding result for middle of year'
    ).
  ENDMETHOD.


  METHOD middle_of_leap_year.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '20200702'
        iv_round_mode =  /gicom/cl_util_time_date=>round_up
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '2021'
        msg = 'Expected different rounding result for middle of leap year'
    ).
  ENDMETHOD.


  METHOD first_half_of_year.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '20200405'
        iv_round_mode =  /gicom/cl_util_time_date=>round_up
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '2020'
        msg = 'Expected different rounding result for 1st half of year'
    ).
  ENDMETHOD.


  METHOD last_half_of_year.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '20201105'
        iv_round_mode =  /gicom/cl_util_time_date=>round_off
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '2020'
        msg = 'Expected different rounding result for last half of year'
    ).
  ENDMETHOD.


  METHOD end_of_world.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '99991231'
        iv_round_mode =  /gicom/cl_util_time_date=>round_up
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '9999'
        msg = 'Expected different rounding result for end of world'
    ).
  ENDMETHOD.


  METHOD start_of_world.
    DATA(lv_year_act) = /gicom/cl_util_time_date=>round_to_year(
        iv_date = '00010101'
        iv_round_mode =  /gicom/cl_util_time_date=>round_off
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_act
        exp = '0001'
        msg = 'Expected different rounding result for start of world'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_round_to_month DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      _2nd_of_month FOR TESTING RAISING cx_static_check,
      _20th_of_month_up FOR TESTING RAISING cx_static_check,
      _20th_of_month_off FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_round_to_month IMPLEMENTATION.

  METHOD _2nd_of_month.
    DATA(lv_year_month_act) = /gicom/cl_util_time_date=>round_to_month(
        iv_date = '20200702'
        iv_round_mode =  /gicom/cl_util_time_date=>round_up
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_month_act
        exp = '202007'
        msg = 'Expected different rounding result for 2nd of month'
    ).
  ENDMETHOD.


  METHOD _20th_of_month_up.
    DATA(lv_year_month_act) = /gicom/cl_util_time_date=>round_to_month(
        iv_date = '20200720'
        iv_round_mode =  /gicom/cl_util_time_date=>round_up
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_month_act
        exp = '202008'
        msg = 'Expected different rounding result for 20th of month'
    ).
  ENDMETHOD.


  METHOD _20th_of_month_off.
    DATA(lv_year_month_act) = /gicom/cl_util_time_date=>round_to_month(
        iv_date = '20200720'
        iv_round_mode =  /gicom/cl_util_time_date=>round_off
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_year_month_act
        exp = '202007'
        msg = 'Expected different rounding result for 20th of month'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_add_date_diff_to_date DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      _add_date_diff_to_date FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_add_date_diff_to_date IMPLEMENTATION.
  METHOD _add_date_diff_to_date.
    "Test 10
    DATA(lv_result) = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20210101'
        iv_date_to         = '20210115'
        iv_date_add        = '20210201'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20210215'
        msg = 'Result of Test 10 is negative'
    ).

    "Test 20
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20210101'
        iv_date_to         = '20210115'
        iv_date_add        = '20210203'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20210217'
        msg = 'Result of Test 20 is negative'
    ).

    "Test 30
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20210101'
        iv_date_to         = '20210131'
        iv_date_add        = '20210201'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20210228'
        msg = 'Result of Test 30 is negative'
    ).

    "Test 40
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20200101'
        iv_date_to         = '20200131'
        iv_date_add        = '20200201'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20200229'
        msg = 'Result of Test 40 is negative'
    ).

    "Test 50
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20200101'
        iv_date_to         = '20210315'
        iv_date_add        = '20220101'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20230316'
        msg = 'Result of Test 50 is negative'
    ).

    "Test 60
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20180101'
        iv_date_to         = '20190315'
        iv_date_add        = '20200101'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20210315'
        msg = 'Result of Test 60 is negative'
    ).

    "Test 70
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20200218'
        iv_date_to         = '20200229'
        iv_date_add        = '20210218'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20210301'
        msg = 'Result of Test 70 is negative'
    ).

    "Test 80
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20200101'
        iv_date_to         = '20201231'
        iv_date_add        = '20210101'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20211231'
        msg = 'Result of Test 80 is negative'
    ).

    "Test 90
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20200101'
        iv_date_to         = '99991231'
        iv_date_add        = '20210101'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '99991231'
        msg = 'Result of Test 90 is negative'
    ).

    "Test 100
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20210220'
        iv_date_to         = '20210228'
        iv_date_add        = '20210301'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20210309'
        msg = 'Result of Test 100 is negative'
    ).

    "Test 110
    "INS M.20685 DV 04.05.2021 Add new special case -> one month validity
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20220101'
        iv_date_to         = '20220131'
        iv_date_add        = '20220201'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20220228'
        msg = 'Result of Test 110 is negative'
    ).

    "Test 120
    "INS M.20685 DV 04.05.2021 Like 110 shifted by one month
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20220101'
        iv_date_to         = '20220131'
        iv_date_add        = '20220301'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20220331'
        msg = 'Result of Test 120 is negative'
    ).

    "Test 130
    "INS M.20685 DV 04.05.2021 Like 110 shifted and longer
    lv_result = /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_date_from       = '20220101'
        iv_date_to         = '20220228'
        iv_date_add        = '20220401'
    ).
    cl_abap_unit_assert=>assert_equals(
        act = lv_result
        exp = '20220531'
        msg = 'Result of Test 130 is negative'
    ).

  ENDMETHOD.

ENDCLASS.


CLASS ltcl_add_time_to_date DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      add_1_day FOR TESTING RAISING cx_static_check,
      add_100_day FOR TESTING RAISING cx_static_check,
      add_400_day FOR TESTING RAISING cx_static_check,
      add_1_week FOR TESTING RAISING cx_static_check,
      add_10_week FOR TESTING RAISING cx_static_check,
      add_70_week FOR TESTING RAISING cx_static_check,
      add_1_month FOR TESTING RAISING cx_static_check,
      add_4_month FOR TESTING RAISING cx_static_check,
      add_14_month FOR TESTING RAISING cx_static_check,
      add_1_year FOR TESTING RAISING cx_static_check,
      add_10_year FOR TESTING RAISING cx_static_check,
      add_1_month_jan_feb FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_add_time_to_date IMPLEMENTATION.

  METHOD add_1_day.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '1'
                        iv_type            = 'D'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220102'
    ).
  ENDMETHOD.

  METHOD add_100_day.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '100'
                        iv_type            = 'D'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220411'
    ).
  ENDMETHOD.

  METHOD add_400_day.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '400'
                        iv_type            = 'D'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20230205'
    ).
  ENDMETHOD.

  METHOD add_1_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '1'
                        iv_type            = 'W'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220108'
    ).
  ENDMETHOD.

  METHOD add_10_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '10'
                        iv_type            = 'W'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220312'
    ).
  ENDMETHOD.

  METHOD add_70_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '70'
                        iv_type            = 'W'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20230506'
    ).
  ENDMETHOD.

  METHOD add_1_month.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '1'
                        iv_type            = 'M'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220201'
    ).
  ENDMETHOD.

  METHOD add_4_month.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '4'
                        iv_type            = 'M'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220501'
    ).
  ENDMETHOD.

  METHOD add_14_month.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '14'
                        iv_type            = 'M'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20230301'
    ).
  ENDMETHOD.

  METHOD add_1_year.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '1'
                        iv_type            = 'Y'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20230101'
    ).
  ENDMETHOD.

  METHOD add_10_year.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
                        iv_date            = '20220101'
                        iv_add             = '10'
                        iv_type            = 'Y'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20320101'
    ).
  ENDMETHOD.

  METHOD add_1_month_jan_feb.
    DATA(lv_result) = /gicom/cl_util_time_date=>add_time_to_date(
      iv_date            = '20220131'
      iv_add             = 1
      iv_type            = 'M'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_result
      exp = '20220228'
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltcl_subtract_time_to_date DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      subtract_1_day FOR TESTING RAISING cx_static_check,
      subtract_100_day FOR TESTING RAISING cx_static_check,
      subtract_400_day FOR TESTING RAISING cx_static_check,
      subtract_1_week FOR TESTING RAISING cx_static_check,
      subtract_10_week FOR TESTING RAISING cx_static_check,
      subtract_70_week FOR TESTING RAISING cx_static_check,
      subtract_1_month FOR TESTING RAISING cx_static_check,
      subtract_4_month FOR TESTING RAISING cx_static_check,
      subtract_14_month FOR TESTING RAISING cx_static_check,
      subtract_1_year FOR TESTING RAISING cx_static_check,
      subtract_10_year FOR TESTING RAISING cx_static_check,
      subtract_1_day_from_leap_year FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_subtract_time_to_date IMPLEMENTATION.

  METHOD subtract_1_day.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '1'
                        iv_type            = 'D'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20221230'
    ).
  ENDMETHOD.

  METHOD subtract_100_day.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '100'
                        iv_type            = 'D'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220922'
    ).
  ENDMETHOD.

  METHOD subtract_400_day.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '400'
                        iv_type            = 'D'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20211126'
    ).
  ENDMETHOD.

  METHOD subtract_1_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '1'
                        iv_type            = 'W'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20221224'
    ).
  ENDMETHOD.

  METHOD subtract_10_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '10'
                        iv_type            = 'W'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20221022'
    ).
  ENDMETHOD.

  METHOD subtract_70_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '70'
                        iv_type            = 'W'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20210828'
    ).
  ENDMETHOD.

  METHOD subtract_1_month.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '1'
                        iv_type            = 'M'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20221130'
    ).
  ENDMETHOD.

  METHOD subtract_4_month.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '4'
                        iv_type            = 'M'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20220831'
    ).
  ENDMETHOD.

  METHOD subtract_14_month.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '14'
                        iv_type            = 'M'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20211031'
    ).
  ENDMETHOD.

  METHOD subtract_1_year.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '1'
                        iv_type            = 'Y'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20211231'
    ).
  ENDMETHOD.

  METHOD subtract_10_year.
    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20221231'
                        iv_subtract        = '10'
                        iv_type            = 'Y'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20121231'
    ).
  ENDMETHOD.

  METHOD subtract_1_day_from_leap_year.

    DATA(lv_result) = /gicom/cl_util_time_date=>subtract_time_from_date(
                        iv_date            = '20240101'
                        iv_subtract        = '1'
                        iv_type            = 'D'
                      ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '20231231'
    ).

  ENDMETHOD.

ENDCLASS.


CLASS ltcl_get_day_difference DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      get_no_diff FOR TESTING RAISING cx_static_check,
      get_1_day_diff FOR TESTING RAISING cx_static_check,
      get_30_days_diff FOR TESTING RAISING cx_static_check,
      get_31_days_diff FOR TESTING RAISING cx_static_check,
      get_364_days_diff FOR TESTING RAISING cx_static_check,
      get_365_days_diff FOR TESTING RAISING cx_static_check,
      get_diff_leap_year FOR TESTING RAISING cx_static_check,
      get_diff_noleap_year FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_get_day_difference IMPLEMENTATION.

  METHOD get_no_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20220101'
                          iv_end_date   = '20220101'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '0'
    ).
  ENDMETHOD.

  METHOD get_1_day_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20220101'
                          iv_end_date   = '20220102'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '1'
    ).
  ENDMETHOD.

  METHOD get_30_days_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20220101'
                          iv_end_date   = '20220131'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '30'
    ).
  ENDMETHOD.

  METHOD get_31_days_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20220101'
                          iv_end_date   = '20220201'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '31'
    ).
  ENDMETHOD.

  METHOD get_364_days_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20220101'
                          iv_end_date   = '20221231'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '364'
    ).
  ENDMETHOD.

  METHOD get_365_days_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20220101'
                          iv_end_date   = '20230101'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '365'
    ).
  ENDMETHOD.

  METHOD get_diff_leap_year.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20200201'
                          iv_end_date   = '20200301'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '29'
    ).
  ENDMETHOD.

  METHOD get_diff_noleap_year.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_day_difference(
                          iv_start_date = '20210201'
                          iv_end_date   = '20210301'
                        ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '28'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltcl_get_month_difference DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      get_no_diff FOR TESTING RAISING cx_static_check,
      get_1_month_diff FOR TESTING RAISING cx_static_check,
      get_3_month_diff FOR TESTING RAISING cx_static_check,
      get_11_month_diff FOR TESTING RAISING cx_static_check,
      get_12_month_diff FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_get_month_difference IMPLEMENTATION.

  METHOD get_no_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_month_difference(
      iv_start_date = '20220101'
      iv_end_date   = '20220131'
    ).


    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '1'
    ).
  ENDMETHOD.

  METHOD get_1_month_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_month_difference(
      iv_start_date = '20220101'
      iv_end_date   = '20220201'
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '1.033333333333333333333333333333333'
    ).
  ENDMETHOD.

  METHOD get_3_month_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_month_difference(
      iv_start_date = '20240103'
      iv_end_date   = '20240331'
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '2.933333333333333333333333333333333'
    ).



  ENDMETHOD.

  METHOD get_11_month_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_month_difference(
      iv_start_date = '20220101'
      iv_end_date   = '20221231'
    ).


    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '12.13333333333333333333333333333333'
    ).
  ENDMETHOD.

  METHOD get_12_month_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_month_difference(
      iv_start_date = '20220101'
      iv_end_date   = '20230101'
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '12.16666666666666666666666666666667'
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltcl_get_quarter DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      assert_quarter
        IMPORTING
          iv_date    TYPE /gicom/date
          iv_quarter TYPE /gicom/quarter,
      get_quarter_january FOR TESTING RAISING cx_static_check,
      get_quarter_february FOR TESTING RAISING cx_static_check,
      get_quarter_march FOR TESTING RAISING cx_static_check,
      get_quarter_april FOR TESTING RAISING cx_static_check,
      get_quarter_may FOR TESTING RAISING cx_static_check,
      get_quarter_june FOR TESTING RAISING cx_static_check,
      get_quarter_july FOR TESTING RAISING cx_static_check,
      get_quarter_august FOR TESTING RAISING cx_static_check,
      get_quarter_september FOR TESTING RAISING cx_static_check,
      get_quarter_october FOR TESTING RAISING cx_static_check,
      get_quarter_november FOR TESTING RAISING cx_static_check,
      get_quarter_december FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_get_quarter IMPLEMENTATION.

  METHOD assert_quarter.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = iv_date ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = iv_quarter
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_quarter_january.
    assert_quarter( iv_date = '20220101' iv_quarter = '1' ).
  ENDMETHOD.

  METHOD get_quarter_february.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220201' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '1'
*        msg                  =
    ).

  ENDMETHOD.

  METHOD get_quarter_march.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220301' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '1'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_quarter_april.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220401' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '2'
*        msg                  =
    ).

  ENDMETHOD.

  METHOD get_quarter_may.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220501' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '2'
*        msg                  =
    ).

  ENDMETHOD.

  METHOD get_quarter_june.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220601' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '2'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_quarter_july.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220701' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '3'
*        msg                  =
    ).

  ENDMETHOD.

  METHOD get_quarter_august.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220801' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '3'
*        msg                  =
    ).

  ENDMETHOD.

  METHOD get_quarter_september.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20220901' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '3'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_quarter_october.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20221001' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '4'
*        msg                  =
    ).

  ENDMETHOD.

  METHOD get_quarter_november.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20221101' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '4'
*        msg                  =
    ).

  ENDMETHOD.

  METHOD get_quarter_december.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_quarter( iv_date = '20221201' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '4'
*        msg                  =
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltcl_get_weekday DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      get_weekday_mon FOR TESTING RAISING cx_static_check,
      get_weekday_tue FOR TESTING RAISING cx_static_check,
      get_weekday_wed FOR TESTING RAISING cx_static_check,
      get_weekday_thr FOR TESTING RAISING cx_static_check,
      get_weekday_fri FOR TESTING RAISING cx_static_check,
      get_weekday_sat FOR TESTING RAISING cx_static_check,
      get_weekday_sun FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_get_weekday IMPLEMENTATION.

  METHOD get_weekday_mon.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_weekday( iv_date = '20220103' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '1'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_weekday_tue.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_weekday( iv_date = '20220104' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '2'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_weekday_wed.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_weekday( iv_date = '20220105' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '3'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_weekday_thr.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_weekday( iv_date = '20220106' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '4'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_weekday_fri.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_weekday( iv_date = '20220107' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '5'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_weekday_sat.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_weekday( iv_date = '20220108' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '6'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_weekday_sun.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_weekday( iv_date = '20220109' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = '7'
*        msg                  =
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltcl_get_year_difference DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      get_no_diff FOR TESTING RAISING cx_static_check,
      get_1_year_diff FOR TESTING RAISING cx_static_check,
      get_8_year_diff FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_get_year_difference IMPLEMENTATION.

  METHOD get_no_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_year_difference(
                           iv_start_date = '20220101'
                           iv_end_date   = '20221231'
                         ).

    DATA: ls_start_timepoint TYPE fdt_s_timepoint,
          ls_end_timepoint   TYPE fdt_s_timepoint.

    ls_start_timepoint = '20220101'.
    ls_end_timepoint = '20221231'.

    DATA(lv_expected) = '0.9972602739726027397260273972602740'.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = lv_expected"'0'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_1_year_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_year_difference(
                           iv_start_date = '20220101'
                           iv_end_date   = '20230102'
                         ).

    DATA: ls_start_timepoint TYPE fdt_s_timepoint,
          ls_end_timepoint   TYPE fdt_s_timepoint.

    ls_start_timepoint = '20220101'.
    ls_end_timepoint = '20230102'.

    DATA(lv_expected) = '1.002739726027397260273972602739726'.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = lv_expected"'1'
*        msg                  =
    ).
  ENDMETHOD.

  METHOD get_8_year_diff.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_year_difference(
                           iv_start_date = '20220101'
                           iv_end_date   = '20300102'
                         ).

    DATA: ls_start_timepoint TYPE fdt_s_timepoint,
          ls_end_timepoint   TYPE fdt_s_timepoint.

    ls_start_timepoint = '20220101'.
    ls_end_timepoint = '20300102'.

    DATA(lv_expected) = '8.008219178082191780821917808219178'.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_result
        exp                  = lv_expected"'8'
*        msg                  =
    ).
  ENDMETHOD.

ENDCLASS.


CLASS ltcl_leap_year DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      check_leap_years FOR TESTING RAISING cx_static_check,
      check_non_leap_years FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_get_week_iso DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      get_first_week FOR TESTING RAISING cx_static_check,
      get_last_week FOR TESTING RAISING cx_static_check,
      get_25th_week FOR TESTING RAISING cx_static_check,
      get_last_week_next_year FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_get_week_iso IMPLEMENTATION.

  METHOD get_first_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_week_iso( iv_date = '20220103' ).

    cl_abap_unit_assert=>assert_equals(
        EXPORTING
          act                  = lv_result
          exp                  = '202201'
*        msg                  =
      ).
  ENDMETHOD.

  METHOD get_last_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_week_iso( iv_date = '20221231' ).

    cl_abap_unit_assert=>assert_equals(
        EXPORTING
          act                  = lv_result
          exp                  = '202252'
*        msg                  =
      ).
  ENDMETHOD.

  METHOD get_25th_week.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_week_iso( iv_date = '20220620' ).

    cl_abap_unit_assert=>assert_equals(
        EXPORTING
          act                  = lv_result
          exp                  = '202225'
*        msg                  =
      ).
  ENDMETHOD.

  METHOD get_last_week_next_year.
    DATA(lv_result) = /gicom/cl_util_time_date=>get_week_iso( iv_date = '20220101' ).

    cl_abap_unit_assert=>assert_equals(
        EXPORTING
          act                  = lv_result
          exp                  = '202152'
*        msg                  =
      ).
  ENDMETHOD.

ENDCLASS.


CLASS ltcl_leap_year IMPLEMENTATION.

  METHOD check_leap_years.
    DATA lt_years TYPE STANDARD TABLE OF /gicom/year.

    lt_years = VALUE #(
      ( CONV #( '1820' ) )
      ( CONV #( '2000' ) )
      ( CONV #( '2020' ) )
      ( CONV #( '2040' ) )
      ( CONV #( '2048' ) )
      ( CONV #( '2256' ) )
    ).

    LOOP AT lt_years ASSIGNING FIELD-SYMBOL(<ls_>).
      cl_abap_unit_assert=>assert_true(
          act = /gicom/cl_util_time_date=>is_leap_year( <ls_> )
      ).
    ENDLOOP.
  ENDMETHOD.

  METHOD check_non_leap_years.
    DATA lt_years TYPE STANDARD TABLE OF /gicom/year.

    lt_years = VALUE #(
      ( CONV #( '1821' ) )
      ( CONV #( '2100' ) )
      ( CONV #( '2019' ) )
      ( CONV #( '2200' ) )
      ( CONV #( '2047' ) )
      ( CONV #( '2034' ) )
    ).

    LOOP AT lt_years ASSIGNING FIELD-SYMBOL(<ls_>).
      cl_abap_unit_assert=>assert_false(
          act = /gicom/cl_util_time_date=>is_leap_year( <ls_> )
      ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.


CLASS ltc_get_interval_dates DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA:
      go_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup,
      teardown,
      settlement_interval_q FOR TESTING RAISING cx_static_check,
      settlement_interval_m4 FOR TESTING RAISING cx_static_check,
      get_no_interval_dates  FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_get_interval_dates IMPLEMENTATION.

  METHOD class_setup.
    go_environment = cl_osql_test_environment=>create(
      VALUE #(
        ( '/GICOM/CC_CLNDR' )
      )
    ).
  ENDMETHOD.

  METHOD class_teardown.
    go_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA lt_cc_clndr TYPE TABLE OF /gicom/cc_clndr.
    lt_cc_clndr = VALUE #(
      ( settlement_year = '2022' settlement_interval = 1 settlement_period = /gicom/if_const_settl_period=>gc_quarterly period_base = 0 period_start = '20220101' period_end = '20220331' )
      ( settlement_year = '2022' settlement_interval = 2 settlement_period = /gicom/if_const_settl_period=>gc_quarterly period_base = 0 period_start = '20220401' period_end = '20220630' )
      ( settlement_year = '2022' settlement_interval = 3 settlement_period = /gicom/if_const_settl_period=>gc_quarterly period_base = 0 period_start = '20220701' period_end = '20220930' )
      ( settlement_year = '2022' settlement_interval = 4 settlement_period = /gicom/if_const_settl_period=>gc_quarterly period_base = 0 period_start = '20221001' period_end = '20221231' )

      ( settlement_year = '2022' settlement_interval = 5 settlement_period = /gicom/if_const_settl_period=>gc_monthly_4 period_base = 2 period_start = '20220201' period_end = '20220531' )
      ( settlement_year = '2022' settlement_interval = 9 settlement_period = /gicom/if_const_settl_period=>gc_monthly_4 period_base = 2 period_start = '20220601' period_end = '20220930' )
      ( settlement_year = '2023' settlement_interval = 1 settlement_period = /gicom/if_const_settl_period=>gc_monthly_4 period_base = 2 period_start = '20221001' period_end = '20230131' )
      ( settlement_year = '2023' settlement_interval = 5 settlement_period = /gicom/if_const_settl_period=>gc_monthly_4 period_base = 2 period_start = '20230201' period_end = '20230531' )
      ( settlement_year = '2023' settlement_interval = 9 settlement_period = /gicom/if_const_settl_period=>gc_monthly_4 period_base = 2 period_start = '20230601' period_end = '20230930' )
    ).

    go_environment->insert_test_data( lt_cc_clndr ).
  ENDMETHOD.

  METHOD teardown.
    go_environment->clear_doubles( ).
  ENDMETHOD.

  METHOD settlement_interval_q.

    " when
    DATA(lt_interval_dates_act) = /gicom/cl_util_time_date=>get_interval_standard_dates(
      EXPORTING
        iv_settlement_period = /gicom/if_const_settl_period=>gc_quarterly
        iv_agrmt_valid_from  = '20220405'
        iv_agrmt_valid_to    = '20230715'
    ).

    " then
    DATA(lt_interval_dates_exp) = VALUE /gicom/interval_dates_tt(
      ( settlement_interval = '1' interval_start = '20220101' interval_end = '20220331' )
      ( settlement_interval = '2' interval_start = '20220401' interval_end = '20220630' )
      ( settlement_interval = '3' interval_start = '20220701' interval_end = '20220930' )
      ( settlement_interval = '4' interval_start = '20221001' interval_end = '20221231' )
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_interval_dates_act
        exp                  = lt_interval_dates_exp
        msg                  = 'Invalid entries for interval Q'
    ).

  ENDMETHOD.

  METHOD settlement_interval_m4.

    " when
    DATA(lt_interval_dates_act) = /gicom/cl_util_time_date=>get_interval_standard_dates(
      EXPORTING
        iv_settlement_period = /gicom/if_const_settl_period=>gc_monthly_4
        iv_agrmt_valid_from  = '20220205'
        iv_agrmt_valid_to    = '20230715'
    ).

    " then
    DATA(lt_interval_dates_exp) = VALUE /gicom/interval_dates_tt(
      ( settlement_interval = '5' interval_start = '20220201' interval_end = '20220531' )
      ( settlement_interval = '9' interval_start = '20220601' interval_end = '20220930' )
      ( settlement_interval = '1' interval_start = '20221001' interval_end = '20230131' )
    ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lt_interval_dates_act
        exp                  = lt_interval_dates_exp
        msg                  = 'Invalid entries for interval M4'
    ).

  ENDMETHOD.

  METHOD get_no_interval_dates.

    " when
    DATA(lt_interval_dates_act) = /gicom/cl_util_time_date=>get_interval_standard_dates(
      EXPORTING
        iv_settlement_period = /gicom/if_const_settl_period=>gc_monthly_6
        iv_agrmt_valid_from  = '20220205'
        iv_agrmt_valid_to    = '20230715'
    ).

    " then
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = lt_interval_dates_act
        msg              = 'No entries should be found'
    ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_add_time_to_timestamp DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA:
      gv_timestamp TYPE p VALUE '20230101000000'.

    METHODS:
      add_seconds FOR TESTING,
      add_minutes FOR TESTING,
      add_hours FOR TESTING,
      add_days FOR TESTING,
      add_weeks FOR TESTING,
      add_months FOR TESTING.
ENDCLASS.

CLASS ltc_add_time_to_timestamp IMPLEMENTATION.

  METHOD add_days.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>add_time_to_timestamp(
          EXPORTING
            iv_timestamp = gv_timestamp
            iv_add       = '5'
            iv_scale     = 'D'
        ).
      CATCH /gicom/cx_internal_error.
        cl_abap_unit_assert=>fail( 'Code couldn´t get proceeded' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_act
        exp = '20230106000000'
        msg = 'Timestamp should be 5 days longer'
    ).
  ENDMETHOD.

  METHOD add_hours.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>add_time_to_timestamp(
          EXPORTING
            iv_timestamp = gv_timestamp
            iv_add       = '1'
            iv_scale     = 'H'
        ).
      CATCH /gicom/cx_internal_error.
        cl_abap_unit_assert=>fail( 'Code couldn´t get proceeded' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_act
        exp = '20230101010000'
        msg = 'Timestamp should be 1 hour longer'
    ).
  ENDMETHOD.

  METHOD add_minutes.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>add_time_to_timestamp(
          EXPORTING
            iv_timestamp = gv_timestamp
            iv_add       = '30'
            iv_scale     = 'M'
        ).
      CATCH /gicom/cx_internal_error.
        cl_abap_unit_assert=>fail( 'Code couldn´t get proceeded' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_act
        exp = '20230101003000'
        msg = 'Timestamp should be 30 minutes longer'
    ).
  ENDMETHOD.

  METHOD add_months.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>add_time_to_timestamp(
          EXPORTING
            iv_timestamp = gv_timestamp
            iv_add       = '3'
            iv_scale     = 'MO'
        ).
      CATCH /gicom/cx_internal_error.
        cl_abap_unit_assert=>fail( 'Code couldn´t get proceeded' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_act
        exp = '20230401000000'
        msg = 'Timestamp should be 3 months longer'
    ).
  ENDMETHOD.

  METHOD add_seconds.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>add_time_to_timestamp(
          EXPORTING
            iv_timestamp = gv_timestamp
            iv_add       = '10'
            iv_scale     = 'S'
        ).
      CATCH /gicom/cx_internal_error.
        cl_abap_unit_assert=>fail( 'Code couldn´t get proceeded' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_act
        exp = '20230101000010'
        msg = 'Timestamp should be 10 seconds longer'
    ).
  ENDMETHOD.

  METHOD add_weeks.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>add_time_to_timestamp(
          EXPORTING
            iv_timestamp = gv_timestamp
            iv_add       = '2'
            iv_scale     = 'W'
        ).
      CATCH /gicom/cx_internal_error.
        cl_abap_unit_assert=>fail( 'Code couldn´t get proceeded' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_act
        exp = '20230115000000'
        msg = 'Timestamp should be 2 weeks longer'
    ).
  ENDMETHOD.
ENDCLASS.

CLASS ltc_last_date_of_quarter DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      initial_date FOR TESTING,
      month_10 FOR TESTING,
      month_7 FOR TESTING,
      month_4 FOR TESTING,
      month_2 FOR TESTING.
ENDCLASS.

CLASS ltc_last_date_of_quarter IMPLEMENTATION.

  METHOD initial_date.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_quarter( iv_date = '00000000' ).

    "then
    cl_abap_unit_assert=>assert_initial( lv_act ).
  ENDMETHOD.

  METHOD month_10.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_quarter( iv_date = '20231001' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20231231'
      msg = 'Should return the end of month 12'
    ).
  ENDMETHOD.

  METHOD month_2.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_quarter( iv_date = '20230201' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230331'
      msg = 'Should return the end of month 3'
    ).
  ENDMETHOD.

  METHOD month_4.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_quarter( iv_date = '20230401' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230630'
      msg = 'Should return the end of month 6'
    ).
  ENDMETHOD.

  METHOD month_7.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_quarter( iv_date = '20230701' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230930'
      msg = 'Should return the end of month 9'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_get_last_date_of_half DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      initial_date FOR TESTING,
      month_3 FOR TESTING,
      month_9 FOR TESTING.
ENDCLASS.

CLASS ltc_get_last_date_of_half IMPLEMENTATION.

  METHOD initial_date.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_half( iv_date = '00000000' ).

    "then
    cl_abap_unit_assert=>assert_initial( lv_act ).
  ENDMETHOD.

  METHOD month_3.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_half( iv_date = '20230301' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230630'
      msg = 'Should return the end of month 6'
    ).
  ENDMETHOD.

  METHOD month_9.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_half( iv_date = '20230901' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20231231'
      msg = 'Should return the end of month 12'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS ltc_get_first_date_of_week DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      initial_week FOR TESTING,
      initial_year FOR TESTING,
      initial_year_and_week FOR TESTING,
      first_week_of_the_year FOR TESTING,
      last_week_of_the_year FOR TESTING.
ENDCLASS.

CLASS ltc_get_first_date_of_week IMPLEMENTATION.

  METHOD first_week_of_the_year.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>get_first_date_of_week( iv_year = '2023' iv_week = '01' ).
      CATCH /gicom/cx_illegal_arguments.
        cl_abap_unit_assert=>fail( 'Should not be here' ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230102'
      msg = '2nd Jan is the first date of the 1st week' ).

  ENDMETHOD.

  METHOD initial_week.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>get_first_date_of_week( iv_year = '2023' iv_week = '00' ).
        cl_abap_unit_assert=>fail( 'Should not be here' ).
      CATCH /gicom/cx_illegal_arguments.
    ENDTRY.

  ENDMETHOD.

  METHOD last_week_of_the_year.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>get_first_date_of_week( iv_year = '2023' iv_week = '52' ).
      CATCH /gicom/cx_illegal_arguments.
        cl_abap_unit_assert=>fail( 'Should not be here' ).
    ENDTRY.

    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20231225'
      msg = '25th Dec is the first date of the last week' ).
  ENDMETHOD.

  METHOD initial_year.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>get_first_date_of_week( iv_year = '0000' iv_week = '01' ).
        cl_abap_unit_assert=>fail( 'Should not be here' ).
      CATCH /gicom/cx_illegal_arguments.
    ENDTRY.
  ENDMETHOD.

  METHOD initial_year_and_week.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>get_first_date_of_week( iv_year = '0000' iv_week = '00' ).
        cl_abap_unit_assert=>fail( 'Should not be here' ).
      CATCH /gicom/cx_illegal_arguments.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

CLASS get_last_date_of_year DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      initial_date FOR TESTING,
      not_initial_date FOR TESTING.
ENDCLASS.

CLASS get_last_date_of_year IMPLEMENTATION.

  METHOD initial_date.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_year( iv_date = '00000000' ).

    "then
    cl_abap_unit_assert=>assert_initial( lv_act ).
  ENDMETHOD.

  METHOD not_initial_date.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_year( iv_date = '20230101' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20231231'
      msg = 'End of year not found'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS get_last_date_of_week DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      initial_date FOR TESTING,
      first_day_of_the_year FOR TESTING,
      last_week_of_the_year FOR TESTING.
ENDCLASS.

CLASS get_last_date_of_week IMPLEMENTATION.

  METHOD first_day_of_the_year.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_week( iv_date = '20230101' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230101'
      msg = '1st Jan is Sunday'
    ).
  ENDMETHOD.

  METHOD initial_date.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_week( iv_date = '00000000' ).

    "then
    cl_abap_unit_assert=>assert_initial( lv_act ).
  ENDMETHOD.

  METHOD last_week_of_the_year.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_week( iv_date = '20231225' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20231231'
      msg = '31st Dec is Sunday'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS get_last_date_of_third DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      initial_date FOR TESTING,
      mon_10 FOR TESTING,
      mon_6 FOR TESTING,
      mon_3 FOR TESTING.
ENDCLASS.

CLASS get_last_date_of_third IMPLEMENTATION.

  METHOD initial_date.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_third( iv_date = '00000000' ).

    "then
    cl_abap_unit_assert=>assert_initial( lv_act ).
  ENDMETHOD.

  METHOD mon_10.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_third( iv_date = '20231001' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20231231'
      msg = '31st Dec is last date of third'
    ).
  ENDMETHOD.

  METHOD mon_3.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_third( iv_date = '20230301' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230331'
      msg = '31st March is last date of third'
    ).
  ENDMETHOD.

  METHOD mon_6.
    "when
    DATA(lv_act) = /gicom/cl_util_time_date=>get_last_date_of_third( iv_date = '20230601' ).

    "then
    cl_abap_unit_assert=>assert_equals(
      act = lv_act
      exp = '20230930'
      msg = '33th Sep is last date of third'
    ).
  ENDMETHOD.

ENDCLASS.

CLASS compare_time_ranges DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      empty_dates FOR TESTING,
      equal_dates FOR TESTING,
      inside_date FOR TESTING,
      inside_date_eq_to_dates FOR TESTING,
      inside_from_to_dates FOR TESTING,
      overlapping_date FOR TESTING,
      overlapping_date2 FOR TESTING,
      overlapping_date3 FOR TESTING,
      independent_date FOR TESTING,
      valid_to_gt_valid_from FOR TESTING,
      overlapping_by_one_day_1 FOR TESTING,
      overlapping_by_one_day_2 FOR TESTING,
      independent_by_one_day_1 FOR TESTING,
      independent_by_one_day_2 FOR TESTING.
ENDCLASS.

CLASS compare_time_ranges IMPLEMENTATION.

  METHOD empty_dates.
    "when
    TRY.
        /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '00000000'
            iv_to_1   = '00000000'
            iv_from_2 = '00000000'
            iv_to_2   = '00000000'
        ).

        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).

      CATCH /gicom/cx_invalid_arguments.
        "successful
    ENDTRY.

  ENDMETHOD.

  METHOD equal_dates.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20231231'
            iv_from_2 = '20230619'
            iv_to_2   = '20231231'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-equal
            msg                  = 'Dates should be equal'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD independent_date.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20231231'
            iv_from_2 = '20240619'
            iv_to_2   = '20241231'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-independent
            msg                  = 'Dates should be indipendant'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.


  ENDMETHOD.

  METHOD inside_date.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20231231'
            iv_from_2 = '20230619'
            iv_to_2   = '20231031'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-inside
            msg                  = 'Second Date Interval should be inside'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD overlapping_date.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20231031'
            iv_from_2 = '20230619'
            iv_to_2   = '20231231'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-overlapping
            msg                  = 'Seond Date Interval should overlap'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.


  ENDMETHOD.

  METHOD inside_date_eq_to_dates.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20231231'
            iv_from_2 = '20230719'
            iv_to_2   = '20231231'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-inside
            msg                  = 'Second Date Interval should be inside'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD inside_from_to_dates.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20231231'
            iv_from_2 = '20230719'
            iv_to_2   = '20231031'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-inside
            msg                  = 'Second Date Interval should be inside'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.
  ENDMETHOD.

  METHOD overlapping_date2.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20231031'
            iv_from_2 = '20230719'
            iv_to_2   = '20231231'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-overlapping
            msg                  = 'Seond Date Interval should overlap'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD overlapping_date3.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230719'
            iv_to_1   = '20231231'
            iv_from_2 = '20230619'
            iv_to_2   = '20231031'
        ).

        "then

        cl_abap_unit_assert=>assert_equals(
          EXPORTING
            act                  = lv_act
            exp                  = /gicom/cl_util_time_date=>c_time_range_comp-overlapping
            msg                  = 'Seond Date Interval should overlap'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD valid_to_gt_valid_from.

    "when
    TRY.
        /gicom/cl_util_time_date=>compare_time_ranges(
          EXPORTING
            iv_from_1 = '20230619'
            iv_to_1   = '20230519'
            iv_from_2 = '20231010'
            iv_to_2   = '20230919'
        ).

        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).

      CATCH /gicom/cx_invalid_arguments.
        "successful
    ENDTRY.

  ENDMETHOD.

    METHOD overlapping_by_one_day_1.

    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          iv_from_1 = '20220101'
          iv_to_1   = '20230101'
          iv_from_2 = '20230101'
          iv_to_2   = '20231231'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_act
          exp = /gicom/cl_util_time_date=>c_time_range_comp-overlapping
          msg = 'Dates should be overlapping'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD overlapping_by_one_day_2.

    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          iv_from_1 = '20230101'
          iv_to_1   = '20231231'
          iv_from_2 = '20220101'
          iv_to_2   = '20230101'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_act
          exp = /gicom/cl_util_time_date=>c_time_range_comp-overlapping
          msg = 'Dates should be overlapping'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD independent_by_one_day_1.

    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          iv_from_1 = '20220101'
          iv_to_1   = '20221231'
          iv_from_2 = '20230101'
          iv_to_2   = '20231231'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_act
          exp = /gicom/cl_util_time_date=>c_time_range_comp-independent
          msg = 'Dates should be independent'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

  METHOD independent_by_one_day_2.

    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>compare_time_ranges(
          iv_from_1 = '20230101'
          iv_to_1   = '20231231'
          iv_from_2 = '20220101'
          iv_to_2   = '20221231'
        ).

        cl_abap_unit_assert=>assert_equals(
          act = lv_act
          exp = /gicom/cl_util_time_date=>c_time_range_comp-independent
          msg = 'Dates should be independent'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t be proceeded here' ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

CLASS convert_ymd_to_date DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      no_year FOR TESTING,
      with_year_no_month FOR TESTING,
      with_year_month_no_day FOR TESTING,
      with_year_month_day FOR TESTING.
ENDCLASS.

CLASS convert_ymd_to_date IMPLEMENTATION.

  METHOD no_year.
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>convert_ymd_to_date( iv_year  = '0000' ).
        cl_abap_unit_assert=>fail( 'Code shouldn´t proceed here' ).
      CATCH /gicom/cx_invalid_arguments.
      "successful
    ENDTRY.
  ENDMETHOD.

  METHOD with_year_month_day.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>convert_ymd_to_date(
          EXPORTING
            iv_year  = '2023'
            iv_month = '12'
            iv_day = '15'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t proceed here' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_act
        exp                  = '20231215'
    ).
  ENDMETHOD.

  METHOD with_year_month_no_day.
    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>convert_ymd_to_date(
          EXPORTING
            iv_year  = '2023'
            iv_month = '12'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t proceed here' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_act
        exp                  = '20231201'
    ).
  ENDMETHOD.

  METHOD with_year_no_month.

    "when
    TRY.
        DATA(lv_act) = /gicom/cl_util_time_date=>convert_ymd_to_date(
          EXPORTING
            iv_year  = '2023'
            iv_month = '00'
        ).

      CATCH /gicom/cx_invalid_arguments.
        cl_abap_unit_assert=>fail( 'Code shouldn´t proceed here' ).
    ENDTRY.

    "then
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act                  = lv_act
        exp                  = '20230101'
    ).

  ENDMETHOD.

ENDCLASS.
