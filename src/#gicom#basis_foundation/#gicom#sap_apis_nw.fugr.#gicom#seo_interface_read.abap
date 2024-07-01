FUNCTION /GICOM/SEO_INTERFACE_READ .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IS_INTKEY) TYPE  SEOCLSKEY OPTIONAL
*"     VALUE(IV_VERSION) TYPE  SEOVERSION
*"         DEFAULT SEOC_VERSION_INACTIVE
*"     VALUE(IV_MASTER_LANGUAGE) TYPE  MASTERLANG DEFAULT SY-LANGU
*"     VALUE(IV_MODIF_LANGUAGE) TYPE  MASTERLANG DEFAULT SY-LANGU
*"     VALUE(DESCRIPTION_BYPASSING_BUFFER) TYPE  ABAP_BOOL
*"         DEFAULT ABAP_FALSE
*"  EXPORTING
*"     REFERENCE(ES_INTERFACE) TYPE  SEOC_INTERFACE_R
*"--------------------------------------------------------------------

  CALL FUNCTION 'SEO_INTERFACE_READ'
    EXPORTING
      intkey                       = is_intkey
      version                      = iv_version
      master_language              = iv_master_language
      modif_language               = iv_modif_language
      description_bypassing_buffer = description_bypassing_buffer
    IMPORTING
      interface                    = es_interface.

ENDFUNCTION.
