CLASS /gicom/cl_sap_standard DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:

      enqueue_read
        IMPORTING
          iv_table_name TYPE eqegraname
        RETURNING
          VALUE(rt_enq) TYPE /gicom/seqg3_tt
        RAISING
          /gicom/cx_sap_call_error,

      split_string_in_parts
        IMPORTING
          iv_string         TYPE string
          iv_lengh_per_part TYPE i
        RETURNING
          VALUE(rt_string)  TYPE /gicom/string_tt,

      guid_create
        EXPORTING
          ev_guid_16 TYPE guid_16
          ev_guid_22 TYPE guid_22
          ev_guid_32 TYPE guid_32,

      system_callstack
        IMPORTING
          iv_max_level      TYPE i DEFAULT 0
        EXPORTING
          et_abap_callstack TYPE abap_callstack
          et_callstack      TYPE sys_callst,

      th_server_list
        IMPORTING
          services           TYPE mstypes OPTIONAL
          sysservice         TYPE mssysservice OPTIONAL
          iv_active_server   TYPE i DEFAULT 1
          iv_subsystem_aware TYPE i DEFAULT 1
        CHANGING
          ct_list            TYPE msxxlist_t OPTIONAL
        RAISING
          /gicom/cx_sap_call_error,

      balw_bapireturn_get2
        IMPORTING
          iv_type       TYPE bapireturn-type
          iv_cl         TYPE sy-msgid
          iv_number     TYPE sy-msgno
          iv_par1       TYPE sy-msgv1 DEFAULT space
          iv_par2       TYPE sy-msgv2 DEFAULT space
          iv_par3       TYPE sy-msgv3 DEFAULT space
          iv_par4       TYPE sy-msgv4 DEFAULT space
          iv_log_no     TYPE bapireturn-log_no DEFAULT space
          iv_log_msg_no TYPE bapireturn-log_msg_no OPTIONAL
          iv_parameter  TYPE bapiret2-parameter DEFAULT space
          iv_row        TYPE bapiret2-row DEFAULT 0
          iv_field      TYPE bapiret2-field DEFAULT space
        EXPORTING
          es_return     TYPE bapiret2,

      lvc_fieldcatalog_merge
        IMPORTING
          iv_buffer_active        TYPE any OPTIONAL ##ADT_PARAMETER_UNTYPED
          iv_structure_name       TYPE dd02l-tabname OPTIONAL
          iv_client_never_display TYPE slis_char_1 DEFAULT 'X'
          iv_bypassing_buffer     TYPE char01 OPTIONAL
          iv_internal_tabname     TYPE dd02l-tabname OPTIONAL
        CHANGING
          ct_fieldcat             TYPE lvc_t_fcat
        RAISING
          /gicom/cx_sap_call_error,

      bapi_message_getdetail
        IMPORTING
          iv_id           TYPE bapiret2-id
          iv_number       TYPE bapiret2-number
          iv_language     TYPE bapitga-langu DEFAULT sy-langu
          iv_textformat   TYPE bapitga-textformat
          iv_linkpattern  TYPE bapitga-linkmask OPTIONAL
          iv_message_v1   TYPE bapiret2-message_v1 OPTIONAL
          iv_message_v2   TYPE bapiret2-message_v2 OPTIONAL
          iv_message_v3   TYPE bapiret2-message_v3 OPTIONAL
          iv_message_v4   TYPE bapiret2-message_v4 OPTIONAL
          iv_language_iso TYPE bapi_stand-langu_iso OPTIONAL
          iv_line_size    TYPE bapi_stand-line_size OPTIONAL
        EXPORTING
          ev_message      TYPE bapiret2-message
          es_return       TYPE bapiret2
        CHANGING
          ct_text         TYPE /gicom/bapitgb_t OPTIONAL,

      get_background_jobs
        IMPORTING
          is_selection   TYPE btcselect
        RETURNING
          VALUE(rt_jobs) TYPE tbtcjob_tt
        RAISING
          /gicom/cx_sap_call_error.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_SAP_STANDARD IMPLEMENTATION.


  METHOD balw_bapireturn_get2.
    CALL FUNCTION 'BALW_BAPIRETURN_GET2'
      EXPORTING
        type       = iv_type
        cl         = iv_cl
        number     = iv_number
        par1       = iv_par1
        par2       = iv_par2
        par3       = iv_par3
        par4       = iv_par4
        log_no     = iv_log_no
        log_msg_no = iv_log_msg_no
        parameter  = iv_parameter
        row        = iv_row
        field      = iv_field
      IMPORTING
        return     = es_return.

  ENDMETHOD.


  METHOD bapi_message_getdetail.

    CALL FUNCTION 'BAPI_MESSAGE_GETDETAIL'
      EXPORTING
        id           = iv_id
        number       = iv_number
        language     = iv_language
        textformat   = iv_textformat
        linkpattern  = iv_linkpattern
        message_v1   = iv_message_v1
        message_v2   = iv_message_v2
        message_v3   = iv_message_v3
        message_v4   = iv_message_v4
        language_iso = iv_language_iso
        line_size    = iv_line_size
      IMPORTING
        message      = ev_message
        return       = es_return
      TABLES
        text         = ct_text.

  ENDMETHOD.


  METHOD enqueue_read.

  " Obsolete - please use cl_abap_lock_object_factory instead

*    CALL FUNCTION 'ENQUEUE_READ'
*      EXPORTING
*        gname                 = iv_table_name
*      TABLES
*        enq                   = rt_enq
*      EXCEPTIONS
*        communication_failure = 1
*        system_failure        = 2
*        OTHERS                = 3.

"    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'ENQUEUE_READ - method obsolete please do not use this one anymore'
        iv_subrc           = 4 "sy-subrc
      ).
"    ENDIF.

  ENDMETHOD.


  METHOD guid_create.

    CALL FUNCTION 'GUID_CREATE'
      IMPORTING
        ev_guid_16 = ev_guid_16
        ev_guid_22 = ev_guid_22
        ev_guid_32 = ev_guid_32.

  ENDMETHOD.


  METHOD lvc_fieldcatalog_merge.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_buffer_active        = iv_buffer_active
        i_structure_name       = iv_structure_name
        i_client_never_display = iv_client_never_display
        i_bypassing_buffer     = iv_bypassing_buffer
        i_internal_tabname     = iv_internal_tabname
      CHANGING
        ct_fieldcat            = ct_fieldcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'LVC_FIELDCATALOG_MERGE'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD system_callstack.

    CALL FUNCTION 'SYSTEM_CALLSTACK'
      EXPORTING
        max_level    = iv_max_level
      IMPORTING
        callstack    = et_abap_callstack
        et_callstack = et_callstack.

  ENDMETHOD.


  METHOD th_server_list.
    CALL FUNCTION 'TH_SERVER_LIST'
      EXPORTING
        active_server   = iv_active_server
        subsystem_aware = iv_subsystem_aware
      TABLES
        list            = ct_list
      EXCEPTIONS
        no_server_list  = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'TH_SERVER_LIST'
        iv_subrc           = sy-subrc
      ).
    ENDIF.

  ENDMETHOD.


  METHOD split_string_in_parts.
    DATA lt_string TYPE STANDARD TABLE OF swastrtab.

    CALL FUNCTION 'SWA_STRING_SPLIT'
      EXPORTING
        input_string         = iv_string
        max_component_length = iv_lengh_per_part
      TABLES
        string_components    = lt_string.

    rt_string = VALUE #( FOR <ls_> IN lt_string ( CONV string( <ls_>-str ) ) ).
  ENDMETHOD.


  METHOD get_background_jobs.
    CALL FUNCTION 'BP_JOB_SELECT'
      EXPORTING
        jobselect_dialog    = 'N'
        jobsel_param_in     = is_selection
      TABLES
        jobselect_joblist   = rt_jobs
      EXCEPTIONS
        no_jobs_found       = 1
        invalid_dialog_type = 2
        jobname_missing     = 3
        selection_canceled  = 4
        username_missing    = 5
        OTHERS              = 6.

    IF sy-subrc > 1.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BP_JOB_SELECT'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
