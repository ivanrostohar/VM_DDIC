INTERFACE /gicom/if_dso_material_grp
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_material_grp
    EXPORTING
      !et_material_grp     TYPE /gicom/cmaterial_grp_a_stt
      !et_material_grp_txt TYPE /gicom/cmaterial_grp_txt_a_stt .


  METHODS insert_material_groups
    IMPORTING
      it_material_groups_txt TYPE /gicom/_matkl_t_a_tt
      it_material_groups     TYPE /gicom/_matkl_a_tt
      iv_commit              TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_material_groups
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_material_groups
    IMPORTING
      it_selopt                 TYPE ddshselops
    RETURNING
      VALUE(rt_material_groups) TYPE /gicom/_matkl_t_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

ENDINTERFACE.
