INTERFACE /gicom/if_dso_change_reason
  PUBLIC.

  INTERFACES if_badi_interface.

  METHODS:
    select_for_contract
      IMPORTING
        iv_contract_id    TYPE /gicom/contract_id
        iv_for_correction TYPE /gicom/applies_to_correction
        iv_for_addendum   TYPE /gicom/applies_to_addendum
      EXPORTING
        et_change_reason  TYPE /gicom/tcnt_chg_a_tt,

    select_for_negotiation
      IMPORTING
        iv_ng_id         TYPE /gicom/ng_id
      EXPORTING
        et_change_reason TYPE /gicom/tcnt_chg_a_tt,

    select_title
      IMPORTING
        iv_reason              TYPE /gicom/change_reason
      RETURNING
        VALUE(rv_reason_title) TYPE /gicom/title_change_reason
      RAISING
        /gicom/cx_root_ds,

    insert_all_cntr_types_for_rsn
      IMPORTING
        iv_reason TYPE /gicom/change_reason,

    select_selected_reason_for_var
      IMPORTING
        iv_contract_id          TYPE /gicom/contract_id
        iv_variant_no           TYPE /gicom/contract_var_no
      RETURNING
        VALUE(rs_change_reason) TYPE /gicom/change_reason_s
      RAISING
        /gicom/cx_root_ds,

    select_selected_reason_for_add
      IMPORTING
        iv_contract_id          TYPE /gicom/contract_id
        iv_variant_no           TYPE /gicom/contract_var_no
        iv_addend_no            TYPE /gicom/addend_no
      RETURNING
        VALUE(rs_change_reason) TYPE /gicom/change_reason_s
      RAISING
        /gicom/cx_root_ds,

    select_selected_reason_for_ngv
      IMPORTING
        iv_negotiation_id       TYPE /gicom/ng_id
        iv_negotiation_vers     TYPE /gicom/ng_ver_no
      RETURNING
        VALUE(rs_change_reason) TYPE /gicom/change_reason_s
      RAISING
        /gicom/cx_root_ds,

    select_all
      EXPORTING
        et_change_reason  TYPE /gicom/change_reason_title_tt.

ENDINTERFACE.
