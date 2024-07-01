*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_facade DEFINITION.

  PUBLIC SECTION.

    INTERFACES /gicom/if_util_time_date.

ENDCLASS.

CLASS lcl_facade IMPLEMENTATION.

  METHOD /gicom/if_util_time_date~add_date_diff_to_date.
    /gicom/cl_util_time_date=>add_date_diff_to_date(
      EXPORTING
        iv_check_begin_end = iv_check_begin_end
        iv_date_add        = iv_date_add
        iv_date_from       = iv_date_from
        iv_date_to         = iv_date_to
      IMPORTING
        ev_add             = ev_add
        ev_type            = ev_type
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~add_time_to_date.
    rv_date = /gicom/cl_util_time_date=>add_time_to_date(
      iv_date            = iv_date
      iv_add             = iv_add
      iv_type            = iv_type
      iv_check_begin_end = iv_check_begin_end
      iv_pre_date_from   = iv_pre_date_from
      iv_pre_date_to     = iv_pre_date_to
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~add_time_to_timestamp.
    rv_timestamp = /gicom/cl_util_time_date=>add_time_to_timestamp(
      iv_timestamp = iv_timestamp
      iv_timezone  = iv_timezone
      iv_add       = iv_add
      iv_scale     = iv_scale
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~compare_time_ranges.
    rv_result = /gicom/cl_util_time_date=>compare_time_ranges(
      iv_from_1 = iv_from_1
      iv_to_1   = iv_to_1
      iv_from_2 = iv_from_2
      iv_to_2   = iv_to_2
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~convert_date.
    /gicom/cl_util_time_date=>convert_date(
      EXPORTING
        iv_date       = iv_date
      IMPORTING
        ev_time_stamp = ev_time_stamp
        ev_date_ext   = ev_date_ext
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~convert_date_time_to_timestamp.
    rv_time_stamp = /gicom/cl_util_time_date=>convert_date_time_to_timestamp(
      iv_date     = iv_date
      iv_time     = iv_time
      iv_timezone = iv_timezone
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~convert_date_to_local_string.
    /gicom/cl_util_time_date=>convert_date_to_local_string(
      EXPORTING
        iv_date = iv_date
      IMPORTING
        ev_date = ev_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~convert_time_stamp.
    /gicom/cl_util_time_date=>convert_time_stamp(
      EXPORTING
        iv_time_stamp = iv_time_stamp
        iv_time_zone  = iv_time_zone
      IMPORTING
        ev_date       = ev_date
        ev_date_ext   = ev_date_ext
        ev_time       = ev_time
        ev_time_ext   = ev_time_ext
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~convert_ymd_to_date.
    rv_date = /gicom/cl_util_time_date=>convert_ymd_to_date(
      iv_year  = iv_year
      iv_month = iv_month
      iv_day   = iv_day
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_current_timezone.
    rv_timezone = /gicom/cl_util_time_date=>get_current_timezone( ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_day_difference.
    rv_days = /gicom/cl_util_time_date=>get_day_difference(
      iv_end_date   = iv_end_date
      iv_start_date = iv_start_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_first_date_of_week.
    rv_date = /gicom/cl_util_time_date=>get_first_date_of_week(
      iv_week = iv_week
      iv_year = iv_year
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_intervals_agrmt_validity.
    rt_agrmt_intervals = /gicom/cl_util_time_date=>get_intervals_agrmt_validity(
      iv_agrmt_valid_from  = iv_agrmt_valid_from
      iv_agrmt_valid_to    = iv_agrmt_valid_to
      iv_settlement_period = iv_settlement_period
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_interval_standard_dates.
    rt_interval_dates = /gicom/cl_util_time_date=>get_interval_standard_dates(
      iv_agrmt_valid_from  = iv_agrmt_valid_from
      iv_agrmt_valid_to    = iv_agrmt_valid_to
      iv_settlement_period = iv_settlement_period
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_last_date_of_half.
    rv_date = /gicom/cl_util_time_date=>get_last_date_of_half(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_last_date_of_month.
    rv_date = /gicom/cl_util_time_date=>get_last_date_of_month(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_last_date_of_quarter.
    rv_date = /gicom/cl_util_time_date=>get_last_date_of_quarter(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_last_date_of_third.
    rv_date = /gicom/cl_util_time_date=>get_last_date_of_third(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_last_date_of_week.
    rv_date = /gicom/cl_util_time_date=>get_last_date_of_week(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_last_date_of_year.
    rv_date = /gicom/cl_util_time_date=>get_last_date_of_year(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_month_difference.
    rv_months = /gicom/cl_util_time_date=>get_month_difference(
      iv_end_date   = iv_end_date
      iv_start_date = iv_start_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_quarter.
    rv_quarter = /gicom/cl_util_time_date=>get_quarter(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_time_stamp.
    rv_time_stamp = /gicom/cl_util_time_date=>get_time_stamp( ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_weekday.
    rv_weekday = /gicom/cl_util_time_date=>get_weekday(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_week_iso.
    rv_year_week = /gicom/cl_util_time_date=>get_week_iso(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_where_clause_time.
    rv_where_clause = /gicom/cl_util_time_date=>get_where_clause_time(
      iv_alias_time_ref        = iv_alias_time_ref
      iv_date_from             = iv_date_from
      iv_date_to               = iv_date_to
      iv_field_name            = iv_field_name
      iv_no_interval_same_year = iv_no_interval_same_year
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~get_year_difference.
    rv_years = /gicom/cl_util_time_date=>get_year_difference(
      iv_end_date   = iv_end_date
      iv_start_date = iv_start_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_15th_of_month.
    rv_result = /gicom/cl_util_time_date=>is_15th_of_month(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_first_date_of_month.
    rv_result = /gicom/cl_util_time_date=>is_first_date_of_month(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_first_date_of_year.
    rv_result = /gicom/cl_util_time_date=>is_first_date_of_year(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_greater_than.
    rv_greater = /gicom/cl_util_time_date=>is_greater_than(
      iv_date1 = iv_date1
      iv_date2 = iv_date2
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_last_date_of_month.
    rv_result = /gicom/cl_util_time_date=>is_last_date_of_month(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_last_date_of_year.
    rv_result = /gicom/cl_util_time_date=>is_last_date_of_year(
      iv_date = iv_date
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_leap_year.
    rv_is_leap_year = /gicom/cl_util_time_date=>is_leap_year(
      iv_year = iv_year
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~is_less_than.
    rv_less = /gicom/cl_util_time_date=>is_less_than(
      iv_date1 = iv_date1
      iv_date2 = iv_date2
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~round_to_month.
    rv_year_month = /gicom/cl_util_time_date=>round_to_month(
      iv_date       = iv_date
      iv_round_mode = iv_round_mode
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~round_to_year.
    rv_year = /gicom/cl_util_time_date=>round_to_year(
      iv_date       = iv_date
      iv_round_mode = iv_round_mode
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~subtract_time_diff_from_date.
    rv_date = /gicom/cl_util_time_date=>subtract_time_diff_from_date(
      EXPORTING
        iv_date_from = iv_date_from
        iv_date_sub  = iv_date_sub
        iv_date_to   = iv_date_to
      IMPORTING
        ev_sub       = ev_sub
        ev_type      = ev_type
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~subtract_time_from_date.
    rv_date = /gicom/cl_util_time_date=>subtract_time_from_date(
      iv_date     = iv_date
      iv_subtract = iv_subtract
      iv_type     = iv_type
    ).
  ENDMETHOD.

  METHOD /gicom/if_util_time_date~validate_date.
    rv_is_date = /gicom/cl_util_time_date=>validate_date(
      iv_date = iv_date
    ).
  ENDMETHOD.

ENDCLASS.
