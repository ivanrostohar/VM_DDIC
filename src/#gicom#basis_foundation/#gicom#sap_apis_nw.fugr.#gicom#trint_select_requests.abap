FUNCTION /gicom/trint_select_requests .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_USERNAME_PATTERN) DEFAULT SY-UNAME
*"     VALUE(IS_SELECTION) TYPE  TRWBO_SELECTION OPTIONAL
*"     VALUE(IV_COMPLETE_PROJECTS) TYPE  C DEFAULT 'X'
*"     VALUE(IV_VIA_SELSCREEN) TYPE  C DEFAULT ' '
*"     VALUE(IS_POPUP) TYPE  STRHI_POPUP OPTIONAL
*"     VALUE(IV_TITLE) TYPE  TRWBO_TITLE OPTIONAL
*"  EXPORTING
*"     VALUE(ET_REQUESTS) TYPE  TRWBO_REQUEST_HEADERS
*"  CHANGING
*"     VALUE(CS_RANGES) TYPE  TRSEL_TS_RANGES OPTIONAL
*"  EXCEPTIONS
*"      ACTION_ABORTED_BY_USER
*"--------------------------------------------------------------------

  CALL FUNCTION 'TRINT_SELECT_REQUESTS'
    EXPORTING
      iv_username_pattern    = iv_username_pattern
      is_selection           = is_selection
      iv_complete_projects   = iv_complete_projects
      iv_via_selscreen       = iv_via_selscreen
      is_popup               = is_popup
      iv_title               = iv_title
    IMPORTING
      et_requests            = et_requests
    CHANGING
      cs_ranges              = cs_ranges
    EXCEPTIONS
      action_aborted_by_user = 1
      OTHERS                 = 2.

  IF sy-subrc <> 0.
* Implement suitable error handling here
    RAISE action_aborted_by_user.
  ENDIF.

ENDFUNCTION.
