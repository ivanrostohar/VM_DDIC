FUNCTION /gicom/trint_tadir_interface.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(WI_DELETE_TADIR_ENTRY) TYPE  TRPARI-S_CHECKED DEFAULT ' '
*"     VALUE(WI_REMOVE_REPAIR_FLAG) TYPE  TRPARI-S_CHECKED DEFAULT ' '
*"     VALUE(WI_SET_REPAIR_FLAG) TYPE  TRPARI-S_CHECKED DEFAULT ' '
*"     VALUE(WI_TEST_MODUS) TYPE  TRPARI-S_CHECKED DEFAULT 'X'
*"     VALUE(WI_TADIR_PGMID) TYPE  TADIR-PGMID
*"     VALUE(WI_TADIR_OBJECT) TYPE  TADIR-OBJECT
*"     VALUE(WI_TADIR_OBJ_NAME) TYPE  TADIR-OBJ_NAME
*"     VALUE(WI_TADIR_KORRNUM) TYPE  TADIR-KORRNUM DEFAULT ' '
*"     VALUE(WI_TADIR_SRCSYSTEM) TYPE  TADIR-SRCSYSTEM DEFAULT ' '
*"     VALUE(WI_TADIR_AUTHOR) TYPE  TADIR-AUTHOR DEFAULT ' '
*"     VALUE(WI_TADIR_DEVCLASS) TYPE  TADIR-DEVCLASS DEFAULT ' '
*"     VALUE(WI_TADIR_MASTERLANG) TYPE  TADIR-MASTERLANG DEFAULT ' '
*"     VALUE(WI_TADIR_CPROJECT) TYPE  TADIR-CPROJECT DEFAULT ' '
*"     VALUE(WI_TADIR_VERSID) TYPE  TADIR-VERSID DEFAULT ' '
*"     VALUE(WI_REMOVE_GENFLAG) TYPE  TRPARI-S_CHECKED DEFAULT ' '
*"     VALUE(WI_SET_GENFLAG) TYPE  TADIR-GENFLAG DEFAULT ' '
*"     VALUE(WI_READ_ONLY) TYPE  TRPARI-S_CHECKED DEFAULT ' '
*"     VALUE(IV_SET_EDTFLAG) TYPE  TADIR-EDTFLAG DEFAULT ' '
*"     VALUE(IV_WBO_INTERNAL) TYPE  TRPARI-FLAG DEFAULT ' '
*"     VALUE(IV_INSERT_MODE) TYPE  TRPARI-FLAG DEFAULT ' '
*"     VALUE(IV_TRANSL_TECH_TEXT) TYPE  TADIR-TRANSLTTXT DEFAULT ' '
*"     VALUE(IV_DELFLAG) TYPE  TADIR-DELFLAG DEFAULT ' '
*"     REFERENCE(IV_NO_PAK_CHECK) TYPE  TADIR-PAKNOCHECK DEFAULT ' '
*"     VALUE(IV_OBJ_STABILITY) TYPE  TADIR-OBJSTABLTY DEFAULT ' '
*"     VALUE(IV_TRANSL_TECH_TEXT_SUPP) TYPE  CHAR1 DEFAULT ' '
*"     VALUE(IV_DELFLAG_SUPP) TYPE  CHAR1 DEFAULT ''
*"     VALUE(IV_NO_PAK_CHECK_SUPP) TYPE  CHAR1 DEFAULT ' '
*"     VALUE(IV_OBJ_STABILITY_SUPP) TYPE  CHAR1 DEFAULT ' '
*"     VALUE(WI_TADIR_CHECK_DATE) TYPE  TADIR-CHECK_DATE DEFAULT ''
*"     VALUE(WI_TADIR_CHECK_CFG) TYPE  TADIR-CHECK_CFG DEFAULT '~'
*"  EXPORTING
*"     REFERENCE(NEW_GTADIR_ENTRY) LIKE  GTADIR STRUCTURE  GTADIR
*"     REFERENCE(NEW_TADIR_ENTRY) LIKE  TADIR STRUCTURE  TADIR
*"  EXCEPTIONS
*"      TADIR_ENTRY_NOT_EXISTING
*"      TADIR_ENTRY_ILL_TYPE
*"      NO_SYSTEMNAME
*"      NO_SYSTEMTYPE
*"      ORIGINAL_SYSTEM_CONFLICT
*"      OBJECT_RESERVED_FOR_DEVCLASS
*"      OBJECT_EXISTS_GLOBAL
*"      OBJECT_EXISTS_LOCAL
*"      OBJECT_IS_DISTRIBUTED
*"      OBJ_SPECIFICATION_NOT_UNIQUE
*"      NO_AUTHORIZATION_TO_DELETE
*"      DEVCLASS_NOT_EXISTING
*"      SIMULTANIOUS_SET_REMOVE_REPAIR
*"      ORDER_MISSING
*"      NO_MODIFICATION_OF_HEAD_SYST
*"      PGMID_OBJECT_NOT_ALLOWED
*"      MASTERLANGUAGE_NOT_SPECIFIED
*"      DEVCLASS_NOT_SPECIFIED
*"      SPECIFY_OWNER_UNIQUE
*"      LOC_PRIV_OBJS_NO_REPAIR
*"      GTADIR_NOT_REACHED
*"      OBJECT_LOCKED_FOR_ORDER
*"      CHANGE_OF_CLASS_NOT_ALLOWED
*"      NO_CHANGE_FROM_SAP_TO_TMP
*"----------------------------------------------------------------------

  CALL FUNCTION 'TRINT_TADIR_INTERFACE'
    EXPORTING
      wi_delete_tadir_entry          = wi_delete_tadir_entry
      wi_remove_repair_flag          = wi_remove_repair_flag
      wi_set_repair_flag             = wi_set_repair_flag
      wi_test_modus                  = wi_test_modus
      wi_tadir_pgmid                 = wi_tadir_pgmid
      wi_tadir_object                = wi_tadir_object
      wi_tadir_obj_name              = wi_tadir_obj_name
      wi_tadir_korrnum               = wi_tadir_korrnum
      wi_tadir_srcsystem             = wi_tadir_srcsystem
      wi_tadir_author                = wi_tadir_author
      wi_tadir_devclass              = wi_tadir_devclass
      wi_tadir_masterlang            = wi_tadir_masterlang
      wi_tadir_cproject              = wi_tadir_cproject
      wi_tadir_versid                = wi_tadir_versid
      wi_remove_genflag              = wi_remove_genflag
      wi_set_genflag                 = wi_set_genflag
      wi_read_only                   = wi_read_only
      iv_set_edtflag                 = iv_set_edtflag
      iv_wbo_internal                = iv_wbo_internal
      iv_insert_mode                 = iv_insert_mode
      iv_transl_tech_text            = iv_transl_tech_text
      iv_delflag                     = iv_delflag
      iv_no_pak_check                = iv_no_pak_check
      iv_obj_stability               = iv_obj_stability
      iv_transl_tech_text_supp       = iv_transl_tech_text_supp
      iv_delflag_supp                = iv_delflag_supp
      iv_no_pak_check_supp           = iv_no_pak_check_supp
      iv_obj_stability_supp          = iv_obj_stability_supp
      wi_tadir_check_date            = wi_tadir_check_date
      wi_tadir_check_cfg             = wi_tadir_check_cfg
    IMPORTING
      new_gtadir_entry               = new_gtadir_entry
      new_tadir_entry                = new_tadir_entry
    EXCEPTIONS
      tadir_entry_not_existing       = 1
      tadir_entry_ill_type           = 2
      no_systemname                  = 3
      no_systemtype                  = 4
      original_system_conflict       = 5
      object_reserved_for_devclass   = 6
      object_exists_global           = 7
      object_exists_local            = 8
      object_is_distributed          = 9
      obj_specification_not_unique   = 10
      no_authorization_to_delete     = 11
      devclass_not_existing          = 12
      simultanious_set_remove_repair = 13
      order_missing                  = 14
      no_modification_of_head_syst   = 15
      pgmid_object_not_allowed       = 16
      masterlanguage_not_specified   = 17
      devclass_not_specified         = 18
      specify_owner_unique           = 19
      loc_priv_objs_no_repair        = 20
      gtadir_not_reached             = 21
      object_locked_for_order        = 22
      change_of_class_not_allowed    = 23
      no_change_from_sap_to_tmp      = 24
      OTHERS                         = 25.

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
