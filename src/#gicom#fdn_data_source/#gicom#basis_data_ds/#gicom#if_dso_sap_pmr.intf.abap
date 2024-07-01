INTERFACE /gicom/if_dso_sap_pmr

  PUBLIC.
  INTERFACES if_badi_interface.

  METHODS do_commit
    IMPORTING
      !iv_bapi  TYPE /gicom/abap_bool OPTIONAL
      !iv_local TYPE /gicom/abap_bool OPTIONAL
    RAISING
      /gicom/cx_database_error
      /gicom/cx_root_ds .
  METHODS do_rollback
    IMPORTING
      !iv_bapi  TYPE /gicom/abap_bool OPTIONAL
      !iv_local TYPE /gicom/abap_bool OPTIONAL
    RAISING
      /gicom/cx_root_ds
      /gicom/cx_database_error .
  METHODS sync_vendor_fund
    IMPORTING
      !iv_sender                 TYPE logsys
      !iv_key_tst                TYPE /gicom/timestmps
      !iv_src_sys                TYPE logsys
      !it_pmr_vf_header          TYPE /gicom/pmr_vf_header_tt
      !it_pmr_vf_material        TYPE /gicom/pmr_vf_material_tt
      !it_pmr_vf_location        TYPE /gicom/pmr_vf_location_tt
      !it_pmr_vf_distr_channel   TYPE /gicom/pmr_vf_distr_channel_tt
      !it_pmr_vf_amount          TYPE /gicom/pmr_vf_amount_tt
      !it_pmr_vf_material_amount TYPE /gicom/pmr_vf_material_amt_tt
    EXPORTING
      !et_message                TYPE /gicom/bapiret_tt
    RAISING
      /gicom/cx_internal_error .

  METHODS select_vendor_fund
    IMPORTING
      iv_src_sys    TYPE logsys
      it_vdr_ofr_id TYPE /gicom/guid_tt
    EXPORTING
      et_vdr_fund   TYPE /gicom/pmr_bapi_vf_bo_tt
    RAISING
      /gicom/cx_internal_error .

ENDINTERFACE.
