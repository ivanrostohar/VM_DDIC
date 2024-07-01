INTERFACE /gicom/if_dso_tmplt
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_templates
    RETURNING
      VALUE(rt_templates) TYPE /gicom/tbtmphdr_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_wl
    EXPORTING
      !et_tpnum_wl TYPE /gicom/btpnum_wl_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select
    IMPORTING
      !it_tpnum    TYPE /gicom/tbtmphdr_key_tt
    EXPORTING
      !et_btmp_doc TYPE /gicom/btmp_doc_tt
    RAISING
      /gicom/cx_not_found .
  METHODS db_update
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_internal_error .
  METHODS select_appl_templates
    IMPORTING
      !is_template_comm TYPE /gicom/btemplate_comm_s
    EXPORTING
      !et_templates     TYPE /gicom/btemplates_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_tmpl_objs
    EXPORTING
      VALUE(et_template_obj) TYPE /gicom/tbtmapp_tt
      !et_template_obj_txt   TYPE /gicom/tbtmapp_txt_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_tmpl_prs
    EXPORTING
      VALUE(et_template_prs)     TYPE /gicom/tbtmprs_tt
      VALUE(et_template_prs_txt) TYPE /gicom/tbtmprs_txt_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_dataareas
    IMPORTING
      !iv_objprs TYPE /gicom/baplprs
      !iv_objty  TYPE /gicom/bo_typ
    EXPORTING
      !et_tmpda  TYPE /gicom/tbtmprsda_tt
      !et_tmpdat TYPE /gicom/tbtprsdat_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_template_process
    IMPORTING
      !it_templates TYPE /gicom/tbtmphdr_key_tt
    EXPORTING
      !et_tbtmprs   TYPE /gicom/tmpprs_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_template_header
    IMPORTING
      !iv_tmpid  TYPE /gicom/tmpl_name
    EXPORTING
      !es_tmphdr TYPE /gicom/tbtmphdr_s
    RAISING
      /gicom/cx_not_found .
  METHODS select_template_watermark
    EXPORTING
      !et_wmtxt TYPE /gicom/tmwmtxt_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_tmpl_prs_as
    EXPORTING
      !et_tmprsas     TYPE /gicom/tmprsas_tt
      !et_tmprsas_txt TYPE /gicom/tmprsast_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_template_types
    EXPORTING
      !et_tmtyp  TYPE /gicom/tbtmtyp_tt
      !et_tmtypt TYPE /gicom/tbtmtypt_tt .
  METHODS select_contr_templates_doc
    IMPORTING
      !iv_contr_type                   TYPE /gicom/contract_type
    RETURNING
      VALUE(et_contract_doc_templates) TYPE /gicom/tcntdtyp_db_tt .
ENDINTERFACE.
