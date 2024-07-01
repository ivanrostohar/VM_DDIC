INTERFACE /gicom/if_dso_result
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS insert_result
    IMPORTING
      !it_result       TYPE /gicom/result_a_tt
      !iv_commit       TYPE xflag DEFAULT 'X'
    RETURNING
      VALUE(rt_result) TYPE /gicom/result_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_result
    IMPORTING
      !itr_dis_id       TYPE /gicom/distribution_id_rtt OPTIONAL
      !itr_trans_id     TYPE /gicom/trans_id_rtt OPTIONAL
      !itr_agreement_id TYPE /gicom/agrmt_id_rtt OPTIONAL
      !itr_cond_type    TYPE /gicom/cond_type_rtt OPTIONAL
      !itr_dim_id       TYPE /gicom/dim_id_rtt OPTIONAL
      !iv_date_from     TYPE /gicom/valid_from OPTIONAL
      !iv_date_to       TYPE /gicom/valid_to OPTIONAL
    RETURNING
      VALUE(rt_result)  TYPE /gicom/result_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS delete
    IMPORTING
      !itr_agreement_id TYPE /gicom/agrmt_id_rtt OPTIONAL
      !itr_trans_id     TYPE /gicom/trans_id_rtt OPTIONAL
      !iv_commit        TYPE xflag DEFAULT 'X'
    RAISING
      /gicom/cx_not_found
      /gicom/cx_invalid_arguments
      /gicom/cx_internal_error .
  METHODS update
    IMPORTING
      !it_result       TYPE /gicom/result_a_tt
      !iv_commit       TYPE /gicom/abap_bool DEFAULT 'X'
    RETURNING
      VALUE(rt_result) TYPE /gicom/result_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_dishead_disresult
    IMPORTING
      !iv_read_disresult TYPE /gicom/abap_bool DEFAULT abap_false
      !itr_dis_id        TYPE /gicom/distribution_id_rtt OPTIONAL
      !itr_dis_mode      TYPE /gicom/distribution_mode_rtt OPTIONAL
      !iv_date_from      TYPE /gicom/date_from OPTIONAL
      !iv_date_to        TYPE /gicom/date_to OPTIONAL
      !itr_dis_key       TYPE /gicom/distkey_rtt OPTIONAL
      !itr_dis_cntr      TYPE /gicom/contract_id_rtt OPTIONAL
      !itr_agrmt_id      TYPE /gicom/agrmt_id_rtt OPTIONAL
      !itr_sim_frgmt     TYPE /gicom/sim_frgmt_id_rtt
      !itr_dim_id        TYPE /gicom/dim_id_rtt OPTIONAL
      !iv_curr_loc       TYPE /gicom/curr_loc OPTIONAL
      !iv_curr_grp       TYPE /gicom/curr_grp OPTIONAL
      !itr_time_ref      TYPE /gicom/time_ref_id_rtt OPTIONAL
    RETURNING
      VALUE(rt_dishead)  TYPE /gicom/dishead_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_disresult
    IMPORTING
      !itr_dis_id         TYPE /gicom/distribution_id_rtt OPTIONAL
      !itr_dis_mode       TYPE /gicom/distribution_mode_rtt OPTIONAL
      !iv_date_from       TYPE /gicom/date_from OPTIONAL
      !iv_date_to         TYPE /gicom/date_to OPTIONAL
      !itr_dis_key        TYPE /gicom/distkey_rtt OPTIONAL
      !itr_dis_cntr       TYPE /gicom/contract_id_rtt OPTIONAL
      !itr_agrmt_id       TYPE /gicom/agrmt_id_rtt OPTIONAL
      !itr_sim_frgmt      TYPE /gicom/sim_frgmt_id_rtt
      !itr_dim_id         TYPE /gicom/dim_id_rtt OPTIONAL
      !iv_curr_loc        TYPE /gicom/curr_loc OPTIONAL
      !iv_curr_grp        TYPE /gicom/curr_grp OPTIONAL
      !itr_time_ref       TYPE /gicom/time_ref_id_rtt OPTIONAL
    RETURNING
      VALUE(rt_disresult) TYPE /gicom/disresult_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS delete_dishead_disresult
    IMPORTING
      !iv_commit    TYPE /gicom/abap_bool DEFAULT abap_true
      !it_dishead   TYPE /gicom/dishead_a_tt OPTIONAL
      !itr_dis_id   TYPE /gicom/distribution_id_rtt OPTIONAL
      !itr_dis_mode TYPE /gicom/distribution_mode_rtt OPTIONAL
      !itr_dis_key  TYPE /gicom/distkey_rtt OPTIONAL
      !itr_dis_cntr TYPE /gicom/contract_id_rtt OPTIONAL
      !itr_agrmt_id TYPE /gicom/agrmt_id_rtt OPTIONAL
    RAISING
      /gicom/cx_root_ds .
  METHODS update_dishead
    IMPORTING
      !it_dishead       TYPE /gicom/dishead_a_tt
      !iv_commit        TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_dishead) TYPE /gicom/dishead_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS update_disresult
    IMPORTING
      !it_disresult       TYPE /gicom/disresult_a_tt
      !iv_commit          TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_disresult) TYPE /gicom/disresult_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_disresult
    IMPORTING
      !it_disresult       TYPE /gicom/disresult_a_tt
      !iv_commit          TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_disresult) TYPE /gicom/disresult_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_dishead_disresult
    IMPORTING
      !it_dishead       TYPE /gicom/dishead_a_tt
      !iv_commit        TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_dishead) TYPE /gicom/dishead_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_settlement_result
    IMPORTING
      !itr_inv_no      TYPE /gicom/guid_settlement_rtt
    RETURNING
      VALUE(rt_result) TYPE /gicom/result_a_tt
    RAISING
      /gicom/cx_root_ds.
  METHODS select_open_settled_result
    IMPORTING
      !it_settlement_no           TYPE /gicom/settlement_number_tt
    EXPORTING
      et_result      TYPE /gicom/result_a_tt
      et_result_open TYPE /gicom/result_a_tt
    RAISING
      /gicom/cx_root_ds.

ENDINTERFACE.
