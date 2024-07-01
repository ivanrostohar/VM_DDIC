CLASS /gicom/cl_util_time_date DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    TYPES:
      "! Rounding mode for date rounding. Possible values:<br>
      "! - round_up<br>
      "! - round_off<br>
      BEGIN OF ENUM t_rounding_mode,
        round_up,
        round_off,
      END OF ENUM t_rounding_mode .
    CONSTANTS c_ultimo TYPE /gicom/date VALUE '99991231' ##NO_TEXT.
    CONSTANTS:
      BEGIN OF c_time_range_comp,
        equal       TYPE /gicom/cmp_time_range VALUE 0,
        inside      TYPE /gicom/cmp_time_range VALUE 1,
        overlapping TYPE /gicom/cmp_time_range VALUE 2,
        independent TYPE /gicom/cmp_time_range VALUE 3,
      END OF c_time_range_comp .
    CONSTANTS:
      BEGIN OF c_type_time_add,
        day   TYPE /gicom/type_time_add VALUE 'D',
        week  TYPE /gicom/type_time_add VALUE 'W',
        month TYPE /gicom/type_time_add VALUE 'M',
        year  TYPE /gicom/type_time_add VALUE 'Y',
      END OF c_type_time_add .

    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO /gicom/if_util_time_date.

    CLASS-METHODS inject_instance
      IMPORTING
        io_instance TYPE REF TO /gicom/if_util_time_date.

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

  PROTECTED SECTION.

  PRIVATE SECTION.
    CLASS-METHODS: add_time_to_date_int
      IMPORTING
        iv_date        TYPE /gicom/date
        iv_add         TYPE dec_25
        iv_type        TYPE /gicom/type_time_add
      RETURNING
        VALUE(rv_date) TYPE /gicom/date
      RAISING
        cx_fdt_conversion.

    CLASS-METHODS: add_time_to_month_int
      IMPORTING
        iv_date        TYPE /gicom/date
        iv_add         TYPE dec_25
      RETURNING
        VALUE(rv_date) TYPE /gicom/date.

    CLASS-METHODS: subtract_time_from_date_int
      IMPORTING
        iv_date        TYPE /gicom/date
        iv_subtract    TYPE dec_25
        iv_type        TYPE /gicom/type_time_add
      RETURNING
        VALUE(rv_date) TYPE /gicom/date
      RAISING
        cx_fdt_conversion.

    CLASS-METHODS: change_diff_for_leap_year
      IMPORTING
        iv_start_date TYPE /gicom/date
        iv_end_date   TYPE /gicom/date
        iv_add        TYPE /gicom/abap_bool DEFAULT ''
      CHANGING
        cv_days       TYPE decfloat34.

    CLASS-METHODS: get_components
      IMPORTING
        iv_date  TYPE /gicom/date
      EXPORTING
        ev_year  TYPE char4
        ev_month TYPE char2
        ev_day   TYPE char2.

*    CLASS-DATA st_leap_year_cache TYPE tt_leap_year_cache.
    CLASS-DATA st_time_to_date_cache TYPE tt_time_to_date_cache.
    CLASS-DATA so_instance TYPE REF TO /gicom/if_util_time_date.

ENDCLASS.



CLASS /GICOM/CL_UTIL_TIME_DATE IMPLEMENTATION.


  METHOD get_components.

    ev_year   = iv_date(4).
    ev_month  = iv_date+4(2).
    ev_day    = iv_date+6(2).

  ENDMETHOD.


  METHOD is_greater_than.

    /gicom/cl_util_time_date=>get_components(
      EXPORTING
        iv_date   = iv_date1
      IMPORTING
        ev_year   = DATA(lv_year1)
        ev_month  = DATA(lv_month1)
        ev_day    = DATA(lv_day1)
    ).

    /gicom/cl_util_time_date=>get_components(
      EXPORTING
        iv_date   = iv_date2
      IMPORTING
        ev_year   = DATA(lv_year2)
        ev_month  = DATA(lv_month2)
        ev_day    = DATA(lv_day2)
    ).

    IF ( lv_year1 > lv_year2 ) OR
       ( ( lv_year1 = lv_year2 ) AND ( lv_month1 > lv_month2 ) ) OR
       ( ( lv_year1 = lv_year2 ) AND ( lv_month1 = lv_month2 ) AND ( lv_day1 > lv_day2 ) ).

      rv_greater = abap_true.

    ELSE.

      rv_greater = abap_false.

    ENDIF.

  ENDMETHOD.


  METHOD is_less_than.

    /gicom/cl_util_time_date=>get_components(
      EXPORTING
        iv_date   = iv_date1
      IMPORTING
        ev_year   = DATA(lv_year1)
        ev_month  = DATA(lv_month1)
        ev_day    = DATA(lv_day1)
    ).

    /gicom/cl_util_time_date=>get_components(
      EXPORTING
        iv_date   = iv_date2
      IMPORTING
        ev_year   = DATA(lv_year2)
        ev_month  = DATA(lv_month2)
        ev_day    = DATA(lv_day2)
    ).

    IF ( lv_year1 < lv_year2 ) OR
       ( ( lv_year1 = lv_year2 ) AND ( lv_month1 < lv_month2 ) ) OR
       ( ( lv_year1 = lv_year2 ) AND ( lv_month1 = lv_month2 ) AND ( lv_day1 < lv_day2 ) ).

      rv_less = abap_true.

    ELSE.

      rv_less = abap_false.

    ENDIF.

  ENDMETHOD.


  METHOD subtract_time_from_date_int.
    DATA lv_calc_date   TYPE begda.

    DATA(ls_timepoint) = VALUE fdt_s_timepoint( ).
    ls_timepoint-date = iv_date.
    CASE iv_type.
      WHEN 'D'.
        lv_calc_date = cl_fdt_date_time=>get_instance( )->subtract_day(
          is_timepoint = ls_timepoint
          iv_number    = CONV #( iv_subtract ) )-date.

        rv_date = lv_calc_date.

      WHEN 'W'.
        rv_date = /gicom/cl_util_time_date=>subtract_time_from_date_int(
               iv_date       = iv_date
               iv_subtract   = iv_subtract * 7
               iv_type       = 'D'
             ).

      WHEN 'M'.
        rv_date = cl_fdt_date_time=>get_instance( )->subtract_mon(
          is_timepoint = ls_timepoint
          iv_number    = CONV #( iv_subtract ) )-date.

      WHEN 'Y'.
        rv_date =  cl_fdt_date_time=>get_instance( )->subtract_ann(
          is_timepoint = ls_timepoint
          iv_number    = CONV #( iv_subtract ) )-date.

      WHEN OTHERS.

    ENDCASE.
    "END M.22617
  ENDMETHOD.


  METHOD add_time_to_date_int.

    ASSIGN /gicom/cl_util_time_date=>st_time_to_date_cache[
      KEY primary_key
      start_date = iv_date
      add_time   = iv_add
      add_type   = iv_type
    ] TO FIELD-SYMBOL(<ls_time_to_date_cache>).

    IF <ls_time_to_date_cache> IS ASSIGNED.
      rv_date = <ls_time_to_date_cache>-end_date.
      RETURN.
    ENDIF.



    "MOD MF 03.05.2022 M.22617
    DATA: ls_timepoint TYPE fdt_s_timepoint.
    ls_timepoint-date = iv_date.

    CASE iv_type.
      WHEN 'D'.
        rv_date = cl_fdt_date_time=>get_instance( )->add_day(
                    is_timepoint      = ls_timepoint
                    iv_number         = CONV #( iv_add ) )-date.

      WHEN 'W'.
        rv_date = /gicom/cl_util_time_date=>add_time_to_date_int(
          iv_date = iv_date
          iv_add  = iv_add * 7
          iv_type = 'D'
        ).

      WHEN 'M'.
        rv_date = /gicom/cl_util_time_date=>add_time_to_month_int(
          iv_date = iv_date
          iv_add  = iv_add
        ).

      WHEN 'Y'.
        rv_date =  cl_fdt_date_time=>get_instance( )->add_ann(
                     is_timepoint      = ls_timepoint
                     iv_number         = CONV #( iv_add ) )-date.

      WHEN OTHERS.

    ENDCASE.
    "END M.22617



    INSERT VALUE #(
      start_date = iv_date
      add_time   = iv_add
      add_type   = iv_type
      end_date   = rv_date
    ) INTO TABLE /gicom/cl_util_time_date=>st_time_to_date_cache.


  ENDMETHOD.


  METHOD add_date_diff_to_date.
    "INS M.20073 + 20107 DV20210209
    IF iv_date_to = c_ultimo.
      "Ultimo result is ultimo :-)
      rv_date = c_ultimo.
      EXIT.
    ENDIF.

    IF   ( /gicom/cl_util_time_date=>is_first_date_of_year( iv_date_from ) = abap_true AND
           /gicom/cl_util_time_date=>is_first_date_of_year( iv_date_to ) = abap_true )

      OR ( /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_from ) = abap_true AND
           /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_to ) = abap_true ).
      "<<INS KJ_M.18925
      "year
      ev_type = 'Y'.
      ev_add = /gicom/cl_util_time_date=>get_year_difference(
             iv_start_date = iv_date_from
             iv_end_date   = iv_date_to
         ).

*    ELSEIF /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_from ) = abap_true "DEL KJ_M.18925
*    AND /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to ) = abap_true.      "DEL KJ_M.18925
      ">>INS KJ_M.18925
    ELSEIF ( /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_from ) = abap_true AND
             /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_to ) = abap_true )

      OR   ( /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_from ) = abap_true AND
             /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to ) = abap_true )

      "<<INS KJ_M.18925
      "INS M.20685 DV 04.05.2021 Add new special case -> one month validity
      OR   ( /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_from ) = abap_true AND
             /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to ) = abap_true ).

      "month
      ev_type = 'M'.
      ev_add = /gicom/cl_util_time_date=>get_month_difference(
                  iv_start_date = iv_date_from
                  iv_end_date   = iv_date_to
              ).

    ELSE.
      "day
      " 02.01.1999 - 05.03.2005 => ( 2000, 2004) (+2) => 710
      "  iv_date_add  01.03.2004 2008 (1)
      ev_type = 'D'.
      DATA(lv_add) = /gicom/cl_util_time_date=>get_day_difference(
                  iv_start_date = iv_date_from
                  iv_end_date   = iv_date_to
              ).

      "first we need to check if there is there was a leap year (then we subtract the days)
      /gicom/cl_util_time_date=>change_diff_for_leap_year(
        EXPORTING
          iv_start_date = iv_date_from
          iv_end_date   = iv_date_to
        CHANGING
          cv_days =  lv_add
       ).

      rv_date = /gicom/cl_util_time_date=>add_time_to_date(
                  iv_date            = iv_date_add
                  iv_add             = CONV #( lv_add )
                  iv_type            = ev_type
                  iv_check_begin_end = iv_check_begin_end "CHG KJ_M.18925
                  iv_pre_date_from  = iv_date_from        "INS M.20685 DV 20.04.2021
                  iv_pre_date_to    = iv_date_to          "INS M.20685 DV 20.04.2021
      ).

      "then we need to check if there will be a leap year (then we add the days)
      /gicom/cl_util_time_date=>change_diff_for_leap_year(
        EXPORTING
          iv_start_date = iv_date_from
          iv_end_date   = rv_date
          iv_add        = abap_true
        CHANGING
          cv_days =  lv_add
      ).
      ev_add = lv_add.

      "ToDo? week
    ENDIF.


*** Add difference
**********************************************************************
    rv_date = /gicom/cl_util_time_date=>add_time_to_date(
                  iv_date            = iv_date_add
                  iv_add             = ev_add
                  iv_type            = ev_type
                  iv_check_begin_end = iv_check_begin_end "CHG KJ_M.18925
                  iv_pre_date_from  = iv_date_from        "INS M.20685 DV 20.04.2021
                  iv_pre_date_to    = iv_date_to          "INS M.20685 DV 20.04.2021
              ).

    ev_add  = rv_date - iv_date_add.

  ENDMETHOD.


  METHOD add_time_to_date.
    CHECK iv_date IS NOT INITIAL.

    DATA: ls_timepoint        TYPE fdt_s_timepoint.

    IF iv_date NE '99991231'.

      "ls_timepoint-date = iv_date.
      TRY.

          rv_date = /gicom/cl_util_time_date=>add_time_to_date_int(
            iv_date = iv_date
            iv_add  = iv_add
            iv_type = iv_type
          ).

        CATCH cx_fdt_conversion INTO DATA(lx_err).
          " This exception typically occurs when there was on overflow in the date.
          rv_date = '99991231'.
      ENDTRY.
      "Special case: Adding to end of month --> expecting end of month (e.g. 28.02 + 1 -> 31.03)
      IF ( NOT ( iv_type = 'D' OR iv_type = 'W' )
            OR iv_check_begin_end = abap_true ).

        IF /gicom/cl_util_time_date=>is_last_date_of_month( iv_date ) = abap_true.
          rv_date =  /gicom/cl_util_time_date=>get_last_date_of_month( rv_date ).
        ENDIF.

      ENDIF.

      "INS M.20685 DV 20.04.2021
      "INS M.20073 + 20107 DV20210209
      "Special case: When source is first day and last day, target should be similar
      IF /gicom/cl_util_time_date=>is_first_date_of_month( iv_pre_date_from ) = abap_true AND
         /gicom/cl_util_time_date=>is_last_date_of_month( iv_pre_date_to ) = abap_true.
        "in case of overlapping to the next but wrong month
        rv_date = rv_date - 5.
        rv_date = /gicom/cl_util_time_date=>get_last_date_of_month( rv_date ).
      ENDIF.


    ELSE.
      rv_date = '99991231'.
    ENDIF.

  ENDMETHOD.


  METHOD add_time_to_timestamp.
    CASE iv_scale.
      WHEN 'S'.
        rv_timestamp = cl_abap_tstmp=>add_to_short( tstmp = iv_timestamp secs = iv_add ).
      WHEN 'M'.
        rv_timestamp = cl_abap_tstmp=>add_to_short( tstmp = iv_timestamp secs = iv_add * 60 ).
      WHEN 'H'.
        rv_timestamp = cl_abap_tstmp=>add_to_short( tstmp = iv_timestamp secs = iv_add * 60 * 60 ).
      WHEN 'D'.
        rv_timestamp = cl_abap_tstmp=>add_to_short( tstmp = iv_timestamp secs = iv_add * 60 * 60 * 24 ).
      WHEN 'W'.
        rv_timestamp = cl_abap_tstmp=>add_to_short( tstmp = iv_timestamp secs = iv_add * 60 * 60 * 24 * 7 ).
      WHEN 'MO'.
        /gicom/cl_util_time_date=>convert_time_stamp(
          EXPORTING
            iv_time_stamp            = iv_timestamp
            iv_time_zone             = iv_timezone
          IMPORTING
            ev_date                  = DATA(lv_date)
            ev_time                  = DATA(lv_time)
        ).

        DATA(lv_new_date) = /gicom/cl_util_time_date=>add_time_to_date(
          EXPORTING
            iv_date            =     lv_date
            iv_add             =     iv_add
            iv_type            =     'M'
        ).

        CONVERT DATE lv_new_date TIME lv_time INTO TIME STAMP rv_timestamp TIME ZONE iv_timezone.
    ENDCASE.
  ENDMETHOD.


  METHOD compare_time_ranges.
**********************************************************************
* Mantis: 15095
*         Compare two time ranges and return their temporal relation
*         to each other.
*
* Date:   08.08.2018
* Author: Timm Gebhart
**********************************************************************

    IF iv_from_1 IS INITIAL OR
       iv_to_1   IS INITIAL OR
       iv_from_2 IS INITIAL OR
       iv_to_2   IS INITIAL.

      RAISE EXCEPTION TYPE /gicom/cx_invalid_arguments.

    ENDIF.

    IF iv_from_1 > iv_to_1 OR
       iv_from_2 > iv_to_2.

      RAISE EXCEPTION TYPE /gicom/cx_invalid_arguments " MOD DD 24.03.2021 M.20493
                   MESSAGE e004(/gicom/msg_agrmnt_01).

    ENDIF.

    IF iv_to_1 < iv_from_2 OR
       iv_to_2 < iv_from_1.

      rv_result = c_time_range_comp-independent.
      RETURN.

    ENDIF.

    IF iv_from_1 = iv_from_2.

      IF iv_to_1 = iv_to_2.
        rv_result = c_time_range_comp-equal.
      ELSEIF iv_to_1 < iv_to_2.
        rv_result = c_time_range_comp-overlapping.
      ELSEIF iv_to_1 > iv_to_2.
        rv_result = c_time_range_comp-inside.
      ENDIF.

    ELSEIF iv_from_1 < iv_from_2.

      IF iv_to_1 = iv_to_2.
        rv_result = c_time_range_comp-inside.
      ELSEIF iv_to_1 < iv_to_2.
        rv_result = c_time_range_comp-overlapping.
      ELSEIF iv_to_1 > iv_to_2.
        rv_result = c_time_range_comp-inside.
      ENDIF.

    ELSE.

      rv_result = c_time_range_comp-overlapping.

    ENDIF.

  ENDMETHOD.


  METHOD convert_date.

    CONVERT DATE iv_date
            INTO TIME STAMP ev_time_stamp TIME ZONE /gicom/cl_util_time_date=>get_current_timezone( ).
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/BS_GENERAL'
        TYPE 'E'
        NUMBER 001
        WITH sy-subrc.
    ENDIF.

*    CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
*      EXPORTING
*        date_internal = iv_date
*      IMPORTING
*        date_external = ev_date_ext.

*    /gicom/cl_sap_conversion=>convert_date_to_external(
*      EXPORTING
*        iv_date_internal = iv_date
*      IMPORTING
*        ev_date_external = ev_date_ext ).

    TRY.
        /gicom/cl_sap_conversion=>convert_date_to_external(
          EXPORTING
            iv_date_internal = iv_date
          IMPORTING
            ev_date_external = ev_date_ext ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lo_ex ).

    ENDTRY.

  ENDMETHOD.


  METHOD convert_date_time_to_timestamp.
    IF iv_date IS INITIAL.
      DATA(lv_time_stamp_tmp) = /gicom/cl_util_time_date=>get_time_stamp( ).
      CONVERT TIME STAMP lv_time_stamp_tmp TIME ZONE iv_timezone INTO DATE DATA(lv_date).
    ELSE.
      lv_date = iv_date.
    ENDIF.

    IF iv_time IS INITIAL.
      CONVERT DATE lv_date INTO TIME STAMP rv_time_stamp TIME ZONE iv_timezone.
    ELSE.
      CONVERT DATE lv_date TIME iv_time INTO TIME STAMP rv_time_stamp TIME ZONE iv_timezone.
    ENDIF.
  ENDMETHOD.


  METHOD convert_date_to_local_string.

*    CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
*      EXPORTING
*        date_internal = iv_date
*      IMPORTING
*        date_external = ev_date.

*    /gicom/cl_sap_conversion=>convert_date_to_external(
*      EXPORTING
*        iv_date_internal = iv_date
*      IMPORTING
*        ev_date_external = ev_date ).

    TRY.
        /gicom/cl_sap_conversion=>convert_date_to_external(
          EXPORTING
            iv_date_internal = iv_date
          IMPORTING
            ev_date_external = ev_date ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lo_ex ).

    ENDTRY.

  ENDMETHOD.


  METHOD convert_time_stamp.

    IF iv_time_zone IS NOT INITIAL.
      DATA(lv_time_zone) = iv_time_zone.
    ELSE.
      lv_time_zone = sy-zonlo.
    ENDIF.

    CONVERT TIME STAMP iv_time_stamp TIME ZONE lv_time_zone
        INTO DATE ev_date TIME ev_time.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/BS_GENERAL'
        TYPE 'E'
        NUMBER 001
        WITH sy-subrc.
    ENDIF.

*    CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
*      EXPORTING
*        date_internal = ev_date
*      IMPORTING
*        date_external = ev_date_ext.

*    /gicom/cl_sap_conversion=>convert_date_to_external(
*      EXPORTING
*        iv_date_internal = ev_date
*      IMPORTING
*        ev_date_external = ev_date_ext ).

    TRY.
        /gicom/cl_sap_conversion=>convert_date_to_external(
          EXPORTING
            iv_date_internal = ev_date
          IMPORTING
            ev_date_external = ev_date_ext ).

      CATCH /gicom/cx_sap_call_error INTO DATA(lo_ex).
        RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lo_ex ).

    ENDTRY.

    WRITE ev_time TO ev_time_ext USING EDIT MASK '__:__:__'.

  ENDMETHOD.


  METHOD convert_ymd_to_date.
    IF iv_year IS NOT INITIAL.
      IF iv_month IS NOT INITIAL.
        IF iv_day IS NOT INITIAL.
          CONCATENATE iv_year iv_month iv_day INTO rv_date.
        ELSE.
          CONCATENATE iv_year iv_month '01' INTO rv_date.
        ENDIF.
      ELSE.
        CONCATENATE iv_year '01' '01' INTO rv_date.
      ENDIF.
    ELSE.
      RAISE EXCEPTION NEW /gicom/cx_invalid_arguments( )."it makes no sense to call us without a year, lol
    ENDIF.
  ENDMETHOD.


  METHOD get_current_timezone.
    TRY.
        DATA(ls_user_details) = NEW /gicom/cl_util_user( )->user_details(
            iv_user = /gicom/cl_system=>get_username( )
        ).

      CATCH /gicom/cx_internal_error.
        " This might happen if the user is not authorized to read user details,
        " so we need a proper fallback here.
        rv_timezone = sy-zonlo.

    ENDTRY.

    IF ls_user_details-logondata-tzone IS NOT INITIAL.
      rv_timezone = ls_user_details-logondata-tzone.
    ELSE.
*      CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
*        IMPORTING
*          timezone = rv_timezone
*        EXCEPTIONS
*          OTHERS   = 999.

*      /gicom/cl_sap_datetime=>get_system_timezone(
*         IMPORTING
*           ev_timezone = rv_timezone
*         EXCEPTIONS
*           OTHERS   = 999 ).

      TRY.
          /gicom/cl_sap_datetime=>get_system_timezone(
             IMPORTING
               ev_timezone = rv_timezone ).

        CATCH /gicom/cx_sap_call_error.
          " no exception just default in error case
          CLEAR rv_timezone.

      ENDTRY.
    ENDIF.

    " Super fallback in case anything breaks
    IF rv_timezone IS INITIAL.
      " Why is this not sy-zonlo?
      rv_timezone = 'UTC'.
    ENDIF.
  ENDMETHOD.


  METHOD get_day_difference.

    DATA: ls_start_timepoint TYPE fdt_s_timepoint,
          ls_end_timepoint   TYPE fdt_s_timepoint.

    ls_start_timepoint-date = iv_start_date.
    ls_end_timepoint-date = iv_end_date.

*    CALL FUNCTION 'DAYS_BETWEEN_TWO_DATES'
*      EXPORTING
*        i_datum_bis = iv_end_date
*        i_datum_von = iv_start_date
*      IMPORTING
*        e_tage      = rv_days.
*
*    "" Commented out during delivery procedure because there is no package interface
*    rv_days = cl_fdt_date_time=>get_instance( )->difference_day(
*                                                    is_timepoint1     = ls_start_timepoint
*                                                    is_timepoint2     = ls_end_timepoint
*                                                ).

    DATA lv_timestamp_start_s TYPE string.
    DATA lv_timestamp_end_s   TYPE string.

    DATA lv_timestamp_start TYPE /gicom/timestmps.
    DATA lv_timestamp_end   TYPE /gicom/timestmps.

    CONCATENATE iv_start_date '000000' '.' '0000000' INTO lv_timestamp_start_s.
    CONCATENATE iv_end_date   '000000' '.' '0000000' INTO lv_timestamp_end_s.

    lv_timestamp_start  = lv_timestamp_start_s.
    lv_timestamp_end    = lv_timestamp_end_s.

    CALL METHOD cl_abap_tstmp=>subtract
      EXPORTING
        tstmp1 = lv_timestamp_end
        tstmp2 = lv_timestamp_start
      RECEIVING
        r_secs = DATA(lv_diff).

    rv_days = abs( lv_diff / 60 / 60 / 24 ). "Convert seconds to days

    TYPES: BEGIN OF ts_month_day_count,
             month TYPE i,
             count TYPE i,
           END OF ts_month_day_count,

           tt_month_day_count TYPE STANDARD TABLE OF ts_month_day_count WITH NON-UNIQUE KEY table_line.


    DATA(lv_year_dif)   = CONV i( iv_end_date+0(4) ) - CONV i( iv_start_date+0(4) ).
    DATA(lv_month_start)  = CONV i( iv_end_date+4(2) ) - CONV i( iv_start_date+4(2) ).
    DATA(lv_day_start)    = CONV i( iv_end_date+6(2) ) - CONV i( iv_start_date+6(2) ).


    "DEL TL 04.02.2022 this has not to be done here
    "INS M.20073 05.01.2021 Dirk Voigt Clear gap days
*    IF iv_end_date NE '99991231'.
*      DATA(lv_check_year) = iv_start_date.
*      WHILE lv_check_year < iv_end_date.
*        IF lv_check_year+0(4) = iv_end_date+0(4) AND
*           ( iv_end_date+4(4) < 229 OR
*             lv_check_year+4(4) > 228 ).
*          EXIT. "Same year and gap day not within
*        ENDIF.
*
*        IF lv_check_year+0(4) MOD 400 = 0.
*          rv_days = rv_days - 1.
*        ELSEIF lv_check_year+0(4) MOD 4 = 0 AND lv_check_year+2(2) <> '00'.
*          rv_days = rv_days - 1.
*        ENDIF.
*
*        lv_check_year+0(4) = lv_check_year+0(4) + 1.
*      ENDWHILE.
*    ENDIF.
    "END M.20073
    "END TL
  ENDMETHOD.


  METHOD get_first_date_of_week.

    CONCATENATE iv_year iv_week INTO DATA(lv_year_week_o).

    "This is the content of cl_scal_utils=>get_first_date_of_week
    "The method is not supported on H03...

    DATA lv_year_week TYPE kweek.

    IF lv_year_week_o IS INITIAL.
      CONCATENATE iv_year iv_week INTO lv_year_week.
    ELSE.
      lv_year_week = lv_year_week_o.
    ENDIF.

    CALL FUNCTION 'WEEK_GET_FIRST_DAY'
      EXPORTING
        week         = lv_year_week
      IMPORTING
        date         = rv_date
      EXCEPTIONS
        week_invalid = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_illegal_arguments( ).
    ENDIF.

  ENDMETHOD.


  METHOD get_last_date_of_half.
    CHECK iv_date IS NOT INITIAL.
    rv_date = iv_date.
    IF rv_date+4(2) <= 6.
      rv_date+4(2) = '06'.
      rv_date+6(2) = '30'.
    ELSE.
      rv_date+4(2) = '12'.
      rv_date+6(2) = '31'.
    ENDIF.
  ENDMETHOD.


  METHOD get_last_date_of_month.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   12.01.2017
**  Mantis:
**
**  Description:
**    Calculating last date of month for a given date
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************
    CHECK iv_date IS NOT INITIAL.

    " The SAP function will break horribly if we would pass that date, so we handle it internally.
    IF iv_date = '99991231'.
      rv_date = iv_date.
      RETURN.
    ENDIF.

    DATA: ls_timepoint TYPE fdt_s_timepoint.
    ls_timepoint-date = iv_date.
    ls_timepoint-date+6(2) = '01'.

***********************************************************************************************************
*** 1. Calculating date
***********************************************************************************************************

    "" Replaced because of no package interface
*    DATA(ls_timepoint2) = cl_fdt_date_time=>get_instance( )->add_mon(
*                       is_timepoint      = ls_timepoint
*                       iv_number         = 1 ).

    rv_date = /gicom/cl_util_time_date=>add_time_to_date_int(
      iv_date = ls_timepoint-date
      iv_type = 'M'
      iv_add = 1
    ).

    "" Replaced because of no package interface
*    rv_date = cl_fdt_date_time=>get_instance( )->add_day(
*                     is_timepoint      = ls_timepoint2
*                     iv_number         = -1 )-date.

    rv_date = /gicom/cl_util_time_date=>add_time_to_date(
      iv_date = rv_date
      iv_type = 'D'
      iv_add = -1
    ).

  ENDMETHOD.


  METHOD get_last_date_of_quarter.
    CHECK iv_date IS NOT INITIAL.
    rv_date = iv_date.
    IF rv_date+4(2) <= 9.
      IF rv_date+4(2) <= 6.
        IF rv_date+4(2) <= 3.
          rv_date+4(2) = '03'.
          rv_date+6(2) = '31'.
        ELSE.
          rv_date+4(2) = '06'.
          rv_date+6(2) = '30'.
        ENDIF.
      ELSE.
        rv_date+4(2) = '09'.
        rv_date+6(2) = '30'.
      ENDIF.
    ELSE.
      rv_date+4(2) = '12'.
      rv_date+6(2) = '31'.
    ENDIF.
  ENDMETHOD.


  METHOD get_last_date_of_third.
    CHECK iv_date IS NOT INITIAL.
    rv_date = iv_date.
    IF rv_date+4(2) <= 8.
      IF rv_date+4(2) <= 4.
        rv_date+4(2) = '03'.
        rv_date+6(2) = '31'.
      ELSE.
        rv_date+4(2) = '09'.
        rv_date+6(2) = '30'.
      ENDIF.
    ELSE.
      rv_date+4(2) = '12'.
      rv_date+6(2) = '31'.
    ENDIF.
  ENDMETHOD.


  METHOD get_last_date_of_week.
    CHECK iv_date IS NOT INITIAL.
    /gicom/cl_sap_datetime=>get_week_info_based_on_date(
      EXPORTING
        iv_date        = iv_date
      IMPORTING
*        ev_date_monday =
        ev_date_sunday = rv_date
*        ev_week        =
    ).
  ENDMETHOD.


  METHOD get_last_date_of_year.
    CHECK iv_date IS NOT INITIAL.
    rv_date = iv_date.
    rv_date+4(2) = '12'.
    rv_date+6(2) = '31'.
  ENDMETHOD.


  METHOD get_month_difference.

    DATA: ls_start_timepoint TYPE fdt_s_timepoint,
          ls_end_timepoint   TYPE fdt_s_timepoint.

    ls_start_timepoint-date = iv_start_date.
    ls_end_timepoint-date = iv_end_date.

    rv_months = cl_fdt_date_time=>get_instance( )->difference_mon(
                                                    is_timepoint1     = ls_start_timepoint
                                                    is_timepoint2     = ls_end_timepoint
                                                ).

  ENDMETHOD.


  METHOD get_quarter.

    DATA(lv_month) = iv_date+4(2).
    DATA(lv_month_i) = CONV i( lv_month ) - 1.

    rv_quarter = 1 + floor( lv_month_i / 3 ).


    " Commented out during delivery procedure because there is no package interface
*    DATA ls_timepoint TYPE if_fdt_types=>element_timepoint .
*
*    ls_timepoint-date = iv_date.
*
*    rv_quarter = cl_fdt_date_time=>get_part_quarter(
*      is_timepoint = ls_timepoint
*    ).
  ENDMETHOD.


  METHOD get_time_stamp.

    "Really is current time. pls trust (GET TIME is not required)

    GET TIME STAMP FIELD rv_time_stamp.

  ENDMETHOD.


  METHOD get_weekday.

    "Copied from DATE_CALCULATE_DAY

    DATA: day_p TYPE p.

    day_p = iv_date MOD 7.

    IF day_p > 1.
      day_p = day_p - 1.
    ELSE.
      day_p = day_p + 6.
    ENDIF.
    rv_weekday = day_p.

    " Commented out during delivery procedure because there is no package interface
*    DATA ls_timepoint TYPE if_fdt_types=>element_timepoint .
*
*    ls_timepoint-date = iv_date.
*
*    rv_weekday = cl_fdt_date_time=>get_day_of_week(
*      is_timepoint = ls_timepoint
*    ).
  ENDMETHOD.


  METHOD get_week_iso.

    DATA ls_timepoint TYPE if_fdt_types=>element_timepoint .

    ls_timepoint-date = iv_date.

*    DATA lv_first_week_day  TYPE i.
*    DATA lv_begin_year_date TYPE /gicom/date.
*    DATA lv_start_date      TYPE /gicom/date.
*    DaTA lv_char_2          TYPE char2.
*    DATA lv_count_week_conv TYPE char2.
*
*    DATA(lv_year)   = CONV i( iv_date+0(4) ).
*    DATA(lv_month)  = CONV i( iv_date+4(2) ).
*    DATA(lv_day)    = CONV i( iv_date+6(2) ).
*
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "" Check if we need the week number for this year or the year before
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    lv_begin_year_date = |{ lv_year }0101|.
*
*    DATA(lv_weekday) = /gicom/cl_util_time_date=>get_weekday(
*      iv_date = lv_begin_year_date
*    ).
*
*    DATA(lv_day_first_week) = 1 + ( ( 7 - ( lv_weekday - 1 ) ) MOD 7 ).
*
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "" The first already begun week is part of the last year. So we calculate
*    "" it this way:
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    IF lv_month = 1 AND lv_day < lv_day_first_week.
*
*      DATA(lv_date_prev_year) = CONV /gicom/date( |{ lv_year - 1 }1231| ).
*
*      rv_year_week = /gicom/cl_util_time_date=>get_week_iso(
*        iv_date = lv_date_prev_year
*      ).
*
*      RETURN.
*    ENDIF.
*
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "" Determine Day Difference
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    lv_char_2 = lv_day_first_week.
*
*    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*      EXPORTING
*        input  = lv_char_2
*      IMPORTING
*        output = lv_char_2.
*
*    lv_start_date = |{ lv_year }01{ lv_char_2 }|.
*
*    DATA(lv_day_difference) = /gicom/cl_util_time_date=>get_day_difference(
*      iv_start_date = lv_start_date
*      iv_end_date   = iv_date
*    ).
*
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "" Calculate additional week count
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    DATA(lv_count_weeks) = 1 + FLOOR( lv_day_difference / 7 ).
*
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    "" Output
*    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*
*    lv_count_week_conv = lv_count_weeks.
*
*    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*      EXPORTING
*        input  = lv_count_week_conv
*      IMPORTING
*        output = lv_count_week_conv.
**
*    DATA lv_return TYPE string.
*
*    rv_year_week = |{ lv_year }{ lv_count_week_conv }|.

    "Package Interface not available
    cl_fdt_date_time=>get_part_weeks(
    EXPORTING
      is_timepoint = ls_timepoint
    IMPORTING
      ev_year_week = rv_year_week
    ).

  ENDMETHOD.


  METHOD get_where_clause_time.

**********************************************************************************************************
*** 1. Setup where clause
***********************************************************************************************************
    DATA: lv_where_time_low  TYPE string,
          lv_where_time_high TYPE string.

    "******************************************************************************************************
    "*** 1.0 Extract date from and date to into separate vars
    "******************************************************************************************************
    DATA(lv_year_low)   = iv_date_from(4).
    DATA(lv_month_low)  = iv_date_from+4(2).
    DATA(lv_day_low)    = iv_date_from+6(2).
    "******************************************************************************************************
    DATA(lv_year_high)   = iv_date_to(4).
    DATA(lv_month_high)  = iv_date_to+4(2).
    DATA(lv_day_high)    = iv_date_to+6(2).


    "******************************************************************************************************
    "*** If same year no interval just range selection
    "******************************************************************************************************
    IF lv_year_high = lv_year_low AND
       lv_month_low             = '01' AND lv_day_low  = '01' AND
       lv_month_high            = '12' AND lv_day_high = '31' AND
       iv_no_interval_same_year = abap_true.

      DATA(lv_where) = ' alias~time_year = ''' && lv_year_low && ''''.
      REPLACE ALL OCCURRENCES OF 'alias' IN lv_where WITH iv_alias_time_ref.
      rv_where_clause = lv_where.

      "************************************************************************************************
      "***  In case of path expressions for cds associations
      "************************************************************************************************
      IF iv_alias_time_ref CS '\_'.
        REPLACE ALL OCCURRENCES OF '~' IN rv_where_clause WITH '-'.
      ENDIF.

      RETURN.

    ENDIF.


    "******************************************************************************************************
    "*** 1.1 Time interval low
    "******************************************************************************************************

    lv_where_time_low = ' alias~time_date >= ''' && iv_date_from && ''''.

*    IF lv_month_low = '01' AND lv_day_low = '01'.
*      lv_where_time_low = ' alias~time_year >= ''' && lv_year_low && ''''.
*    ELSEIF lv_month_low NE '01' AND lv_day_low = '01'.
*      lv_where_time_low = ' alias~time_year >= ''' && lv_year_low && ''' AND alias~time_month >= ''' && lv_month_low && ''''.
*    ELSE.
*      lv_where_time_low = ' alias~time_year >= ''' && lv_year_low && ''' AND alias~time_month >= ''' && lv_month_low && ''' AND alias~time_day >= ''' && lv_day_low && ''''.
*    ENDIF.

    "******************************************************************************************************
    "*** 1.2 Time interval high
    "******************************************************************************************************

    lv_where_time_high = ' alias~time_date <= ''' && iv_date_to && ''''.
*    IF lv_month_high = '12' AND lv_day_high = '31'.
*      lv_where_time_high = ' alias~time_year <= ''' && lv_year_high && ''''.
*    ELSEIF iv_date_to = /gicom/cl_util_time_date=>get_last_date_of_month( iv_date = iv_date_to ).
*      " last day of month
*      lv_where_time_high = ' alias~time_year <= ''' && lv_year_high && ''' AND alias~time_month <= ''' && lv_month_high && ''''.
*    ELSE.
*      lv_where_time_high = ' alias~time_year <= ''' && lv_year_high && ''' AND alias~time_month <= ''' && lv_month_high && ''' AND alias~time_day <= ''' && lv_day_high && ''''.
*
*    ENDIF.


**********************************************************************************************************
*** 2. Return
***********************************************************************************************************

    CONCATENATE lv_where_time_low
                'AND'
                lv_where_time_high
                INTO rv_where_clause SEPARATED BY space.

    REPLACE ALL OCCURRENCES OF 'alias' IN rv_where_clause WITH iv_alias_time_ref.


***********************************************************************************************************************
***  In case of path expressions for cds associations
***********************************************************************************************************************
    IF iv_alias_time_ref CS '\_'.
      REPLACE ALL OCCURRENCES OF '~' IN rv_where_clause WITH '-'.
    ENDIF.

    IF iv_field_name IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF 'time_date' IN rv_where_clause WITH iv_field_name.
    ENDIF.


  ENDMETHOD.


  METHOD get_year_difference.

    DATA: ls_start_timepoint TYPE fdt_s_timepoint,
          ls_end_timepoint   TYPE fdt_s_timepoint.

    ls_start_timepoint-date = iv_start_date.
    ls_end_timepoint-date = iv_end_date.

    rv_years = cl_fdt_date_time=>get_instance( )->difference_ann(
                                                    is_timepoint1     = ls_start_timepoint
                                                    is_timepoint2     = ls_end_timepoint
                                                ).

  ENDMETHOD.


  METHOD is_15th_of_month.
    rv_result = xsdbool( iv_date+6(2) = '15' ).
  ENDMETHOD.


  METHOD is_first_date_of_month.
    rv_result = abap_false.

    IF iv_date+6(2) = '01'.
      rv_result = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD is_first_date_of_year.
    rv_result = abap_false.

    IF iv_date+4(4) = '0101'.
      rv_result = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD is_last_date_of_month.
    rv_result = abap_false.

    IF iv_date = /gicom/cl_util_time_date=>get_last_date_of_month( iv_date ).
      rv_result = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD is_last_date_of_year.
    rv_result = abap_false.

    IF iv_date+4(4) = '1231'.
      rv_result = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD is_leap_year.

    rv_is_leap_year = abap_false.

    IF iv_year MOD 4 <> 0.
      RETURN.
    ENDIF.

    IF iv_year MOD 100 = 0.
      IF iv_year MOD 400 = 0.
        rv_is_leap_year = abap_true.
      ENDIF.
    ELSE.
      rv_is_leap_year = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD round_to_month.
    DATA(lv_month) = iv_date+4(2).
    DATA(lv_year) = iv_date(4).
    DATA(lv_year_month) = |{ lv_year }{ lv_month }|.

    DATA(lv_date_month_before) = COND /gicom/date( WHEN lv_month = '01'
        THEN |{ COND #( WHEN lv_year = '0000' THEN '0001' ELSE lv_year ) - 1 }0131|
        ELSE |{ lv_year }{ CONV num02( lv_month - 1 ) }01|
    ).
    lv_date_month_before = /gicom/cl_util_time_date=>get_last_date_of_month( lv_date_month_before ).

    DATA(lv_date_month_after) = COND /gicom/date( WHEN lv_month = '12'
        THEN |{ COND #( WHEN lv_year = '9999' THEN '9998' ELSE lv_year ) + 1 }0101|
        ELSE |{ lv_year }{ CONV num02( lv_month + 1 ) }01|
    ).

    DATA(lv_days_before) = /gicom/cl_util_time_date=>get_day_difference(
      iv_start_date = lv_date_month_before
      iv_end_date   = iv_date
    ).

    DATA(lv_days_after) = /gicom/cl_util_time_date=>get_day_difference(
      iv_start_date = lv_date_month_after
      iv_end_date   = iv_date
    ).


    IF iv_round_mode = round_off.
      rv_year_month = COND char6( WHEN lv_days_before < lv_days_after
          THEN
              lv_date_month_before+0(6)
          ELSE
              lv_year_month+0(6)
      ).

    ELSEIF iv_round_mode = round_up.
      rv_year_month = COND char6( WHEN lv_days_before < lv_days_after
          THEN
              lv_year_month+0(6)
          ELSE
              lv_date_month_after+0(6)
      ).
    ENDIF.

  ENDMETHOD.


  METHOD round_to_year.
    DATA(lv_year) = iv_date(4).
    DATA(lv_date_year_before) = COND /gicom/date( WHEN lv_year <= '0001' THEN '00011231' ELSE |{ lv_year - 1 }1231| ).
    DATA(lv_date_year_after) = COND /gicom/date( WHEN lv_year = '9999' THEN '99990101' ELSE |{ CONV num4( lv_year + 1 ) }0101| ).

    DATA(lv_days_before) = /gicom/cl_util_time_date=>get_day_difference(
      iv_start_date = lv_date_year_before
      iv_end_date   = iv_date
    ).

    DATA(lv_days_after) = /gicom/cl_util_time_date=>get_day_difference(
      iv_start_date = lv_date_year_after
      iv_end_date   = iv_date
    ).

    IF iv_round_mode = round_up.
      rv_year = COND /gicom/year( WHEN lv_days_before < lv_days_after
          THEN
              lv_year
          ELSE
              lv_date_year_after(4)
      ).

    ELSEIF iv_round_mode = round_off.
      rv_year = COND /gicom/year( WHEN lv_days_before < lv_days_after
          THEN
              lv_date_year_before(4)
          ELSE
              lv_year
      ).
    ENDIF.

  ENDMETHOD.


  METHOD subtract_time_diff_from_date.
    ">>DEL KJ_M.18925
*    IF /gicom/cl_util_time_date=>is_first_date_of_year( iv_date_from ) = abap_true AND /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_to ) = abap_true.
*      "year
*      ev_type = 'Y'.
*      ev_sub = /gicom/cl_util_time_date=>get_year_difference(
*        iv_start_date = iv_date_from
*        iv_end_date   = iv_date_to
*      ).
*    ELSEIF /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_from ) = abap_true AND /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to ) = abap_true.
*      "month
*      ev_type = 'M'.
*      ev_sub = /gicom/cl_util_time_date=>get_month_difference(
*        iv_start_date = iv_date_from
*        iv_end_date   = iv_date_to
*      ).
*    ELSE.
*      "day
*      ev_type = 'D'.
*      ev_sub = /gicom/cl_util_time_date=>get_day_difference(
*        iv_start_date = iv_date_from
*        iv_end_date   = iv_date_to
*      ).
*    ENDIF.
    "<<DEL KJ_M.18925
    ">>INS KJ_M.18925
    IF   ( /gicom/cl_util_time_date=>is_first_date_of_year( iv_date_from ) = abap_true AND
          ( /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_to )  = abap_true OR
            /gicom/cl_util_time_date=>is_first_date_of_year( iv_date_to ) = abap_true )

      OR ( /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_from ) = abap_true AND
           /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_to ) = abap_true ) ).

      "year
      ev_type = 'Y'.
      ev_sub = /gicom/cl_util_time_date=>get_year_difference(
             iv_start_date = iv_date_from
             iv_end_date   = iv_date_to
         ).

    ELSEIF ( /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_from ) = abap_true AND
              ( /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_to ) = abap_true OR
                /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_to )   = abap_true OR
                /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to )  = abap_true OR
                /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_to )   = abap_true ) )

      OR   ( /gicom/cl_util_time_date=>is_first_date_of_year( iv_date_from ) = abap_true AND
              ( /gicom/cl_util_time_date=>is_first_date_of_month( iv_date_to ) = abap_true OR
                /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to )  = abap_true ) )

      OR   ( /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_from ) = abap_true AND
              ( /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to ) = abap_true OR
                /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_to )  = abap_true ) )

      OR   ( /gicom/cl_util_time_date=>is_last_date_of_year( iv_date_from ) = abap_true AND
             /gicom/cl_util_time_date=>is_last_date_of_month( iv_date_to ) = abap_true ).

      "month
      ev_type = 'M'.
      ev_sub = /gicom/cl_util_time_date=>get_month_difference(
                  iv_start_date = iv_date_from
                  iv_end_date   = iv_date_to
              ).

    ELSE.
      "day
      ev_type = 'D'.
      ev_sub = /gicom/cl_util_time_date=>get_day_difference(
                  iv_start_date = iv_date_from
                  iv_end_date   = iv_date_to
              ).
    ENDIF.
    "<<INS KJ_M.18925

    rv_date = /gicom/cl_util_time_date=>subtract_time_from_date(
      iv_date     = iv_date_sub
      iv_subtract = ev_sub
      iv_type     = ev_type
    ).
  ENDMETHOD.


  METHOD subtract_time_from_date.

    CHECK iv_date IS NOT INITIAL.

    DATA(ls_timepoint) = VALUE fdt_s_timepoint( ).

    IF iv_date NE '00010101'.

      ls_timepoint-date = iv_date.

      rv_date = /gicom/cl_util_time_date=>subtract_time_from_date_int(
        iv_date     = iv_date
        iv_subtract = iv_subtract
        iv_type     = iv_type
      ).

***      "Special case: Adding to end of month --> expecting end of month (e.g. 28.02 + 1 -> 31.03)
***      IF ( NOT ( iv_type = 'D' OR iv_type = 'W' )
***            OR iv_check_begin_end = abap_true ).
***
***        IF /gicom/cl_util_time_date=>is_last_date_of_month( iv_date ) = abap_true.
***          rv_date =  /gicom/cl_util_time_date=>get_last_date_of_month( rv_date ).
***        ENDIF.
***
***      ENDIF.


    ELSE.
      rv_date = '00010101'.
    ENDIF.

  ENDMETHOD.


  METHOD validate_date.
    TRY.
        /gicom/cl_sap_datetime=>rp_check_date( iv_date = iv_date ).
        rv_is_date = abap_true.

      CATCH /gicom/cx_sap_call_error.
        rv_is_date = abap_false.
    ENDTRY.
  ENDMETHOD.


  METHOD change_diff_for_leap_year.

    IF iv_end_date NE '99991231'.
      DATA(lv_check_year) = iv_start_date.
      WHILE lv_check_year < iv_end_date.
        IF lv_check_year+0(4) = iv_end_date+0(4) AND
           ( iv_end_date+4(4) < 229 OR
             lv_check_year+4(4) > 228 ).
          EXIT. "Same year and gap day not within
        ENDIF.

        IF is_leap_year( lv_check_year+0(4) ) = abap_true.
          IF iv_add = abap_true.
            cv_days = cv_days + 1.
          ELSE .
            cv_days = cv_days - 1.
          ENDIF.
        ENDIF.

        lv_check_year+0(4) = lv_check_year+0(4) + 1.
      ENDWHILE.
    ENDIF.
  ENDMETHOD.


  METHOD add_time_to_month_int.
    " Extract year, month and day from the date
    DATA(lv_year) = iv_date(4).
    DATA(lv_month) = iv_date+4(2).
    DATA(lv_day) = iv_date+6(2).

    " Before adding the month, we have to take changes in the year into account
    lv_year = lv_year + floor( ( lv_month + iv_add - 1 ) / 12 ).

    " Recalculate the correct month now, MOD 12 returns values between 0 and 11, so we have to
    " add and subtract values accordingly.
    lv_month = ( ( lv_month + iv_add - 1 ) MOD 12 ) + 1.

    DATA(lv_max) = 31.

    " February has either 28 or 29 days, depending on if it is leap year or not
    IF lv_month = 2.
      IF /gicom/cl_util_time_date=>is_leap_year( lv_year ).
        lv_max = 29.
      ELSE.
        lv_max = 28.
      ENDIF.

      " April, June, September and November have 30 days
    ELSEIF lv_month = 4 OR lv_month = 6 OR lv_month = 9 OR lv_month = 11.
      lv_max = 30.
    ENDIF.

    lv_day = nmin( val1 = lv_day val2 = lv_max ).

    rv_date = |{ lv_year }{ lv_month ALIGN = RIGHT WIDTH = 2 PAD = '0' }{ lv_day ALIGN = RIGHT WIDTH = 2 PAD = '0' }|.
  ENDMETHOD.


  METHOD get_interval_standard_dates.

    CASE iv_settlement_period.
      WHEN /gicom/if_const_settl_period=>gc_yearly OR
           /gicom/if_const_settl_period=>gc_half_yearly OR
           /gicom/if_const_settl_period=>gc_tertiary OR
           /gicom/if_const_settl_period=>gc_quarterly OR
           /gicom/if_const_settl_period=>gc_monthly.

        SELECT
          settlement_interval,
          period_start,
          period_end
        FROM
          /gicom/cc_clndr
        WHERE
          settlement_period = @iv_settlement_period AND
          period_base       = 0 AND
          settlement_year   = @iv_agrmt_valid_from(4)
        ORDER BY
          period_start ASCENDING
        INTO TABLE
          @rt_interval_dates.

      WHEN /gicom/if_const_settl_period=>gc_monthly_12 OR
           /gicom/if_const_settl_period=>gc_monthly_6 OR
           /gicom/if_const_settl_period=>gc_monthly_4 OR
           /gicom/if_const_settl_period=>gc_monthly_3.

        DATA(lt_agrmt_intervals) = get_intervals_agrmt_validity(
                                     iv_settlement_period = iv_settlement_period
                                     iv_agrmt_valid_from  = iv_agrmt_valid_from
                                     iv_agrmt_valid_to    = iv_agrmt_valid_to
                                   ).

        LOOP AT lt_agrmt_intervals ASSIGNING FIELD-SYMBOL(<ls_agrmt_interval>).
          IF NOT line_exists( rt_interval_dates[ settlement_interval = <ls_agrmt_interval>-settlement_interval ] ).
            APPEND INITIAL LINE TO rt_interval_dates ASSIGNING FIELD-SYMBOL(<ls_interval_date>).
            <ls_interval_date>-settlement_interval = <ls_agrmt_interval>-settlement_interval.
            <ls_interval_date>-interval_start      = <ls_agrmt_interval>-period_start.
            <ls_interval_date>-interval_end        = <ls_agrmt_interval>-period_end.
          ENDIF.
        ENDLOOP.
    ENDCASE.


  ENDMETHOD.


  METHOD get_instance.
    IF so_instance IS NOT BOUND.
      so_instance = NEW lcl_facade( ).
    ENDIF.
    ro_instance = so_instance.
  ENDMETHOD.


  METHOD inject_instance.
    so_instance = io_instance.
  ENDMETHOD.


  METHOD get_intervals_agrmt_validity.

    DATA lt_agrmt_intervals TYPE /gicom/cc_settle_calendar_tt.
    DATA lv_period_base TYPE int1.
    CASE iv_settlement_period.
      WHEN /gicom/if_const_settl_period=>gc_yearly OR
           /gicom/if_const_settl_period=>gc_half_yearly OR
           /gicom/if_const_settl_period=>gc_tertiary OR
           /gicom/if_const_settl_period=>gc_quarterly OR
           /gicom/if_const_settl_period=>gc_monthly.

        lv_period_base = 0.

      WHEN /gicom/if_const_settl_period=>gc_monthly_12 OR
           /gicom/if_const_settl_period=>gc_monthly_6 OR
           /gicom/if_const_settl_period=>gc_monthly_4 OR
           /gicom/if_const_settl_period=>gc_monthly_3.

        lv_period_base = iv_agrmt_valid_from+4(2).
    ENDCASE.

    SELECT
      settlement_year,
      settlement_interval,
      settlement_period,
      period_base,
      period_start,
      period_end
    FROM
      /gicom/cc_clndr
    WHERE
      settlement_period = @iv_settlement_period AND
      period_base       = @lv_period_base AND
      period_end       >= @iv_agrmt_valid_from AND
      period_start     <= @iv_agrmt_valid_to
    ORDER BY
      period_start ASCENDING
    INTO TABLE
      @rt_agrmt_intervals.

  ENDMETHOD.
ENDCLASS.
