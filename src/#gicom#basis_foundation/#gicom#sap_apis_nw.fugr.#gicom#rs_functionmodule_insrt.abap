FUNCTION /gicom/rs_functionmodule_insrt .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_FUNCNAME) LIKE  RS38L-NAME
*"     VALUE(IV_FUNCTION_POOL) LIKE  RS38L-AREA
*"     VALUE(IV_INTERFACE_GLOBAL) LIKE  RS38L-GLOBAL DEFAULT SPACE
*"     VALUE(IV_REMOTE_CALL) LIKE  RS38L-REMOTE DEFAULT SPACE
*"     VALUE(IV_SHORT_TEXT) LIKE  TFTIT-STEXT
*"     VALUE(IV_SUPPRESS_CORR_CHECK) LIKE  RS38L-EXTERN DEFAULT 'X'
*"     VALUE(IV_UPDATE_TASK) LIKE  RS38L-UKIND1 DEFAULT SPACE
*"     VALUE(IV_CORRNUM) LIKE  E071-TRKORR DEFAULT SPACE
*"     VALUE(IV_NAMESPACE) LIKE  RS38L-NAMESPACE DEFAULT SPACE
*"     VALUE(IV_SUPPRESS_LANGUAGE_CHECK) LIKE  RS38L-HEAD DEFAULT 'X'
*"     VALUE(IV_AUTHORITY_CHECK) LIKE  RS38L-HEAD DEFAULT 'X'
*"     VALUE(IV_SAVE_ACTIVE) LIKE  RS38L-HEAD DEFAULT 'X'
*"     VALUE(IV_NEW_SOURCE) TYPE  RSFB_SOURCE OPTIONAL
*"     VALUE(IV_EXCEPTION_CLASS) TYPE  CHAR1 DEFAULT SPACE
*"     VALUE(IV_SUPPRESS_UPGRADE_CHECK) TYPE  CHAR1 DEFAULT SPACE
*"     VALUE(IV_REMOTE_BASXML_SUPPORTED) TYPE  CHAR1 DEFAULT SPACE
*"  EXPORTING
*"     VALUE(EV_FUNCTION_INCLUDE) LIKE  RS38L-INCLUDE
*"     VALUE(EV_CORRNUM_E) LIKE  E071-TRKORR
*"  TABLES
*"      IMPORT_PARAMETER STRUCTURE  RSIMP OPTIONAL
*"      EXPORT_PARAMETER STRUCTURE  RSEXP OPTIONAL
*"      TABLES_PARAMETER STRUCTURE  RSTBL OPTIONAL
*"      CHANGING_PARAMETER STRUCTURE  RSCHA OPTIONAL
*"      EXCEPTION_LIST STRUCTURE  RSEXC OPTIONAL
*"      PARAMETER_DOCU STRUCTURE  RSFDO OPTIONAL
*"      SOURCE STRUCTURE  RSSOURCE OPTIONAL
*"  EXCEPTIONS
*"      DOUBLE_TASK
*"      ERROR_MESSAGE
*"      FUNCTION_ALREADY_EXISTS
*"      INVALID_FUNCTION_POOL
*"      INVALID_NAME
*"      TOO_MANY_FUNCTIONS
*"      NO_MODIFY_PERMISSION
*"      NO_SHOW_PERMISSION
*"      ENQUEUE_SYSTEM_FAILURE
*"      CANCELED_IN_CORR
*"--------------------------------------------------------------------

  CALL FUNCTION 'RS_FUNCTIONMODULE_INSERT'
    EXPORTING
      funcname                = iv_funcname
      function_pool           = iv_function_pool
      interface_global        = iv_interface_global
      remote_call             = iv_remote_call
      short_text              = iv_short_text
      suppress_corr_check     = iv_suppress_corr_check
      update_task             = iv_update_task
      corrnum                 = iv_corrnum
      namespace               = iv_namespace
      suppress_language_check = iv_suppress_language_check
      authority_check         = iv_authority_check
      save_active             = iv_save_active
      new_source              = iv_new_source
      exception_class         = iv_exception_class
      suppress_upgrade_check  = iv_suppress_upgrade_check
      remote_basxml_supported = iv_remote_basxml_supported
    IMPORTING
      function_include        = ev_function_include
      corrnum_e               = ev_corrnum_e
    TABLES
      import_parameter        = import_parameter
      export_parameter        = export_parameter
      tables_parameter        = tables_parameter
      changing_parameter      = changing_parameter
      exception_list          = changing_parameter
      parameter_docu          = parameter_docu
      source                  = source
    EXCEPTIONS
      double_task             = 1
      error_message           = 2
      function_already_exists = 3
      invalid_function_pool   = 4
      invalid_name            = 5
      too_many_functions      = 6
      no_modify_permission    = 7
      no_show_permission      = 8
      enqueue_system_failure  = 9
      canceled_in_corr        = 10
      OTHERS                  = 11.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    RAISE error_message.
  ENDIF.

ENDFUNCTION.
