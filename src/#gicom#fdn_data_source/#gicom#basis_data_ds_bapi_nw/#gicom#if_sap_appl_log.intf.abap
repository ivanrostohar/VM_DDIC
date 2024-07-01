INTERFACE /gicom/if_sap_appl_log
  PUBLIC .

  CLASS-METHODS:

    bal_db_save
      IMPORTING
        iv_client             TYPE sy-mandt DEFAULT sy-mandt
        iv_in_update_task     TYPE boolean DEFAULT space
        iv_save_all           TYPE boolean DEFAULT space
        it_log_handle         TYPE bal_t_logh OPTIONAL
        iv_2th_connection     TYPE boolean DEFAULT space
        iv_2th_connect_commit TYPE boolean DEFAULT space
        iv_link2job           TYPE boolean DEFAULT 'X'
      EXPORTING
        et_new_lognumbers     TYPE bal_t_lgnm
        ev_second_connection  TYPE dbcon_name
      RAISING
        /gicom/cx_sap_call_error,

    bal_log_create
      IMPORTING
        is_log        TYPE bal_s_log
      EXPORTING
        ev_log_handle TYPE balloghndl
      RAISING
        /gicom/cx_sap_call_error,

    bal_log_msg_delete_all
      IMPORTING
        iv_log_handle TYPE balloghndl
      RAISING
        /gicom/cx_sap_call_error,

    bal_log_msg_add
      IMPORTING
        iv_log_handle        TYPE balloghndl OPTIONAL
        is_msg               TYPE bal_s_msg
      EXPORTING
        es_msg_handle        TYPE balmsghndl
        ev_msg_was_logged    TYPE boolean
        ev_msg_was_displayed TYPE boolean
      RAISING
        /gicom/cx_sap_call_error,

    bal_log_read
      IMPORTING
        iv_log_handle TYPE balloghndl
        iv_read_texts TYPE boolean DEFAULT space
        iv_langu      TYPE sylangu DEFAULT sy-langu
      EXPORTING
        es_log        TYPE bal_s_log
        es_statistics TYPE bal_s_scnt
        et_msg        TYPE bal_t_msgr
        et_exc        TYPE bal_t_excr_mass
      RAISING
        /gicom/cx_sap_call_error,

    bal_glb_memory_refresh
      IMPORTING
        iv_authorization        TYPE balauth OPTIONAL
        iv_refresh_all          TYPE boolean DEFAULT 'X'
        it_logs_to_be_refreshed TYPE bal_t_logh OPTIONAL
      RAISING
        /gicom/cx_sap_call_error,

    bal_dsp_profile_popup_get
      IMPORTING
        iv_start_col       TYPE balcoord DEFAULT 5
        iv_start_row       TYPE balcoord DEFAULT 5
        iv_end_col         TYPE balcoord DEFAULT 87
        iv_end_row         TYPE balcoord DEFAULT 25
      EXPORTING
        es_display_profile TYPE bal_s_prof,

    bal_dsp_log_display
      IMPORTING
        is_display_profile             TYPE bal_s_prof OPTIONAL
        it_log_handle                  TYPE bal_t_logh OPTIONAL
        it_msg_handle                  TYPE bal_t_msgh OPTIONAL
        is_log_filter                  TYPE bal_s_lfil OPTIONAL
        is_msg_filter                  TYPE bal_s_mfil OPTIONAL
        it_log_context_filter          TYPE bal_t_cfil OPTIONAL
        it_msg_context_filter          TYPE bal_t_cfil OPTIONAL
        iv_amodal                      TYPE boolean DEFAULT space
        iv_srt_by_timstmp              TYPE boolean DEFAULT space
        iv_msg_context_filter_operator TYPE c DEFAULT 'A'
      EXPORTING
        es_exit_command                TYPE bal_s_excm
      RAISING
        /gicom/cx_sap_call_error,

    bal_dsp_txt_msg_read
      IMPORTING
        iv_langu        TYPE sylangu DEFAULT sy-langu
        iv_msgid        TYPE sy-msgid
        iv_msgno        TYPE sy-msgno
        iv_msgv1        TYPE sy-msgv1 OPTIONAL
        iv_msgv2        TYPE sy-msgv2 OPTIONAL
        iv_msgv3        TYPE sy-msgv3 OPTIONAL
        iv_msgv4        TYPE sy-msgv4 OPTIONAL
      EXPORTING
        ev_message_text TYPE c,

    bal_db_search
      IMPORTING
        iv_client          TYPE sy-mandt DEFAULT sy-mandt
        is_log_filter      TYPE bal_s_lfil
        it_selection_field TYPE bal_t_fld OPTIONAL
        iv_timezone        TYPE sy-tzone OPTIONAL
      EXPORTING
        et_log_header TYPE balhdr_t
      RAISING
        /gicom/cx_sap_call_error,

    bal_db_load
      IMPORTING
        iv_client                      TYPE sy-mandt DEFAULT sy-mandt
        it_log_header                  TYPE balhdr_t OPTIONAL
        it_log_handle                  TYPE bal_t_logh OPTIONAL
        it_lognumber                   TYPE bal_t_logn OPTIONAL
        iv_exception_if_already_loaded TYPE boolean OPTIONAL
        iv_do_not_load_messages        TYPE boolean DEFAULT space
        iv_lock_handling               TYPE i DEFAULT 2
      EXPORTING
        et_log_handle TYPE bal_t_logh
        et_msg_handle TYPE bal_t_msgh
        et_locked     TYPE balhdr_t
      RAISING
        /gicom/cx_sap_call_error.

ENDINTERFACE.
