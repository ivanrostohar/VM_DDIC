*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations


CLASS lcl_facade DEFINITION.

  PUBLIC SECTION.

    INTERFACES:

      /gicom/if_sap_appl_log.

ENDCLASS.

CLASS lcl_facade IMPLEMENTATION.



  METHOD /gicom/if_sap_appl_log~bal_db_load.
    /gicom/cl_sap_appl_log=>bal_db_load(
      EXPORTING
        iv_client                      = iv_client
        it_log_header                  = it_log_header
        it_log_handle                  = it_log_handle
        it_lognumber                   = it_lognumber
        iv_exception_if_already_loaded = iv_exception_if_already_loaded
        iv_do_not_load_messages        = iv_do_not_load_messages
        iv_lock_handling               = iv_lock_handling
      IMPORTING
        et_log_handle                  = et_log_handle
        et_msg_handle                  = et_msg_handle
        et_locked                      = et_locked
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_db_save.
    /gicom/cl_sap_appl_log=>bal_db_save(
      EXPORTING
        iv_client             = iv_client
        iv_in_update_task     = iv_in_update_task
        iv_save_all           = iv_save_all
        it_log_handle         = it_log_handle
        iv_2th_connection     = iv_2th_connection
        iv_2th_connect_commit = iv_2th_connect_commit
        iv_link2job           = iv_link2job
      IMPORTING
        et_new_lognumbers     = et_new_lognumbers
        ev_second_connection  = ev_second_connection
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_db_search.
    /gicom/cl_sap_appl_log=>bal_db_search(
      EXPORTING
        iv_client          = iv_client
        is_log_filter      = is_log_filter
        it_selection_field = it_selection_field
        iv_timezone        = iv_timezone
      IMPORTING
        et_log_header      = et_log_header
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_dsp_log_display.
    /gicom/cl_sap_appl_log=>bal_dsp_log_display(
      EXPORTING
        is_display_profile             = is_display_profile
        it_log_handle                  = it_log_handle
        it_msg_handle                  = it_msg_handle
        is_log_filter                  = is_log_filter
        is_msg_filter                  = is_msg_filter
        it_log_context_filter          = it_log_context_filter
        it_msg_context_filter          = it_msg_context_filter
        iv_amodal                      = iv_amodal
        iv_srt_by_timstmp              = iv_srt_by_timstmp
        iv_msg_context_filter_operator = iv_msg_context_filter_operator
      IMPORTING
        es_exit_command                = es_exit_command
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_dsp_profile_popup_get.
    /gicom/cl_sap_appl_log=>bal_dsp_profile_popup_get(
      EXPORTING
        iv_start_col       = iv_start_col
        iv_start_row       = iv_start_row
        iv_end_col         = iv_end_col
        iv_end_row         = iv_end_row
      IMPORTING
        es_display_profile = es_display_profile
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_dsp_txt_msg_read.
    /gicom/cl_sap_appl_log=>bal_dsp_txt_msg_read(
      EXPORTING
        iv_langu        = iv_langu
        iv_msgid        = iv_msgid
        iv_msgno        = iv_msgno
        iv_msgv1        = iv_msgv1
        iv_msgv2        = iv_msgv2
        iv_msgv3        = iv_msgv3
        iv_msgv4        = iv_msgv4
      IMPORTING
        ev_message_text = ev_message_text
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_glb_memory_refresh.
    /gicom/cl_sap_appl_log=>bal_glb_memory_refresh(
      EXPORTING
        iv_authorization        = iv_authorization
        iv_refresh_all          = iv_refresh_all
        it_logs_to_be_refreshed = it_logs_to_be_refreshed
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_log_create.
    /gicom/cl_sap_appl_log=>bal_log_create(
      EXPORTING
        is_log        = is_log
      IMPORTING
        ev_log_handle = ev_log_handle
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_log_msg_add.
    /gicom/cl_sap_appl_log=>bal_log_msg_add(
      EXPORTING
        iv_log_handle        = iv_log_handle
        is_msg               = is_msg
      IMPORTING
        es_msg_handle        = es_msg_handle
        ev_msg_was_logged    = ev_msg_was_logged
        ev_msg_was_displayed = ev_msg_was_displayed
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_log_msg_delete_all.
    /gicom/cl_sap_appl_log=>bal_log_msg_delete_all(
      iv_log_handle = iv_log_handle
    ).
  ENDMETHOD.

  METHOD /gicom/if_sap_appl_log~bal_log_read.
    /gicom/cl_sap_appl_log=>bal_log_read(
      EXPORTING
        iv_log_handle = iv_log_handle
        iv_read_texts = iv_read_texts
        iv_langu      = iv_langu
      IMPORTING
        es_log        = es_log
        es_statistics = es_statistics
        et_msg        = et_msg
        et_exc        = et_exc
    ).
  ENDMETHOD.

ENDCLASS.
