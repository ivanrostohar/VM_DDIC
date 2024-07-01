INTERFACE /gicom/if_dso_sim_result
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS insert_sim_result
    IMPORTING
      !it_sim_result       TYPE /gicom/sim_result_a_tt
      !iv_commit           TYPE xflag DEFAULT 'X'
    RETURNING
      VALUE(rt_sim_result) TYPE /gicom/sim_result_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_sim_result_for_trans_id
    IMPORTING
      !iv_sim_trans_id     TYPE /gicom/sim_trans_id
    RETURNING
      VALUE(rt_sim_result) TYPE /gicom/sim_result_a_tt .
  METHODS select_sim_result_for_agrmt
    IMPORTING
      !itr_sim_trans_id    TYPE /gicom/sim_trans_id_rtt OPTIONAL
      !itr_agreement_id    TYPE /gicom/agrmt_id_rtt
      !itr_fragment_id     TYPE /gicom/sim_frgmt_id_rtt
    RETURNING
      VALUE(rt_sim_result) TYPE /gicom/sim_result_a_tt .
  METHODS delete_for_agrmt_and_fragmt
    IMPORTING
      !itr_fragment_id  TYPE /gicom/sim_frgmt_id_rtt
      !itr_agreement_id TYPE /gicom/agrmt_id_rtt OPTIONAL
      !iv_commit        TYPE /gicom/abap_bool DEFAULT abap_true
      !iv_incl_dis      TYPE /gicom/abap_bool DEFAULT abap_true
    RAISING
      /gicom/cx_root_ds .
  METHODS update_for_agrmt_and_fragmt
    IMPORTING
      !it_sim_results       TYPE /gicom/sim_result_a_tt
      !iv_commit            TYPE /gicom/abap_bool DEFAULT 'X'
    RETURNING
      VALUE(rt_sim_results) TYPE /gicom/sim_result_a_tt
    RAISING
      /gicom/cx_internal_error .
  METHODS select_sim_dishead_disresult
    IMPORTING
      !iv_read_disresult TYPE /gicom/abap_bool OPTIONAL
      !itr_dis_id        TYPE /gicom/sim_distribution_id_rtt OPTIONAL
      !itr_dis_mode      TYPE /gicom/distribution_mode_rtt OPTIONAL
      !iv_date_from      TYPE /gicom/date_from OPTIONAL
      !iv_date_to        TYPE /gicom/date_to OPTIONAL
      !itr_dis_key       TYPE /gicom/distkey_rtt OPTIONAL
      !itr_dis_cntr      TYPE /gicom/contract_id_rtt OPTIONAL
      !itr_agrmt_id      TYPE /gicom/agrmt_id_rtt OPTIONAL
      !itr_sim_frgmt     TYPE /gicom/sim_frgmt_id_rtt OPTIONAL
      !itr_dim_id        TYPE /gicom/dim_id_rtt OPTIONAL
    RETURNING
      VALUE(rt_dishead)  TYPE /gicom/sim_dishead_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_sim_disresult
    IMPORTING
      !itr_dis_id         TYPE /gicom/sim_distribution_id_rtt OPTIONAL
      !itr_dis_mode       TYPE /gicom/distribution_mode_rtt OPTIONAL
      !iv_date_from       TYPE /gicom/date_from OPTIONAL
      !iv_date_to         TYPE /gicom/date_to OPTIONAL
      !itr_dis_key        TYPE /gicom/distkey_rtt OPTIONAL
      !itr_dis_cntr       TYPE /gicom/contract_id_rtt OPTIONAL
      !itr_agrmt_id       TYPE /gicom/agrmt_id_rtt OPTIONAL
      !itr_sim_frgmt      TYPE /gicom/sim_frgmt_id_rtt
      !itr_dim_id         TYPE /gicom/dim_id_rtt OPTIONAL
    RETURNING
      VALUE(rt_disresult) TYPE /gicom/sim_disresult_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS delete_sim_dishead_disresult
    IMPORTING
      !iv_commit     TYPE /gicom/abap_bool DEFAULT abap_true
      !it_dishead    TYPE /gicom/sim_dishead_a_tt OPTIONAL
      !itr_dis_id    TYPE /gicom/sim_distribution_id_rtt OPTIONAL
      !itr_dis_mode  TYPE /gicom/distribution_mode_rtt OPTIONAL
      !itr_dis_key   TYPE /gicom/distkey_rtt OPTIONAL
      !itr_dis_cntr  TYPE /gicom/contract_id_rtt OPTIONAL
      !itr_agrmt_id  TYPE /gicom/agrmt_id_rtt OPTIONAL
      !itr_sim_frgmt TYPE /gicom/sim_frgmt_id_rtt
    RAISING
      /gicom/cx_root_ds .
  METHODS update_sim_dishead
    IMPORTING
      !it_dishead       TYPE /gicom/sim_dishead_a_tt
      !iv_commit        TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_dishead) TYPE /gicom/sim_dishead_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS update_sim_disresult
    IMPORTING
      !it_disresult       TYPE /gicom/sim_disresult_a_tt
      !iv_commit          TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_disresult) TYPE /gicom/sim_disresult_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_sim_disresult
    IMPORTING
      !it_disresult       TYPE /gicom/sim_disresult_a_tt
      !iv_commit          TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_disresult) TYPE /gicom/sim_disresult_a_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_sim_dishead_disresult
    IMPORTING
      !it_dishead       TYPE /gicom/sim_dishead_a_tt
      !iv_commit        TYPE /gicom/abap_bool DEFAULT abap_true
    RETURNING
      VALUE(rt_dishead) TYPE /gicom/sim_dishead_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_root_ds .
ENDINTERFACE.
