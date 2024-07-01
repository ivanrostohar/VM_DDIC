FUNCTION /GICOM/SEO_METHOD_GET_SOURCE .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IS_MTDKEY) TYPE  SEOCPDKEY
*"     VALUE(IV_STATE) TYPE  R3STATE OPTIONAL
*"     VALUE(IV_WITH_ENHANCEMENTS) TYPE  SEOX_BOOLEAN
*"         DEFAULT SEOX_FALSE
*"  EXPORTING
*"     REFERENCE(EV_SOURCE) TYPE  SEOP_SOURCE
*"     REFERENCE(ET_SOURCE_EXPANDED) TYPE  SEOP_SOURCE_STRING
*"     REFERENCE(EV_INCNAME) TYPE  PROGRAM
*"     REFERENCE(ES_RESOLVED_METHOD_KEY) TYPE  SEOCPDKEY
*"  EXCEPTIONS
*"      _INTERNAL_METHOD_NOT_EXISTING
*"      _INTERNAL_CLASS_NOT_EXISTING
*"      VERSION_NOT_EXISTING
*"      INACTIVE_NEW
*"      INACTIVE_DELETED
*"--------------------------------------------------------------------

  CALL FUNCTION 'SEO_METHOD_GET_SOURCE'
    EXPORTING
      mtdkey                        = is_mtdkey
      state                         = iv_state
      with_enhancements             = iv_with_enhancements
    IMPORTING
      source                        = ev_source
      source_expanded               = et_source_expanded
      incname                       = ev_incname
      resolved_method_key           = es_resolved_method_key
    EXCEPTIONS
      _internal_method_not_existing = 1
      _internal_class_not_existing  = 2
      version_not_existing          = 3
      inactive_new                  = 4
      inactive_deleted              = 5
      OTHERS                        = 6.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFUNCTION.
