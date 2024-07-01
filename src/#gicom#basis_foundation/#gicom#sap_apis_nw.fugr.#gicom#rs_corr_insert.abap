FUNCTION /GICOM/RS_CORR_INSERT .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_OBJECT)
*"     VALUE(IV_OBJECT_CLASS)
*"     VALUE(IV_MODE) DEFAULT SPACE
*"     VALUE(IV_GLOBAL_LOCK) DEFAULT SPACE
*"     VALUE(IV_DEVCLASS) LIKE  TADIR-DEVCLASS DEFAULT SPACE
*"     VALUE(IV_KORRNUM) LIKE  E070-TRKORR DEFAULT SPACE
*"     VALUE(IV_USE_KORRNUM_IMMEDIATEDLY) TYPE  C DEFAULT SPACE
*"     VALUE(IV_AUTHOR) LIKE  SY-UNAME DEFAULT SPACE
*"     VALUE(IV_MASTER_LANGUAGE) LIKE  SY-LANGU DEFAULT SPACE
*"     VALUE(IV_GENFLAG) LIKE  TADIR-GENFLAG DEFAULT SPACE
*"     VALUE(IV_PROGRAM) LIKE  SY-REPID DEFAULT SPACE
*"     VALUE(IV_OBJECT_CLASS_SUPPORTS_MA) TYPE  C DEFAULT SPACE
*"     VALUE(IV_EXTEND) TYPE  C DEFAULT SPACE
*"     VALUE(IV_SUPPRESS_DIALOG) TYPE  C DEFAULT SPACE
*"     VALUE(IV_MOD_LANGU) LIKE  SY-LANGU DEFAULT SPACE
*"     VALUE(IV_ACTIVATION_CALL) TYPE  C DEFAULT SPACE
*"  EXPORTING
*"     VALUE(EV_DEVCLASS) LIKE  TADIR-DEVCLASS
*"     VALUE(EV_KORRNUM) LIKE  E070-TRKORR
*"     VALUE(EV_ORDERNUM) LIKE  E070-TRKORR
*"     VALUE(EV_NEW_CORR_ENTRY)
*"     VALUE(EV_AUTHOR) LIKE  SY-UNAME
*"     VALUE(EV_TRANSPORT_KEY) LIKE  TRKEY STRUCTURE  TRKEY
*"     VALUE(EV_NEW_EXTEND) TYPE  C
*"  EXCEPTIONS
*"      CANCELLED
*"      PERMISSION_FAILURE
*"      UNKNOWN_OBJECTCLASS
*"--------------------------------------------------------------------

  CALL FUNCTION 'RS_CORR_INSERT'
    EXPORTING
      object                   = iv_object
      object_class             = iv_object_class
      mode                     = iv_mode
      global_lock              = iv_global_lock
      devclass                 = iv_devclass
      korrnum                  = iv_korrnum
      use_korrnum_immediatedly = iv_use_korrnum_immediatedly
      author                   = iv_author
      master_language          = iv_master_language
      genflag                  = iv_genflag
      program                  = iv_program
      object_class_supports_ma = iv_object_class_supports_ma
      extend                   = iv_extend
      suppress_dialog          = iv_suppress_dialog
      mod_langu                = iv_mod_langu
      activation_call          = iv_activation_call
    IMPORTING
      devclass                 = ev_devclass
      korrnum                  = ev_korrnum
      ordernum                 = ev_ordernum
      new_corr_entry           = ev_new_corr_entry
      author                   = ev_author
      transport_key            = ev_transport_key
      new_extend               = ev_new_extend
    EXCEPTIONS
      cancelled                = 1
      permission_failure       = 2
      unknown_objectclass      = 3
      OTHERS                   = 4.
  IF sy-subrc <> 0.

    CASE sy-subrc.

      WHEN 1.

        RAISE cancelled.

      WHEN 2.

        RAISE permission_failure.

      WHEN 3.

        RAISE unknown_objectclass.

    ENDCASE.

  ENDIF.

ENDFUNCTION.
