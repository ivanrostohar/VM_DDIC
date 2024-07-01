FUNCTION /gicom/seo_class_delet_complet .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CLSKEY) TYPE  SEOCLSKEY
*"     VALUE(IV_GENFLAG) TYPE  GENFLAG DEFAULT SPACE
*"     VALUE(IV_AUTHORITY_CHECK) TYPE  SEOX_BOOLEAN DEFAULT SEOX_TRUE
*"     VALUE(IV_SUPPRESS_DOCU_DELETE) TYPE  SEOX_BOOLEAN
*"         DEFAULT SEOX_FALSE
*"     VALUE(IV_SUPPRESS_COMMIT) TYPE  SEOX_BOOLEAN
*"         DEFAULT SEOX_FALSE
*"     VALUE(IV_SUPPRESS_CORR) TYPE  SEOX_BOOLEAN DEFAULT SEOX_FALSE
*"     REFERENCE(IO_LOCK_HANDLE) TYPE REF TO IF_ADT_LOCK_HANDLE
*"         OPTIONAL
*"     VALUE(IV_SUPPRESS_DIALOG) TYPE  SEOX_BOOLEAN
*"         DEFAULT SEOX_FALSE
*"  CHANGING
*"     REFERENCE(CV_CORRNR) TYPE  TRKORR OPTIONAL
*"  EXCEPTIONS
*"      NOT_EXISTING
*"      IS_INTERFACE
*"      DB_ERROR
*"      NO_ACCESS
*"      OTHER
*"--------------------------------------------------------------------

  CALL FUNCTION 'SEO_CLASS_DELETE_COMPLETE'
    EXPORTING
      clskey               = iv_clskey
      genflag              = iv_genflag
      authority_check      = iv_authority_check
      suppress_docu_delete = iv_suppress_docu_delete
      suppress_commit      = iv_suppress_commit
      suppress_corr        = iv_suppress_corr
      lock_handle          = io_lock_handle
      suppress_dialog      = iv_suppress_dialog
    CHANGING
      corrnr               = cv_corrnr
    EXCEPTIONS
      not_existing         = 1
      is_interface         = 2
      db_error             = 3
      no_access            = 4
      other                = 5
      OTHERS               = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    RAISE other.
  ENDIF.

ENDFUNCTION.
