CLASS /gicom/cl_system DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.

    CLASS-METHODS:

      "! This method returns the current system date unless the system date was set to a different value with the method set_date
      "!
      "! @parameter iv_date | If set this date is returned, otherwise the system date is returned
      get_date
        IMPORTING
          iv_date        TYPE syst_datum OPTIONAL
        RETURNING
          VALUE(rv_date) TYPE syst_datum,

      get_year
        RETURNING
          VALUE(rv_year) TYPE /gicom/year,

      get_month
        RETURNING
          VALUE(rv_month) TYPE /gicom/month,

      get_day
        RETURNING
          VALUE(rv_day) TYPE /gicom/day,

      get_time
        RETURNING
          VALUE(rv_time) TYPE syst_uzeit,

      get_time_stamp
        RETURNING
          VALUE(rv_time_stamp) TYPE timestamp,

      get_time_stamp_long
        RETURNING
          VALUE(rv_time_stampl) TYPE timestampl,

      set_date
        IMPORTING
          iv_date TYPE syst_datum,

      set_time
        IMPORTING
          iv_time TYPE syst_uzeit,

      reset_date,

      reset_time,

      "! This method returns the current system user name unless the system user name was set to a different value with the method set_username
      "!
      "! @parameter iv_username | If set this user name is returned, otherwise the system user name is returned
      get_username
        IMPORTING
          iv_username        TYPE syst_uname OPTIONAL
        RETURNING
          VALUE(rv_username) TYPE syst_uname,

      reset_username,

      set_username
        IMPORTING
          iv_username TYPE syst_uname,

      get_language
        RETURNING
          VALUE(rv_language) TYPE syst_langu,

      reset_language,

      set_language
        IMPORTING
          iv_language TYPE syst_langu,

      reset_current_task,

      set_current_task
        IMPORTING
          iv_guid TYPE /gicom/task_guid,

      set_current_process_guid
        IMPORTING
          iv_app_process_guid TYPE /gicom/app_process_guid,

      reset_current_process_guid,

      get_current_process_guid
        RETURNING
          VALUE(rv_app_process_guid) TYPE /gicom/app_process_guid,

      get_current_task
        RETURNING
          VALUE(rv_guid) TYPE /gicom/task_guid,

      is_running_in_task
        RETURNING
          VALUE(rv_result) TYPE abap_bool,

      reset_current_message,

      set_current_message
        IMPORTING
          iv_guid TYPE /gicom/message_guid,

      get_current_message
        RETURNING
          VALUE(rv_guid) TYPE /gicom/message_guid,

      is_running_in_consumer
        RETURNING
          VALUE(rv_result) TYPE abap_bool,

      class_constructor.

  PRIVATE SECTION.

    CLASS-DATA:

      srv_date            TYPE REF TO syst_datum,

      srv_time            TYPE REF TO syst_uzeit,

      srv_username        TYPE REF TO syst_uname,

      srv_language        TYPE REF TO syst_langu,

      sv_task_guid        TYPE /gicom/task_guid,

      sv_message_guid     TYPE /gicom/message_guid,

      sv_app_process_guid TYPE /gicom/app_process_guid.

ENDCLASS.



CLASS /gicom/cl_system IMPLEMENTATION.


  METHOD get_day.
    rv_day = substring( val = /gicom/cl_system=>get_date( ) off = 6 len = 2 ).
  ENDMETHOD.


  METHOD get_month.
    rv_month = substring( val = /gicom/cl_system=>get_date( ) off = 4 len = 2 ).
  ENDMETHOD.


  METHOD reset_time.
    CLEAR /gicom/cl_system=>srv_time.
  ENDMETHOD.


  METHOD get_language.
    IF /gicom/cl_system=>srv_language IS BOUND.
      rv_language = /gicom/cl_system=>srv_language->*.

    ELSE.
      rv_language = sy-langu.

    ENDIF.
  ENDMETHOD.


  METHOD set_language.
    IF /gicom/cl_system=>srv_language IS NOT BOUND.
      CREATE DATA /gicom/cl_system=>srv_language.
    ENDIF.

    /gicom/cl_system=>srv_language->* = iv_language.
  ENDMETHOD.


  METHOD reset_language.
    CLEAR /gicom/cl_system=>srv_language.
  ENDMETHOD.


  METHOD set_date.

    ASSERT iv_date IS NOT INITIAL.

    IF /gicom/cl_system=>srv_date IS NOT BOUND.
      CREATE DATA /gicom/cl_system=>srv_date.
    ENDIF.

    /gicom/cl_system=>srv_date->* = iv_date.
  ENDMETHOD.


  METHOD set_time.
    IF /gicom/cl_system=>srv_time IS NOT BOUND.
      CREATE DATA /gicom/cl_system=>srv_time.
    ENDIF.

    /gicom/cl_system=>srv_time->* = iv_time.
  ENDMETHOD.


  METHOD get_year.
    rv_year = substring( val = /gicom/cl_system=>get_date( ) off = 0 len = 4 ).
  ENDMETHOD.


  METHOD reset_date.
    CLEAR /gicom/cl_system=>srv_date.
  ENDMETHOD.


  METHOD get_time.
    IF /gicom/cl_system=>srv_time IS BOUND.
      rv_time = /gicom/cl_system=>srv_time->*.

    ELSE.
      rv_time = sy-uzeit.                                 "#EC SY_FIELD

    ENDIF.
  ENDMETHOD.


  METHOD get_date.

    IF iv_date IS INITIAL.
      IF /gicom/cl_system=>srv_date IS BOUND.
        rv_date = /gicom/cl_system=>srv_date->*.
      ELSE.
        rv_date = sy-datum.                               "#EC SY_FIELD
      ENDIF.
    ELSE.
      rv_date = iv_date.
    ENDIF.

  ENDMETHOD.


  METHOD get_username.
    IF iv_username IS INITIAL.
      IF /gicom/cl_system=>srv_username IS BOUND.
        rv_username = /gicom/cl_system=>srv_username->*.

      ELSE.
        rv_username = sy-uname.                           "#EC SY_FIELD

      ENDIF.
    ELSE.
      rv_username = iv_username.
    ENDIF.
  ENDMETHOD.


  METHOD set_username.
    IF /gicom/cl_system=>srv_username IS NOT BOUND.
      CREATE DATA /gicom/cl_system=>srv_username.
    ENDIF.

    /gicom/cl_system=>srv_username->* = iv_username.
  ENDMETHOD.


  METHOD reset_username.
    CLEAR /gicom/cl_system=>srv_username.
  ENDMETHOD.


  METHOD get_current_message.
    rv_guid = /gicom/cl_system=>sv_message_guid.
  ENDMETHOD.


  METHOD get_current_task.
    rv_guid = /gicom/cl_system=>sv_task_guid.
  ENDMETHOD.


  METHOD is_running_in_consumer.
    rv_result = xsdbool( /gicom/cl_system=>sv_message_guid IS NOT INITIAL ).
  ENDMETHOD.


  METHOD is_running_in_task.
    rv_result = xsdbool( /gicom/cl_system=>sv_task_guid IS NOT INITIAL ).
  ENDMETHOD.


  METHOD set_current_message.
    ASSERT /gicom/cl_system=>sv_task_guid IS INITIAL.

    /gicom/cl_system=>sv_message_guid = iv_guid.
  ENDMETHOD.


  METHOD set_current_task.
    ASSERT /gicom/cl_system=>sv_message_guid IS INITIAL.

    /gicom/cl_system=>sv_task_guid = iv_guid.
  ENDMETHOD.


  METHOD reset_current_message.
    CLEAR /gicom/cl_system=>sv_message_guid.
  ENDMETHOD.


  METHOD reset_current_task.
    CLEAR /gicom/cl_system=>sv_task_guid.
  ENDMETHOD.


  METHOD get_time_stamp.
    IF /gicom/cl_system=>srv_time IS BOUND OR /gicom/cl_system=>srv_date IS BOUND.
      rv_time_stamp = |{ /gicom/cl_system=>get_date( ) }{ /gicom/cl_system=>get_time( ) }|.
    ELSE.
      GET TIME STAMP FIELD rv_time_stamp.
    ENDIF.
  ENDMETHOD.


  METHOD get_time_stamp_long.
    IF /gicom/cl_system=>srv_time IS BOUND OR /gicom/cl_system=>srv_date IS BOUND.
      rv_time_stampl = |{ /gicom/cl_system=>get_time_stamp( ) }.0000000|.
    ELSE.
      GET TIME STAMP FIELD rv_time_stampl.
    ENDIF.
  ENDMETHOD.


  METHOD class_constructor.
    DATA:
      lo_badi         TYPE REF TO /gicom/badi_user_session,
      ls_user_session TYPE /gicom/user_date_s.

    TRY.
        GET BADI lo_badi.

        IF lo_badi IS BOUND.
          CALL BADI lo_badi->get_user_session RECEIVING rs_user_session = ls_user_session.

          IF ls_user_session IS NOT INITIAL.
            /gicom/cl_system=>set_date( ls_user_session-user_date ).
          ENDIF.
        ENDIF.

      CATCH cx_root.
        "Don't do nothing, because badi implementation could not be implemented and is not mandatory
    ENDTRY.

  ENDMETHOD.


  METHOD get_current_process_guid.
    rv_app_process_guid = /gicom/cl_system=>sv_app_process_guid.
  ENDMETHOD.


  METHOD reset_current_process_guid.
    CLEAR /gicom/cl_system=>sv_app_process_guid.
  ENDMETHOD.


  METHOD set_current_process_guid.
    /gicom/cl_system=>sv_app_process_guid = iv_app_process_guid.
  ENDMETHOD.
ENDCLASS.
