INTERFACE /gicom/if_constants_tpara
  PUBLIC .



  CONSTANTS:

    "! URL to be used when navigating to a contract.
    "! This parameter is mostly used for ANW contract matrix; if set accordingly,
    "! navigation to external systems is possible.
    "!
    "! The URL must provide the place holders "{contractId}" and "{contractVariant}", which
    "! will be replaced with the corresponding values by the front-end application.
    "!
    "! The key must be suffixed with a slash the target system RFC destination, as maintained in
    "! /GICOM/TRFC_OBJ.
    cv_contract_view_url_prefix TYPE /gicom/key_para VALUE 'CONTRACT_VIEW_URL' ##NO_TEXT,

    "! Defines an organization level that the turnover will be split onto when using the
    "! "Turnover details" button in the total business screen.
    "!
    cv_baa_split_turnover_org_lvl TYPE /gicom/key_para VALUE 'BAA_SPLIT_TURNOVER_ORG_LVL' ##NO_TEXT,

    "! Boolean value ('X' / '') indicating whether the status change to a corresponding
    "! status will trigger an automatic total business build.
    "!
    cv_baa_trigger_status_change TYPE /gicom/key_para VALUE 'TRIGGER_BAA_STATUS_CHANGE' ##NO_TEXT,

    "! Boolean value ('X' / '') indicating if the total business screen should suppress
    "! base references that are equal to the total turnover.
    "!
    cv_baa_hide_equal_base_ref TYPE /gicom/key_para VALUE 'BAA_HIDE_EQUAL_BASE_REF' ##NO_TEXT,

    "! TODO: document
    cv_bupa_relationship_category TYPE /gicom/key_para VALUE 'BUPA_RELATIONSHIP_CATEGORY' ##NO_TEXT,

    "! TODO: document
    cv_bupa_relationship_dep_nr TYPE /gicom/key_para VALUE 'BUPA_RELATIONSHIP_ABTNR' ##NO_TEXT,

    "! TODO: document
    cv_css_supplying_select_group TYPE /gicom/key_para VALUE 'CCS_SUPPLYING_SELECT_GROUP' ##NO_TEXT,

    "! Boolean value ('X' / '') indicating whether the min/max calculation should be disabled.
    cv_disable_min_max_calculation TYPE /gicom/key_para VALUE 'NO_MIN_MAX_CALCULATION' ##NO_TEXT,

    "! Boolean value ('X' / '') to enable the legacy dynamic appendix (not layout designer based)
    cv_enable_deprecated_dyn_appx TYPE /gicom/key_para VALUE 'DYNAMIC_APPENDIX_ACTIVE' ##NO_TEXT,

    "! Boolean value ('X' / '') to enable the approval flow in the cancellation process
    cv_enable_approval_in_cancel TYPE /gicom/key_para VALUE 'ENABLE_APPROVAL_IN_CANCELLATION' ##NO_TEXT,

    "! Name of active virus scan profile for file uploads and downloads. Set to undefined ("-") to
    "! disable the virus scan entirely.
    cv_virus_scan_profile TYPE /gicom/key_para VALUE 'VSCAN_PROFILE' ##NO_TEXT,

    "! Boolean value ('X' / '') to allow changing the target relevance through the total business.
    cv_baa_allow_edit_target_rel TYPE /gicom/key_para VALUE 'BAA_ALLOW_EDIT_TARGET' ##NO_TEXT,

    "! Boolean value ('X' / '') to allow changing the calculation relevance through the total business.
    cv_baa_allow_edit_calc_rel TYPE /gicom/key_para VALUE 'BAA_ALLOW_EDIT_CALC' ##NO_TEXT,

    "! Boolean value ('X' / '') to enable WINGS developer mode.
    cv_wings_enable_dev_mode TYPE /gicom/key_para VALUE 'WINGS_DEVELOPMENT_MODE' ##NO_TEXT,

    "! TODO: document
    cv_import_to_ignore_price TYPE /gicom/key_para VALUE 'IMPORT_TO_PRICE_IGNORE' ##NO_TEXT,

    "! Possibility to override the theme used in the front-end application.
    "!
    "! IMPORTANT: Overriding the theme can cause display bugs!
    cv_ui5_theme TYPE /gicom/key_para VALUE 'UI5_THEME' ##NO_TEXT,

    "! Boolean value ('X' / '') to enable backend number format
    cv_override_number_format TYPE /gicom/key_para VALUE 'OVERRIDE_NUMBER_FORMAT' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether the selected sender(s) should be
    "! preallocated in the sender filter of the grouping search help in the agreement maintenance
    "! INS MR M.18534
    cv_preallocate_grouping_sh_snd TYPE /gicom/key_para VALUE 'PREALLOCATE_GROUPING_SH_SENDER' ##NO_TEXT,

    "! Locking Timeout value for PMR Transfer
    cv_pmr_enque_timeout TYPE /gicom/key_para VALUE 'PMR_ENQUE_TIMEOUT' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether gicom AD synchronization with PMR or not.
    cv_sync_with_pmr TYPE /gicom/key_para VALUE 'X_SYNC_WITH_PMR' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether PMR related agreements settles via gicom or not
    cv_pmr_settles_via_gicom TYPE /gicom/key_para VALUE 'X_PMR_SETTLES_VIA_GICOM' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether Old authorization objects are allowed or not
    cv_allow_old_authorization TYPE /gicom/key_para VALUE 'X_ALLOW_OLD_AUTHORIZATION' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether ccs calendar entries which are not settled should be deleted
    cv_smi_del_not_settled_cal TYPE /gicom/key_para VALUE 'X_SMI_DEL_NOT_SETTLED_CAL' ##NO_TEXT,

    cv_show_pmr_only_tiles TYPE /gicom/key_para VALUE 'X_SHOW_PMR_ONLY_TILES' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether the fix allocation should distribute the entire agreement validity or only until the last completed month
    cv_cc_fix_alloc_entire_val  TYPE /gicom/key_para VALUE 'X_CC_FIX_ALLOCATE_ENTIRE_VALIDITY' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether the fix allocation should distribute the entire agreement validity or only until the last completed month
    cv_cc_fix_rounding_entire_val  TYPE /gicom/key_para VALUE 'X_CC_FIX_ROUNDING_ENTIRE_VALIDITY' ##NO_TEXT,

    "! Timeout in seconds where the build of the BUPA SMO on the second ( or more ) instance server runs into a timeout
    cv_bupa_smo_timeout  TYPE /gicom/key_para VALUE 'BUPA_SMO_ENQUEUE_TIMEOUT' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether the internal info step should be shown in the contract wizard
    cv_disable_internal_info_step TYPE /gicom/key_para VALUE 'X_DISABLE_INT_INFO_STEP' ##NO_TEXT,

    "! Boolean Value ('X' / '') indicating whether function for edit participant is usable or not
    cv_edit_partic TYPE /gicom/key_para VALUE 'X_EDIT_PARTIC' ##NO_TEXT.
ENDINTERFACE.
