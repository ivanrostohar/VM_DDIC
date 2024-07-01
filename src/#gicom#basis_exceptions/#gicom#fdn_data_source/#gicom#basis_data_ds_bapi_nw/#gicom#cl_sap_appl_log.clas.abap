CLASS /gicom/cl_sap_appl_log DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:

      /gicom/if_sap_appl_log.

    ALIASES:

      bal_db_save               FOR /gicom/if_sap_appl_log~bal_db_save,
      bal_db_load               FOR /gicom/if_sap_appl_log~bal_db_load,
      bal_db_search             FOR /gicom/if_sap_appl_log~bal_db_search,
      bal_dsp_log_display       FOR /gicom/if_sap_appl_log~bal_dsp_log_display,
      bal_dsp_profile_popup_get FOR /gicom/if_sap_appl_log~bal_dsp_profile_popup_get,
      bal_dsp_txt_msg_read      FOR /gicom/if_sap_appl_log~bal_dsp_txt_msg_read,
      bal_glb_memory_refresh    FOR /gicom/if_sap_appl_log~bal_glb_memory_refresh,
      bal_log_create            FOR /gicom/if_sap_appl_log~bal_log_create,
      bal_log_msg_add           FOR /gicom/if_sap_appl_log~bal_log_msg_add,
      bal_log_msg_delete_all    FOR /gicom/if_sap_appl_log~bal_log_msg_delete_all,
      bal_log_read              FOR /gicom/if_sap_appl_log~bal_log_read.

    CLASS-METHODS:

      get_instance
        RETURNING
          VALUE(ro_sap_appl_log_instance) TYPE REF TO /gicom/if_sap_appl_log,

      inject_instance
        IMPORTING
          io_sap_appl_log_instance TYPE REF TO /gicom/if_sap_appl_log.


  PROTECTED SECTION.
  PRIVATE SECTION.

    CLASS-DATA:

      go_instance TYPE REF TO /gicom/if_sap_appl_log.

ENDCLASS.



CLASS /gicom/cl_sap_appl_log IMPLEMENTATION.


  METHOD bal_db_save.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_client             = iv_client
        i_in_update_task     = iv_in_update_task
        i_save_all           = iv_save_all
        i_t_log_handle       = it_log_handle
        i_2th_connection     = iv_2th_connection
        i_2th_connect_commit = iv_2th_connect_commit
        i_link2job           = iv_link2job
      IMPORTING
        e_new_lognumbers     = et_new_lognumbers
*        e_second_connection  = ev_second_connection
      EXCEPTIONS
        log_not_found        = 1
        save_not_allowed     = 2
        numbering_error      = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_DB_SAVE'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_db_load.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_DB_LOAD'
      EXPORTING
        i_t_log_header                = it_log_header
        i_t_log_handle                = it_log_handle
        i_t_lognumber                 = it_lognumber
        i_client                      = iv_client
        i_do_not_load_messages        = iv_do_not_load_messages
        i_exception_if_already_loaded = iv_exception_if_already_loaded
        i_lock_handling               = iv_lock_handling
      IMPORTING
        e_t_log_handle                = et_log_handle
        e_t_msg_handle                = et_msg_handle
        e_t_locked                    = et_locked
      EXCEPTIONS
        no_logs_specified             = 1
        log_not_found                 = 2
        log_already_loaded            = 3
        others                        = 4.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_DB_LOAD'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_db_search.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_DB_SEARCH'
      EXPORTING
        i_client           = iv_client
        i_s_log_filter     = is_log_filter
        i_t_sel_field      = it_selection_field
        i_tzone            = iv_timezone
      IMPORTING
        e_t_log_header     = et_log_header
      EXCEPTIONS
        log_not_found      = 1
        no_filter_criteria = 2
        others             = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_DB_SEARCH'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_dsp_log_display.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
      EXPORTING
        i_s_display_profile           = is_display_profile
        i_t_log_handle                = it_log_handle
        i_t_msg_handle                = it_msg_handle
        i_s_log_filter                = is_log_filter
        i_s_msg_filter                = is_msg_filter
        i_t_log_context_filter        = it_log_context_filter
        i_t_msg_context_filter        = it_msg_context_filter
        i_amodal                      = iv_amodal
        i_srt_by_timstmp              = iv_srt_by_timstmp
        i_msg_context_filter_operator = iv_msg_context_filter_operator
      IMPORTING
        e_s_exit_command              = es_exit_command
      EXCEPTIONS
        profile_inconsistent          = 1
        internal_error                = 2
        no_data_available             = 3
        no_authority                  = 4.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_DSP_LOG_DISPLAY'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_dsp_profile_popup_get.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_DSP_PROFILE_POPUP_GET'
      EXPORTING
        start_col           = iv_start_col
        start_row           = iv_start_row
        end_col             = iv_end_col
        end_row             = iv_end_row
      IMPORTING
        e_s_display_profile = es_display_profile.
  ENDMETHOD.


  METHOD bal_dsp_txt_msg_read.
    CALL FUNCTION 'BAL_DSP_TXT_MSG_READ'
      EXPORTING
        i_langu        = iv_langu
        i_msgid        = iv_msgid
        i_msgno        = iv_msgno
        i_msgv1        = iv_msgv1
        i_msgv2        = iv_msgv2
        i_msgv3        = iv_msgv3
        i_msgv4        = iv_msgv4
      IMPORTING
        e_message_text = ev_message_text.
  ENDMETHOD.


  METHOD bal_glb_memory_refresh.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_GLB_MEMORY_REFRESH'
      EXPORTING
        i_authorization          = iv_authorization
        i_refresh_all            = iv_refresh_all
        i_t_logs_to_be_refreshed = it_logs_to_be_refreshed
      EXCEPTIONS
        not_authorized           = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_GLB_MEMORY_REFRESH'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_log_create.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_LOG_CREATE'
      EXPORTING
        i_s_log                 = is_log
      IMPORTING
        e_log_handle            = ev_log_handle
      EXCEPTIONS
        log_header_inconsistent = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_LOG_CREATE'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_log_msg_add.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_LOG_MSG_ADD'
      EXPORTING
        i_log_handle        = iv_log_handle
        i_s_msg             = is_msg
      IMPORTING
        e_s_msg_handle      = es_msg_handle
        e_msg_was_logged    = ev_msg_was_logged
        e_msg_was_displayed = ev_msg_was_displayed
      EXCEPTIONS
        log_not_found       = 1
        msg_inconsistent    = 2
        log_is_full         = 3.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_LOG_MSG_ADD'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_log_msg_delete_all.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_LOG_MSG_DELETE_ALL'
      EXPORTING
        i_log_handle  = iv_log_handle
      EXCEPTIONS
        log_not_found = 1.

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_LOG_MSG_DELETE_ALL'
        iv_subrc           = sy-subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD bal_log_read.
    /gicom/cl_aunit_utilities=>assert_not_in_unit_test( ).

    CALL FUNCTION 'BAL_LOG_READ'
      EXPORTING
        i_log_handle  = iv_log_handle
        i_read_texts  = iv_read_texts
        i_langu       = iv_langu
      IMPORTING
        es_log        = es_log
        es_statistics = es_statistics
        et_msg        = et_msg
        et_exc        = et_exc
      EXCEPTIONS
        log_not_found = 1.

    DATA(lv_subrc) = sy-subrc.

    IF lv_subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_sap_call_error(
        iv_function_module = 'BAL_LOG_READ'
        iv_subrc           = lv_subrc
      ).
    ENDIF.
  ENDMETHOD.


  METHOD get_instance.
    IF go_instance IS NOT BOUND.
      go_instance = NEW lcl_facade( ).
    ENDIF.
    ro_sap_appl_log_instance = go_instance.
  ENDMETHOD.


  METHOD inject_instance.
    go_instance = io_sap_appl_log_instance.
  ENDMETHOD.

ENDCLASS.
