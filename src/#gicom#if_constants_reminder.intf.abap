INTERFACE /gicom/if_constants_reminder
  PUBLIC .

  CONSTANTS:

    cv_appl_object                 TYPE balobj_d                     VALUE '/GICOM/BASIS' ##NO_TEXT,
    cv_sub_object                  TYPE balsubobj                    VALUE '/GICOM/REMINDER' ##NO_TEXT,
    cv_event_contr_created         TYPE /gicom/rem_event             VALUE 'CNTR_CRED' ##NO_TEXT,
    cv_event_contr_changed         TYPE /gicom/rem_event             VALUE 'CNTR_CHND' ##NO_TEXT,
    cv_event_contr_var_created     TYPE /gicom/rem_event             VALUE 'VAR_CRED' ##NO_TEXT,
    cv_event_contr_var_changed     TYPE /gicom/rem_event             VALUE 'VAR_CHND' ##NO_TEXT,
    cv_event_agrmt_changed         TYPE /gicom/rem_event             VALUE 'AGRMT_CHND' ##NO_TEXT,
    cv_event_contr_release_done    TYPE /gicom/rem_event             VALUE 'CRLS_DONE' ##NO_TEXT,
    cv_event_contr_release_deny    TYPE /gicom/rem_event             VALUE 'CRLS_DENY' ##NO_TEXT,
    cv_event_contr_terminate_done  TYPE /gicom/rem_event             VALUE 'CTERM_DONE' ##NO_TEXT,
    cv_event_contr_terminate_deny  TYPE /gicom/rem_event             VALUE 'CTERM_DENY' ##NO_TEXT,
    cv_event_contr_invalidate_deny TYPE /gicom/rem_event             VALUE 'CINVD_DENY' ##NO_TEXT,
    cv_event_contr_invalidate_done TYPE /gicom/rem_event             VALUE 'CINVD_DONE' ##NO_TEXT,
    cv_event_contr_cancel_done     TYPE /gicom/rem_event             VALUE 'CCANC_DONE' ##NO_TEXT,
    cv_event_contr_cancel_deny     TYPE /gicom/rem_event             VALUE 'CCANC_DENY' ##NO_TEXT,
    cv_event_addenda_created       TYPE /gicom/rem_event             VALUE 'ADD_CRED' ##NO_TEXT,
    cv_event_addenda_release_done  TYPE /gicom/rem_event             VALUE 'ADRLS_DONE' ##NO_TEXT,
    cv_event_addenda_release_deny  TYPE /gicom/rem_event             VALUE 'ADRLS_DENY' ##NO_TEXT,
    cv_event_ngr_set_to_negot      TYPE /gicom/rem_event             VALUE 'NGR_NEGOT' ##NO_TEXT,
    cv_event_ngr_set_to_blocked    TYPE /gicom/rem_event             VALUE 'NGR_BLOCK' ##NO_TEXT,
    cv_event_ngr_set_to_complete   TYPE /gicom/rem_event             VALUE 'NGR_COMP' ##NO_TEXT,
    cv_event_ng_changed            TYPE /gicom/rem_event             VALUE 'NG_CHANGED' ##NO_TEXT,
    cv_event_ng_set_to_escalation  TYPE /gicom/rem_event             VALUE 'NG_ESCAL' ##NO_TEXT,
    cv_event_ng_set_to_negot       TYPE /gicom/rem_event             VALUE 'NG_NEGOT' ##NO_TEXT,
    cv_event_ng_set_not_to_negot   TYPE /gicom/rem_event             VALUE 'NG_NOT_NEG' ##NO_TEXT,
    cv_event_ng_set_to_locked      TYPE /gicom/rem_event             VALUE 'NG_LOCKED' ##NO_TEXT,
    cv_event_ng_release_done       TYPE /gicom/rem_event             VALUE 'NGRLS_DONE' ##NO_TEXT,
    cv_event_ng_release_deny       TYPE /gicom/rem_event             VALUE 'NGRLS_DENY' ##NO_TEXT,
    cv_event_ng_completed          TYPE /gicom/rem_event             VALUE 'NG_COMP' ##NO_TEXT,
    cv_event_ng_reloaded           TYPE /gicom/rem_event             VALUE 'BAA_RELOAD' ##NO_TEXT,
    cv_event_ng_new_appointment    TYPE /gicom/rem_event             VALUE 'NEW_APPT' ##NO_TEXT,
    cv_rule_general                TYPE /gicom/rem_rule              VALUE 'GENERAL' ##NO_TEXT,
    cv_rule_contract_expiry        TYPE /gicom/rem_rule              VALUE 'CNTR_EXP' ##NO_TEXT,
    cv_rule_ngr_expiry             TYPE /gicom/rem_rule              VALUE 'NGR_EXP' ##NO_TEXT,
    cv_rule_target_date            TYPE /gicom/rem_rule              VALUE 'TD' ##NO_TEXT,
    cv_rule_next_appointment       TYPE /gicom/rem_rule              VALUE 'NEXT_APP' ##NO_TEXT,
    cv_org_unit_type_aon           TYPE /gicom/org_unit_type         VALUE 'AON' ##NO_TEXT,
    cv_org_unit_type_rov           TYPE /gicom/org_unit_type         VALUE 'ROV' ##NO_TEXT,
    cv_eval_status_new             TYPE /gicom/rem_eval_status       VALUE '01' ##NO_TEXT,
    cv_eval_status_in_process      TYPE /gicom/rem_eval_status       VALUE '02' ##NO_TEXT,
    cv_eval_status_ready_to_proc   TYPE /gicom/rem_eval_status       VALUE '03' ##NO_TEXT,
    cv_eval_status_terminated      TYPE /gicom/rem_eval_status       VALUE '04' ##NO_TEXT,
    cv_eval_status_completed       TYPE /gicom/rem_eval_status       VALUE '05' ##NO_TEXT,
    cv_object_process              TYPE /gicom/baplprs               VALUE 'REMINDER' ##NO_TEXT,
    cv_reminder_type_plain         TYPE /gicom/rem_type              VALUE 'P' ##NO_TEXT,
    cv_reminder_type_rule          TYPE /gicom/rem_type              VALUE 'R' ##NO_TEXT,
    cv_reminder_type_event         TYPE /gicom/rem_type              VALUE 'E' ##NO_TEXT,
    cv_reminder_create             TYPE char1                        VALUE 'H' ##NO_TEXT,
    cv_reminder_change             TYPE char1                        VALUE 'V' ##NO_TEXT,
    cv_reminder_actor_types        TYPE string                       VALUE 'ACTOR_TYPES' ##NO_TEXT,
    cv_reminder_org_unit_types     TYPE string                       VALUE 'ORG_UNIT_TYPES' ##NO_TEXT,
    cv_rules                       TYPE string                       VALUE 'RULES' ##NO_TEXT,
    cv_events                      TYPE string                       VALUE 'EVENTS' ##NO_TEXT,
    cv_scale                       TYPE string                       VALUE 'SCALE' ##NO_TEXT,
    cv_scale_day                   TYPE /gicom/rem_scale             VALUE 'D' ##NO_TEXT,
    cv_scale_week                  TYPE /gicom/rem_scale             VALUE 'W' ##NO_TEXT,
    cv_scale_month                 TYPE /gicom/rem_scale             VALUE 'M' ##NO_TEXT,
    cv_scale_year                  TYPE /gicom/rem_scale             VALUE 'Y' ##NO_TEXT,
    cv_timing                      TYPE string                       VALUE 'TIMING' ##NO_TEXT,
    cv_timing_after                TYPE /gicom/rem_timiing           VALUE 'A' ##NO_TEXT,
    cv_timing_before               TYPE /gicom/rem_timiing           VALUE 'B' ##NO_TEXT,
    cv_timing_immediate            TYPE /gicom/rem_timiing           VALUE 'I' ##NO_TEXT,
    cv_bo_typ                      TYPE /gicom/bo_typ_partic         VALUE 'USER' ##NO_TEXT,
    cv_classification              TYPE /gicom/partic_classification VALUE 'I' ##NO_TEXT,
    cv_tab_rmdr                    TYPE tabname                      VALUE '/GICOM/RMDR' ##NO_TEXT,
    cv_tab_rmdr_act                TYPE tabname                      VALUE '/GICOM/RMDRACT' ##NO_TEXT,
    cv_tab_rmdr_eval               TYPE tabname                      VALUE '/GICOM/RMDREVAL' ##NO_TEXT,
    cv_tab_rmdr_eval_item          TYPE tabname                      VALUE '/GICOM/RMDEVLITM' ##NO_TEXT,
    cv_tab_rmdr_org                TYPE tabname                      VALUE '/GICOM/RMDRORG' ##NO_TEXT.

  " The ACTIVITY_STATUS constants here are OBSOLETE! Use /gicom/if_constants_bo_process-gc_activity_status
  CONSTANTS:
    cv_activity_status_in_progress TYPE /gicom/bafstatu              VALUE 'A' ##NO_TEXT,
    cv_activity_status_canceled    TYPE /gicom/bafstatu              VALUE 'B' ##NO_TEXT,
    cv_activity_status_completed   TYPE /gicom/bafstatu              VALUE 'C' ##NO_TEXT.
  " The ACTIVITY_STATUS constants here are OBSOLETE! Use /gicom/if_constants_bo_process-gc_activity_status

  " The ACTOR_ TYPE constants here are OBSOLETE! Use /gicom/if_constants_bo_process
  CONSTANTS:
    cv_actor_type_user             TYPE /gicom/actor_type            VALUE 'US' ##NO_TEXT,
    cv_actor_type_user_role        TYPE /gicom/actor_type            VALUE 'UR' ##NO_TEXT,
    cv_actor_type_created_by       TYPE /gicom/actor_type            VALUE 'CR' ##NO_TEXT,
    cv_actor_type_last_changed_by  TYPE /gicom/actor_type            VALUE 'CH' ##NO_TEXT,
    cv_actor_type_buyer            TYPE /gicom/actor_type            VALUE 'BU' ##NO_TEXT,
    cv_actor_type_contact_person   TYPE /gicom/actor_type            VALUE 'CP' ##NO_TEXT,
    cv_actor_type_controller       TYPE /gicom/actor_type            VALUE 'CT' ##NO_TEXT,
    cv_actor_type_negotiator1      TYPE /gicom/actor_type            VALUE 'L1' ##NO_TEXT,
    cv_actor_type_negotiator2      TYPE /gicom/actor_type            VALUE 'L2' ##NO_TEXT,
    cv_actor_type_supporter        TYPE /gicom/actor_type            VALUE 'SU' ##NO_TEXT.
  " The ACTOR_TYPE constants here are OBSOLETE! Use /gicom/if_constants_bo_process


ENDINTERFACE.
