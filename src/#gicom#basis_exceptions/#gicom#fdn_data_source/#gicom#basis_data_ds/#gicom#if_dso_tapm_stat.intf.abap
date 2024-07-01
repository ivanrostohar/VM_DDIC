INTERFACE /gicom/if_dso_tapm_stat
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_sap_appl_status
    IMPORTING
      !iv_Settlement_direction   TYPE /gicom/settlement_direction
      !iv_work_status            TYPE /gicom/stl_work_status
    EXPORTING
      ev_sap_application_group   TYPE /gicom/sap_application_group
      ev_sap_appllication_status TYPE /gicom/sap_sm_app_status
    RAISING
      /gicom/cx_sap_appl_status_nf.

ENDINTERFACE.
