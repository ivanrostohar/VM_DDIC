INTERFACE /gicom/if_dso_cost_center
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_cost_centers
    EXPORTING
      !et_cost_centers     TYPE /gicom/ccost_center_a_stt
      !et_cost_centers_txt TYPE /gicom/ccost_center_txt_a_stt .

  METHODS insert_cost_centers
    IMPORTING
      it_cost_centers TYPE /gicom/_cst_cnt_a_tt
      it_cost_centers_text TYPE /gicom/_cst_cntt_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.


  METHODS delete_cost_centers
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_cost_centers
    IMPORTING
      it_selopt            TYPE ddshselops
    EXPORTING
      et_cost_centers      TYPE /gicom/_cst_cnt_a_tt
      et_cost_centers_text TYPE /gicom/_cst_cntt_a_tt
   RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

ENDINTERFACE.
