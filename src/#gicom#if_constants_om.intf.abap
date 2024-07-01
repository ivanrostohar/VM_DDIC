INTERFACE /gicom/if_constants_om
  PUBLIC .


  CONSTANTS:
    BEGIN OF cv_om_type,
      "! internal organization
      org_int TYPE /gicom/org_typ VALUE 'O' ##NO_TEXT,
      "! article group
      art_grp TYPE /gicom/org_typ VALUE 'A' ##NO_TEXT,
      "! external organization
      org_ext TYPE /gicom/org_typ VALUE 'E' ##NO_TEXT,
    END OF cv_om_type .
  CONSTANTS cv_default_prio_partner TYPE /gicom/hier_prio VALUE '99' ##NO_TEXT.
  CONSTANTS cv_default_prio_art TYPE /gicom/hier_prio VALUE '99' ##NO_TEXT.
  CONSTANTS cv_prio_suppl TYPE string VALUE 'PRIO' ##NO_TEXT.
  CONSTANTS:
    BEGIN OF gc_lvl_type,
      internal      TYPE /gicom/org_typ VALUE 'O',
      external      TYPE /gicom/org_typ VALUE 'E',
      article_group TYPE /gicom/org_typ VALUE 'A',
      both          TYPE /gicom/org_typ VALUE ' ',
    END OF gc_lvl_type .
  CONSTANTS:
    BEGIN OF gc_model,
      org_unit TYPE /gicom/corgmodel VALUE 'O',
      article  TYPE /gicom/corgmodel VALUE 'A',
    END OF gc_model .
  CONSTANTS:
    BEGIN OF gc_dyn_model,
      customer TYPE /gicom/corgmodel VALUE 'C',
      supplier TYPE /gicom/corgmodel VALUE 'S',
      article  TYPE /gicom/corgmodel VALUE 'A',
    END OF gc_dyn_model .
  CONSTANTS:
    BEGIN OF gc_org_rel_type,
      org_unit              TYPE /gicom/type_relo VALUE 'ORG',
      authority_negotiation TYPE /gicom/type_relo VALUE 'AON',
      article               TYPE /gicom/type_relo VALUE 'ART',
      external              TYPE /gicom/type_relo VALUE 'EXT',
    END OF gc_org_rel_type .
  CONSTANTS:
    BEGIN OF gc_tabname,
      org_model       TYPE tabname VALUE  '/GICOM/TORGMDL',
      level           TYPE tabname VALUE  '/GICOM/TORGLVL',
      level_rel       TYPE tabname VALUE  '/GICOM/TORGLVLRL',
      org_int         TYPE tabname VALUE  '/GICOM/TORG_INT',
      org_ext         TYPE tabname VALUE  '/GICOM/ORG_EXT',
      org_rel         TYPE tabname VALUE  '/GICOM/TORG_DREL',
      org_rel_all     TYPE tabname VALUE  '/GICOM/TORG_REL',
      org_model_draft TYPE tabname VALUE '/GICOM/TCORGMDLD',
      level_draft     TYPE tabname VALUE '/GICOM/TCORGLVLD',
      level_rel_draft TYPE tabname VALUE '/GICOM/TCORGLRLD',
      org_int_draft   TYPE tabname VALUE '/GICOM/TCORGINTD',
      org_rel_draft   TYPE tabname VALUE '/GICOM/TCORGRELD',
      org_erel        TYPE tabname VALUE '/GICOM/ORGEXTREL',
      mat_ext         TYPE tabname VALUE '/GICOM/MAT_EXT',
    END OF gc_tabname .
  CONSTANTS:
    BEGIN OF gc_om_status,
      new    TYPE /gicom/corgmodel_status VALUE ' ',
      active TYPE /gicom/corgmodel_status VALUE 'A',
      change TYPE /gicom/corgmodel_status VALUE 'C',
    END OF gc_om_status .
  CONSTANTS:
    BEGIN OF gc_delete_response,
      delete_childs TYPE char1 VALUE 'D',
      assign_childs TYPE char1 VALUE 'A',
    END OF gc_delete_response .
  CONSTANTS gc_root_org_unit TYPE /gicom/oid VALUE 'ALL' ##NO_TEXT.
  CONSTANTS gc_ultimo_valid_from TYPE /gicom/valid_from VALUE '00010101' ##NO_TEXT.
  CONSTANTS gc_ultimo_valid_to TYPE /gicom/valid_to VALUE '99991231' ##NO_TEXT.
  CONSTANTS gc_msg_class TYPE arbgb VALUE '/GICOM/MSG_ORG_01' ##NO_TEXT.
  CONSTANTS:
    BEGIN OF gc_message,
      bo_type   TYPE /gicom/bo_typ VALUE '/GICOM/OM',
      object    TYPE balhdr-object    VALUE '/GICOM/CUSTOMIZING',
      subobject TYPE balhdr-subobject VALUE '/GICOM/OM',
    END OF gc_message .
  CONSTANTS gc_prio_incrementer TYPE /gicom/hier_prio VALUE '10' ##NO_TEXT.
  CONSTANTS gc_root_priority TYPE /gicom/hier_prio VALUE '0' ##NO_TEXT.
  CONSTANTS gc_dynamic_priority TYPE /gicom/hier_prio VALUE '988' ##NO_TEXT.
  CONSTANTS gc_self_priority TYPE /gicom/hier_prio VALUE '999' ##NO_TEXT.
  CONSTANTS:
    BEGIN OF gc_root_level,
      org_unit TYPE /gicom/orglvl VALUE 'ALL' ##NO_TEXT,
      article  TYPE /gicom/orglvl VALUE 'GOOD' ##NO_TEXT,
    END OF gc_root_level .
  CONSTANTS:
    BEGIN OF gc_change_type,
      meta_model TYPE /gicom/corgmdlchng VALUE 'M',
      org_model  TYPE /gicom/corgmdlchng VALUE 'O',
    END OF gc_change_type .
  CONSTANTS:
    BEGIN OF gc_org_class,
      virtual TYPE char1 VALUE 'V',
      real    TYPE char1 VALUE 'R',
    END OF gc_org_class .
  CONSTANTS:
    BEGIN OF gc_level_type,
      hierarchical TYPE /gicom/cleveltype VALUE 'H',
      matrix       TYPE /gicom/cleveltype VALUE 'M',
    END OF gc_level_type .
  CONSTANTS:
    BEGIN OF gc_field_name,
      valid_from      TYPE fieldname VALUE 'VALID_FROM',
      valid_to        TYPE fieldname VALUE 'VALID_TO',
      updkz           TYPE fieldname VALUE 'UPDKZ',
**** Versioning new design
      date_created    TYPE fieldname VALUE 'DATE_CREATED',
      date_activated  TYPE fieldname VALUE 'DATE_ACTIVATED',
      date_terminated TYPE fieldname VALUE 'DATE_TERMINATED',
      version         TYPE fieldname VALUE 'VERSION',
**
      abbrev          TYPE fieldname VALUE 'ABBREV',
      title           TYPE fieldname VALUE 'TITLE',
      type            TYPE fieldname VALUE 'TYPE',
      lvl             TYPE fieldname VALUE 'LVL',
      color           TYPE fieldname VALUE 'COLOR',
      orgcls          TYPE fieldname VALUE 'ORGCLS',
      icon            TYPE fieldname VALUE 'ICON',
      leveltype       TYPE fieldname VALUE 'LEVELTYPE',
      alwdyn          TYPE fieldname VALUE 'ALWDYN',
      omittable       TYPE fieldname VALUE 'OMITTABLE',
      sync_bukrs      TYPE fieldname VALUE 'SYNC_BUKRS',
      sync_vkorg      TYPE fieldname VALUE 'SYNC_VKORG',
      sync_vtweg      TYPE fieldname VALUE 'SYNC_VTWEG',
      sync_spart      TYPE fieldname VALUE 'SYNC_SPART',
      x_break_down    TYPE fieldname VALUE 'X_BREAK_DOWN',
      sync_kostl      TYPE fieldname VALUE 'SYNC_KOSTL',
      sync_ekorg      TYPE fieldname VALUE 'SYNC_EKORG',
      sync_ekgrp      TYPE fieldname VALUE 'SYNC_EKGRP',
      sync_werks      TYPE fieldname VALUE 'SYNC_WERKS',
      sync_cust       TYPE fieldname VALUE 'SYNC_CUST',
      sync_supp       TYPE fieldname VALUE 'SYNC_SUPP',
      sync_matkl      TYPE fieldname VALUE 'SYNC_MATKL',
      sync_prodh      TYPE fieldname VALUE 'SYNC_PRODH',
      id              TYPE fieldname VALUE 'ID',
      aon             TYPE fieldname VALUE 'AON',
      rov             TYPE fieldname VALUE 'ROV',
      operator        TYPE fieldname VALUE 'OPERATOR',
      ccode_grp       TYPE fieldname VALUE 'CCODE_GRP',
      ccode_rep       TYPE fieldname VALUE 'CCODE_REP',
      bukrs           TYPE fieldname VALUE 'BUKRS',
      vkorg           TYPE fieldname VALUE 'VKORG',
      vtweg           TYPE fieldname VALUE 'VTWEG',
      spart           TYPE fieldname VALUE 'SPART',
      kostl           TYPE fieldname VALUE 'KOSTL',
      ekorg           TYPE fieldname VALUE 'EKORG',
      ekgrp           TYPE fieldname VALUE 'EKGRP',
      werks           TYPE fieldname VALUE 'WERKS',
      matkl           TYPE fieldname VALUE 'MATKL',
      prodh           TYPE fieldname VALUE 'PRODH',
      agrmt           TYPE fieldname VALUE 'AGRMT',
    END OF gc_field_name .
  CONSTANTS:
    BEGIN OF gc_msg_context,
      level TYPE tabname VALUE '/GICOM/CLDF_MSG_CTX_S',
      unit  TYPE tabname VALUE '/GICOM/CORG_MSG_CTX_S',
    END OF gc_msg_context .
  CONSTANTS gc_ui_default_color TYPE /gicom/ccolor VALUE '#268202' ##NO_TEXT.
  CONSTANTS gc_ui_default_icon TYPE /gicom/ui5_icon VALUE 'sap-icon://home' ##NO_TEXT.
  CONSTANTS:
    BEGIN OF gc_secondary_key,
      filter TYPE seckeyname VALUE 'FILTER',
      updkz  TYPE seckeyname VALUE 'UPDKZ',
    END OF gc_secondary_key .
  CONSTANTS:
    BEGIN OF gc_domain,
      model      TYPE domname VALUE '/GICOM/CORGMODEL',
      dyn_model  TYPE domname VALUE '/GICOM/CORGMODELD',
      orgcls     TYPE domname VALUE '/GICOM/CORGCLASS',
      leveltype  TYPE domname VALUE '/GICOM/CLEVELTYPE',
      level_type TYPE domname VALUE '/GICOM/ORG_TYP',
    END OF gc_domain .
  CONSTANTS gc_temp_character TYPE char1 VALUE 'Z' ##NO_TEXT.
**** Versioning new design
  CONSTANTS gc_initial_version TYPE /gicom/version VALUE '001' ##NO_TEXT.
  CONSTANTS gc_ultimo_version TYPE /gicom/version VALUE '999' ##NO_TEXT.
  CONSTANTS gc_org_prio_incrementer TYPE /gicom/hier_prio VALUE '100' ##NO_TEXT.
  CONSTANTS gc_org_dynamic_priority TYPE /gicom/hier_prio VALUE '9998' ##NO_TEXT.
  CONSTANTS gc_org_self_priority TYPE /gicom/hier_prio VALUE '9999' ##NO_TEXT.
  CONSTANTS gc_art_prio_incrementer TYPE /gicom/hier_prio VALUE '1' ##NO_TEXT.
  CONSTANTS gc_art_dynamic_priority TYPE /gicom/hier_prio VALUE '98' ##NO_TEXT.
  CONSTANTS gc_art_self_priority TYPE /gicom/hier_prio VALUE '99' ##NO_TEXT.
ENDINTERFACE.
