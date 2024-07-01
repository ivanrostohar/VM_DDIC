interface /GICOM/IF_UTIL_TIME_DATE
  public .
    CLASS-METHODS validate_date
      IMPORTING
        !iv_date          TYPE /gicom/date
      RETURNING
        VALUE(rv_is_date) TYPE /gicom/abap_bool .
    CLASS-METHODS get_time_stamp
      RETURNING
        VALUE(rv_time_stamp) TYPE /gicom/timestmps .
    "! Converts iv_date from 20170101 into local date string
    "! based on users date settings e.g. in german layout 01.01.2017
    CLASS-METHODS convert_date_to_local_string
      IMPORTING
        !iv_date TYPE sy-datum
      EXPORTING
        !ev_date TYPE any
      RAISING
        /gicom/cx_internal_error.
    CLASS-METHODS convert_date_time_to_timestamp
      IMPORTING
        !iv_date             TYPE /gicom/date
        !iv_time             TYPE /gicom/time
        !iv_timezone         TYPE timezone DEFAULT 'UTC'
      RETURNING
        VALUE(rv_time_stamp) TYPE /gicom/timestmps .
    CLASS-METHODS convert_time_stamp
      IMPORTING
        !iv_time_stamp TYPE /gicom/timestmps
        !iv_time_zone  TYPE syst_zonlo OPTIONAL
      EXPORTING
        !ev_date       TYPE /gicom/date
        !ev_time       TYPE sytime
        !ev_date_ext   TYPE char255
        !ev_time_ext   TYPE char255
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS convert_date
      IMPORTING
        !iv_date       TYPE /gicom/date
      EXPORTING
        !ev_time_stamp TYPE /gicom/timestmps
        !ev_date_ext   TYPE char255
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS get_last_date_of_month
      IMPORTING
        !iv_date       TYPE /gicom/date
      RETURNING
        VALUE(rv_date) TYPE /gicom/date .
    CLASS-METHODS get_last_date_of_year
      IMPORTING
        !iv_date       TYPE /gicom/date
      RETURNING
        VALUE(rv_date) TYPE /gicom/date .
    CLASS-METHODS round_to_year
      IMPORTING
        !iv_date       TYPE /gicom/date
        !iv_round_mode TYPE /gicom/cl_util_time_date=>t_rounding_mode
      RETURNING
        VALUE(rv_year) TYPE /gicom/year .
    CLASS-METHODS round_to_month
      IMPORTING
        !iv_date             TYPE /gicom/date
        !iv_round_mode       TYPE /gicom/cl_util_time_date=>t_rounding_mode
      RETURNING
        VALUE(rv_year_month) TYPE char6 .
    CLASS-METHODS get_last_date_of_quarter
      IMPORTING
        !iv_date       TYPE /gicom/date
      RETURNING
        VALUE(rv_date) TYPE /gicom/date .
    CLASS-METHODS get_last_date_of_half
      IMPORTING
        !iv_date       TYPE /gicom/date
      RETURNING
        VALUE(rv_date) TYPE /gicom/date .
    CLASS-METHODS get_last_date_of_third
      IMPORTING
        !iv_date       TYPE /gicom/date
      RETURNING
        VALUE(rv_date) TYPE /gicom/date .
    CLASS-METHODS get_last_date_of_week
      IMPORTING
        !iv_date       TYPE /gicom/date
      RETURNING
        VALUE(rv_date) TYPE /gicom/date .
    CLASS-METHODS get_where_clause_time
      IMPORTING
        !iv_date_from             TYPE /gicom/valid_from
        !iv_date_to               TYPE /gicom/valid_to
        !iv_alias_time_ref        TYPE dbalias OPTIONAL
        !iv_field_name            TYPE /gicom/string OPTIONAL
        !iv_no_interval_same_year TYPE /gicom/abap_bool DEFAULT abap_true
      RETURNING
        VALUE(rv_where_clause)    TYPE string .
    CLASS-METHODS get_current_timezone
      RETURNING
        VALUE(rv_timezone) TYPE timezone
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS subtract_time_from_date
      IMPORTING
        !iv_date       TYPE dats
        !iv_subtract   TYPE dec_25
        !iv_type       TYPE /gicom/type_time_add
      RETURNING
        VALUE(rv_date) TYPE dats
      RAISING
        cx_fdt_conversion .
    "! <p class="shorttext synchronized" lang="en">Subtracts the difference between two dates from a date</p>
    "!
    "! @parameter iv_date_from | <p class="shorttext synchronized" lang="en">Time range start date</p>
    "! @parameter iv_date_to | <p class="shorttext synchronized" lang="en">Time range end date</p>
    "! @parameter iv_date_sub | <p class="shorttext synchronized" lang="en">Date the difference is subtracted from</p>
    "! @parameter ev_sub | <p class="shorttext synchronized" lang="en">Difference between the dates. Unit is stored in ev_type</p>
    "! @parameter ev_type | <p class="shorttext synchronized" lang="en">Unit of difference between the dates</p>
    "! @parameter rv_date | <p class="shorttext synchronized" lang="en">Date with the range subtracted from &#64;iv_date_sub</p>
    CLASS-METHODS subtract_time_diff_from_date
      IMPORTING
        !iv_date_from  TYPE /gicom/date
        !iv_date_to    TYPE /gicom/date
        !iv_date_sub   TYPE /gicom/date
      EXPORTING
        !ev_sub        TYPE dec_25
        !ev_type       TYPE /gicom/type_time_add
      RETURNING
        VALUE(rv_date) TYPE /gicom/date .
    CLASS-METHODS add_time_to_date
      IMPORTING
        !iv_date            TYPE dats
        !iv_add             TYPE dec_25
        !iv_type            TYPE /gicom/type_time_add
        !iv_check_begin_end TYPE /gicom/abap_bool DEFAULT abap_false
        !iv_pre_date_from   TYPE /gicom/date OPTIONAL     "INS M.20685 DV 20.04.2021
        !iv_pre_date_to     TYPE /gicom/date OPTIONAL     "INS M.20685 DV 20.04.2021
      RETURNING
        VALUE(rv_date)      TYPE dats
      RAISING
        cx_fdt_conversion .
    CLASS-METHODS add_time_to_timestamp
      IMPORTING
        !iv_timestamp       TYPE /gicom/timestmps
        !iv_timezone        TYPE timezone DEFAULT 'UTC'
        !iv_add             TYPE dec_25
        !iv_scale           TYPE /gicom/timing_scale
      RETURNING
        VALUE(rv_timestamp) TYPE /gicom/timestmps
      RAISING
        /gicom/cx_internal_error .
    CLASS-METHODS get_day_difference
      IMPORTING
        !iv_start_date TYPE /gicom/date
        !iv_end_date   TYPE /gicom/date
      RETURNING
        VALUE(rv_days) TYPE decfloat34 .
    CLASS-METHODS get_month_difference
      IMPORTING
        !iv_start_date   TYPE /gicom/date
        !iv_end_date     TYPE /gicom/date
      RETURNING
        VALUE(rv_months) TYPE decfloat34 .
    CLASS-METHODS get_year_difference
      IMPORTING
        !iv_start_date  TYPE /gicom/date
        !iv_end_date    TYPE /gicom/date
      RETURNING
        VALUE(rv_years) TYPE decfloat34 .
    CLASS-METHODS compare_time_ranges
      IMPORTING
        !iv_from_1       TYPE /gicom/date
        !iv_to_1         TYPE /gicom/date
        !iv_from_2       TYPE /gicom/date
        !iv_to_2         TYPE /gicom/date
      RETURNING
        VALUE(rv_result) TYPE /gicom/cmp_time_range
      RAISING
        /gicom/cx_invalid_arguments .
    CLASS-METHODS add_date_diff_to_date
      IMPORTING
        !iv_date_from       TYPE /gicom/date
        !iv_date_to         TYPE /gicom/date
        !iv_date_add        TYPE /gicom/date
        !iv_check_begin_end TYPE /gicom/abap_bool DEFAULT abap_true
      EXPORTING
        !ev_add             TYPE dec_25
        !ev_type            TYPE /gicom/type_time_add
      RETURNING
        VALUE(rv_date)      TYPE /gicom/date .
    CLASS-METHODS is_first_date_of_month
      IMPORTING
        !iv_date         TYPE /gicom/date
      RETURNING
        VALUE(rv_result) TYPE /gicom/abap_bool .
    CLASS-METHODS is_first_date_of_year
      IMPORTING
        !iv_date         TYPE /gicom/date
      RETURNING
        VALUE(rv_result) TYPE /gicom/abap_bool .
    CLASS-METHODS is_last_date_of_month
      IMPORTING
        !iv_date         TYPE /gicom/date
      RETURNING
        VALUE(rv_result) TYPE /gicom/abap_bool .
    CLASS-METHODS is_last_date_of_year
      IMPORTING
        !iv_date         TYPE /gicom/date
      RETURNING
        VALUE(rv_result) TYPE /gicom/abap_bool .
    CLASS-METHODS is_15th_of_month
      IMPORTING
        !iv_date         TYPE /gicom/date
      RETURNING
        VALUE(rv_result) TYPE /gicom/abap_bool .
    CLASS-METHODS convert_ymd_to_date
      IMPORTING
        !iv_year       TYPE /gicom/year
        !iv_month      TYPE /gicom/month OPTIONAL
        !iv_day        TYPE /gicom/day OPTIONAL
      RETURNING
        VALUE(rv_date) TYPE /gicom/date
      RAISING
        /gicom/cx_invalid_arguments .
    CLASS-METHODS is_leap_year
      IMPORTING
        !iv_year               TYPE /gicom/year
      RETURNING
        VALUE(rv_is_leap_year) TYPE abap_bool .
    CLASS-METHODS get_quarter
      IMPORTING
        !iv_date          TYPE /gicom/date
      RETURNING
        VALUE(rv_quarter) TYPE /gicom/quarter .
    CLASS-METHODS get_weekday
      IMPORTING
        !iv_date          TYPE /gicom/date
      RETURNING
        VALUE(rv_weekday) TYPE /gicom/weekday .
    CLASS-METHODS get_week_iso
      IMPORTING
        !iv_date            TYPE /gicom/date
      RETURNING
        VALUE(rv_year_week) TYPE /gicom/year_week .
    CLASS-METHODS get_first_date_of_week
      IMPORTING
        !iv_year       TYPE /gicom/week_year_iso
        !iv_week       TYPE /gicom/week_no_iso
      RETURNING
        VALUE(rv_date) TYPE /gicom/date
      RAISING
        /gicom/cx_illegal_arguments .

    CLASS-METHODS is_greater_than
      IMPORTING
        iv_date1          TYPE /gicom/date
        iv_date2          TYPE /gicom/date
      RETURNING
        VALUE(rv_greater) TYPE /gicom/abap_bool.

    CLASS-METHODS is_less_than
      IMPORTING
        iv_date1       TYPE /gicom/date
        iv_date2       TYPE /gicom/date
      RETURNING
        VALUE(rv_less) TYPE /gicom/abap_bool.

    CLASS-METHODS get_intervals_agrmt_validity
      IMPORTING
        iv_settlement_period      TYPE /gicom/settling_period
        iv_agrmt_valid_from       TYPE /gicom/date
        iv_agrmt_valid_to         TYPE /gicom/date
      RETURNING
        VALUE(rt_agrmt_intervals) TYPE /gicom/cc_settle_calendar_tt.

    CLASS-METHODS get_interval_standard_dates
      IMPORTING
        iv_settlement_period     TYPE /gicom/settling_period
        iv_agrmt_valid_from      TYPE /gicom/date
        iv_agrmt_valid_to        TYPE /gicom/date
      RETURNING
        VALUE(rt_interval_dates) TYPE /gicom/interval_dates_tt.

endinterface.
