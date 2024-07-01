INTERFACE /gicom/if_dso_dynamic
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_values
    IMPORTING
      !it_bo_id_rtt      TYPE /gicom/bo_id_rtt
      !iv_bo_typ         TYPE /gicom/bo_typ
      !it_set_id_rtt     TYPE /gicom/dyn_appendix_set_id_rtt
    EXPORTING
      !et_dynamic_values TYPE /gicom/dyn_appendix_val_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS select_definitions
    IMPORTING
      !itr_appl_type          TYPE /gicom/bappl_type_rtt
      !iv_bo_typ              TYPE /gicom/bo_typ
      !iv_type                TYPE /gicom/dyn_appendix_type
      !iv_date_due            TYPE /gicom/date_due
    EXPORTING
      !et_dynamic_definitions TYPE /gicom/dyn_appendix_def_deep_t
    RAISING
      /gicom/cx_root_ds .
  METHODS insert_update_values
    IMPORTING
      !iv_bo_typ          TYPE /gicom/bo_typ
      !iv_bo_id           TYPE /gicom/bo_id
      !it_dyn_appx_values TYPE /gicom/dyn_appendix_val_tt
    EXPORTING
      !et_dyn_appx_values TYPE /gicom/dyn_appendix_val_tt
    RAISING
      /gicom/cx_root_ds .
  METHODS delete_values
    IMPORTING
      !it_dynamic_values TYPE /gicom/dyn_appendix_val_tt OPTIONAL
      !iv_commit         TYPE /gicom/abap_bool
    RETURNING
      VALUE(rv_error)    TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_root_ds.
ENDINTERFACE.
