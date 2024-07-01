INTERFACE /gicom/if_dso_division
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_division
    EXPORTING
      !et_division     TYPE /gicom/cdivision_a_stt
      !et_division_txt TYPE /gicom/cdivision_txt_a_tt .


  METHODS insert_divisions
    IMPORTING
      it_divisions_txt TYPE /gicom/_divisn_t_a_tt
      it_divisions     TYPE /gicom/_divisn_a_tt
      iv_commit        TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_divisions
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_divisions
    IMPORTING
      it_selopt           TYPE ddshselops
    RETURNING
      VALUE(rt_divisions) TYPE /gicom/_divisn_t_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.


ENDINTERFACE.
