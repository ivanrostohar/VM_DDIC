FUNCTION /GICOM/SEO_CLASS_READ .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IS_CLSKEY) TYPE  SEOCLSKEY OPTIONAL
*"     VALUE(IV_VERSION) TYPE  SEOVERSION
*"         DEFAULT SEOC_VERSION_INACTIVE
*"     VALUE(IV_MASTER_LANGUAGE) TYPE  MASTERLANG DEFAULT SY-LANGU
*"     VALUE(IV_MODIF_LANGUAGE) TYPE  MASTERLANG DEFAULT SY-LANGU
*"     VALUE(DESCRIPTION_BYPASSING_BUFFER) TYPE  ABAP_BOOL
*"         DEFAULT ABAP_FALSE
*"  EXPORTING
*"     REFERENCE(ES_CLASS) TYPE  SEOC_CLASS_R
*"--------------------------------------------------------------------

  CALL FUNCTION 'SEO_CLASS_READ'
    EXPORTING
      clskey                       = is_clskey
      version                      = iv_version
      master_language              = iv_master_language
      modif_language               = iv_modif_language
      description_bypassing_buffer = description_bypassing_buffer
    IMPORTING
      class                        = es_class.

ENDFUNCTION.
