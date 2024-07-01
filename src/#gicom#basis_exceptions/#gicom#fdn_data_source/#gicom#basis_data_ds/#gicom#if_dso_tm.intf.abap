INTERFACE /gicom/if_dso_tm
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_tm_data
    EXPORTING
      !et_tmtg  TYPE /gicom/tmgroup_a_stt
      !et_tmtgt TYPE /gicom/tmgroup_text_a_stt
      !et_tmtr  TYPE /gicom/tmrule_a_stt
      !et_tmss  TYPE /gicom/tmss_a_stt
      !et_tmts  TYPE /gicom/tmts_a_stt
    RAISING
      /gicom/cx_root_ds .
  METHODS save_tm_data
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_internal_error
      cx_abap_not_a_table
      cx_abap_not_in_package .
  METHODS execute_tm
    IMPORTING
      !iv_event            TYPE /gicom/trans_event
      !it_groups           TYPE /gicom/transfer_group_tt
      !it_source_copy_data TYPE /gicom/wlf_tm_copy_data_tt
    EXPORTING
      !et_target_copy_data TYPE /gicom/wlf_tm_copy_data_tt .
ENDINTERFACE.
