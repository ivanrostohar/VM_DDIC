FUNCTION /gicom/seo_class_create_complt .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_CORRNR) TYPE  TRKORR OPTIONAL
*"     VALUE(IV_DEVCLASS) TYPE  DEVCLASS OPTIONAL
*"     VALUE(IV_VERSION) TYPE  SEOVERSION DEFAULT SEOC_VERSION_INACTIVE
*"     VALUE(IV_GENFLAG) TYPE  GENFLAG DEFAULT SPACE
*"     VALUE(IV_AUTHORITY_CHECK) TYPE  SEOX_BOOLEAN DEFAULT SEOX_TRUE
*"     VALUE(IV_OVERWRITE) TYPE  SEOX_BOOLEAN DEFAULT SEOX_FALSE
*"     VALUE(IV_SUPPRESS_METHOD_GENERATION) TYPE  SEOX_BOOLEAN DEFAULT
*"       SEOX_FALSE
*"     VALUE(IVSUPPRESS_REFACTORING_SUPPORT) TYPE  SEOX_BOOLEAN DEFAULT
*"       SEOX_TRUE
*"     REFERENCE(IT_METHOD_SOURCES) TYPE  SEO_METHOD_SOURCE_TABLE
*"       OPTIONAL
*"     REFERENCE(IT_LOCALS_DEF) TYPE  RSWSOURCET OPTIONAL
*"     REFERENCE(IT_LOCALS_IMP) TYPE  RSWSOURCET OPTIONAL
*"     REFERENCE(IT_LOCALS_MAC) TYPE  RSWSOURCET OPTIONAL
*"     REFERENCE(IV_SUPPRESS_INDEX_UPDATE) TYPE  SEOX_BOOLEAN DEFAULT
*"       SEOX_FALSE
*"     REFERENCE(IV_TYPESRC) TYPE  SEOO_TYPESRC OPTIONAL
*"     VALUE(IV_SUPPRESS_CORR) TYPE  SEOX_BOOLEAN DEFAULT SEOX_FALSE
*"     VALUE(IV_SUPPRESS_DIALOG) TYPE  SEOX_BOOLEAN OPTIONAL
*"     REFERENCE(IT_LOCALS_AU) TYPE  RSWSOURCET OPTIONAL
*"     REFERENCE(IO_LOCK_HANDLE) TYPE REF TO  IF_ADT_LOCK_HANDLE
*"       OPTIONAL
*"     VALUE(IV_SUPPRESS_UNLOCK) TYPE  SEOX_BOOLEAN DEFAULT SEOX_FALSE
*"     VALUE(IV_SUPPRESS_COMMIT) TYPE  SEOX_BOOLEAN DEFAULT SEOX_FALSE
*"     VALUE(GENERATE_METHOD_IMPLS_WO_FRAME) TYPE  SEOX_BOOLEAN DEFAULT
*"       SEOX_FALSE
*"  EXPORTING
*"     REFERENCE(EV_KORRNR) TYPE  TRKORR
*"     REFERENCE(EV_CLASS) TYPE  SEOCLSNAME
*"  TABLES
*"      CLASS_DESCRIPTIONS STRUCTURE  SEOCLASSTX OPTIONAL
*"      COMPONENT_DESCRIPTIONS STRUCTURE  SEOCOMPOTX OPTIONAL
*"      SUBCOMPONENT_DESCRIPTIONS STRUCTURE  SEOSUBCOTX OPTIONAL
*"  CHANGING
*"     REFERENCE(CS_CLASS) TYPE  VSEOCLASS
*"     REFERENCE(CS_INHERITANCE) TYPE  VSEOEXTEND OPTIONAL
*"     REFERENCE(CS_REDEFINITIONS) TYPE  SEOR_REDEFINITIONS_R OPTIONAL
*"     REFERENCE(CT_IMPLEMENTINGS) TYPE  SEOR_IMPLEMENTINGS_R OPTIONAL
*"     REFERENCE(CS_IMPL_DETAILS) TYPE  SEO_REDEFINITIONS OPTIONAL
*"     REFERENCE(CS_ATTRIBUTES) TYPE  SEOO_ATTRIBUTES_R OPTIONAL
*"     REFERENCE(CS_METHODS) TYPE  SEOO_METHODS_R OPTIONAL
*"     REFERENCE(CS_EVENTS) TYPE  SEOO_EVENTS_R OPTIONAL
*"     REFERENCE(CS_TYPES) TYPE  SEOO_TYPES_R OPTIONAL
*"     REFERENCE(CS_TYPE_SOURCE) TYPE  SEOP_SOURCE OPTIONAL
*"     REFERENCE(CS_PARAMETERS) TYPE  SEOS_PARAMETERS_R OPTIONAL
*"     REFERENCE(CS_EXCEPS) TYPE  SEOS_EXCEPTIONS_R OPTIONAL
*"     REFERENCE(CT_ALIASES) TYPE  SEOO_ALIASES_R OPTIONAL
*"     REFERENCE(CS_TYPEPUSAGES) TYPE  SEOT_TYPEPUSAGES_R OPTIONAL
*"     REFERENCE(CS_CLSDEFERRDS) TYPE  SEOT_CLSDEFERRDS_R OPTIONAL
*"     REFERENCE(CS_INTDEFERRDS) TYPE  SEOT_INTDEFERRDS_R OPTIONAL
*"     REFERENCE(CT_FRIENDSHIPS) TYPE  SEO_FRIENDS OPTIONAL
*"  EXCEPTIONS
*"      EXISTING
*"      IS_INTERFACE
*"      DB_ERROR
*"      COMPONENT_ERROR
*"      NO_ACCESS
*"      OTHER
*"----------------------------------------------------------------------

  CALL FUNCTION 'SEO_CLASS_CREATE_COMPLETE'
    EXPORTING
      corrnr                         = iv_corrnr
      devclass                       = iv_devclass
      version                        = iv_version
      genflag                        = iv_genflag
      authority_check                = iv_authority_check
      overwrite                      = iv_overwrite
      suppress_method_generation     = iv_suppress_method_generation
      suppress_refactoring_support   = ivsuppress_refactoring_support
      method_sources                 = it_method_sources
      locals_def                     = it_locals_def
      locals_imp                     = it_locals_imp
      locals_mac                     = it_locals_mac
      suppress_index_update          = iv_suppress_index_update
      typesrc                        = iv_typesrc
      suppress_corr                  = iv_suppress_corr
      suppress_dialog                = iv_suppress_dialog
      locals_au                      = it_locals_au
      lock_handle                    = io_lock_handle
      suppress_unlock                = iv_suppress_unlock
      suppress_commit                = iv_suppress_commit
      generate_method_impls_wo_frame = generate_method_impls_wo_frame
    IMPORTING
      korrnr                         = ev_korrnr
    TABLES
      class_descriptions             = class_descriptions
      component_descriptions         = component_descriptions
      subcomponent_descriptions      = subcomponent_descriptions
    CHANGING
      class                          = cs_class
      inheritance                    = cs_inheritance
      redefinitions                  = cs_redefinitions
      implementings                  = ct_implementings
      impl_details                   = cs_impl_details
      attributes                     = cs_attributes
      methods                        = cs_methods
      events                         = cs_events
      types                          = cs_types
      type_source                    = cs_type_source
      parameters                     = cs_parameters
      exceps                         = cs_exceps
      aliases                        = ct_aliases
      typepusages                    = cs_typepusages
      clsdeferrds                    = cs_clsdeferrds
      intdeferrds                    = cs_intdeferrds
      friendships                    = ct_friendships
    EXCEPTIONS
      existing                       = 1
      is_interface                   = 2
      db_error                       = 3
      component_error                = 4
      no_access                      = 5
      other                          = 6
      OTHERS                         = 7.
  IF sy-subrc EQ 0.
    ev_class = cs_class-clsname.
  ELSE.
    CLEAR ev_class.
    RAISE other.
  ENDIF.

ENDFUNCTION.
