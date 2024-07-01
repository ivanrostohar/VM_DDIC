CLASS /gicom/cl_sap_datetime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS:
      get_system_timezone
        EXPORTING
          ev_timezone TYPE timezone
        RAISING
          /gicom/cx_sap_call_error,

      rp_check_date
        IMPORTING
          iv_date TYPE any ##ADT_PARAMETER_UNTYPED
        RAISING
          /gicom/cx_sap_call_error,

      get_week_info_based_on_date
        IMPORTING
          iv_date        TYPE /gicom/date
        EXPORTING
          ev_date_monday TYPE /gicom/date
          ev_date_sunday TYPE /gicom/date
          ev_week        TYPE kweek.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_SAP_DATETIME IMPLEMENTATION.


  METHOD get_system_timezone.

    CALL FUNCTION 'GET_SYSTEM_TIMEZONE'
      IMPORTING
        timezone            = ev_timezone
      EXCEPTIONS
        customizing_missing = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'GET_SYSTEM_TIMEZONE'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD get_week_info_based_on_date.
**********************************************************************
***   "Copy of Function Module 'GET_WEEK_INFO_BASED_ON_DATE'
**********************************************************************

* Get the week including the given day
    CALL FUNCTION 'DATE_GET_WEEK'
      EXPORTING
        date         = iv_date
      IMPORTING
        week         = ev_week
      EXCEPTIONS
        date_invalid = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

* Get the monday
    CALL FUNCTION 'WEEK_GET_FIRST_DAY'
      EXPORTING
        week         = ev_week
      IMPORTING
        date         = ev_date_monday
      EXCEPTIONS
        week_invalid = 1
        OTHERS       = 2.

    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.

    ENDIF.

    ev_date_sunday = ev_date_monday.
    ADD 6 TO ev_date_sunday.


  ENDMETHOD.


  METHOD rp_check_date.

    CALL FUNCTION 'RP_CHECK_DATE'
      EXPORTING
        date         = iv_date
      EXCEPTIONS
        date_invalid = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'RP_CHECK_DATE'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
