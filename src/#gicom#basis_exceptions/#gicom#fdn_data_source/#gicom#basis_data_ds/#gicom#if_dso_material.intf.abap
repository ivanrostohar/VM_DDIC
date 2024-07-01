INTERFACE /gicom/if_dso_material
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    EXPORTING
      et_material        TYPE /gicom/material_a_tt
      et_material_txt    TYPE /gicom/material_txt_tt
      et_material_bo_rel TYPE /gicom/material_bo_rel_tt
    RAISING
      /gicom/cx_root_ds .

  METHODS select_materials
    IMPORTING
      it_selopt          TYPE ddshselops OPTIONAL
    EXPORTING
      et_mara            TYPE /gicom/_mara_a_tt
      et_marm            TYPE /gicom/_marm_a_tt
      et_mara_ean        TYPE /gicom/_mara_ean_a_tt
      et_makt            TYPE /gicom/_makt_tt
      et_material_bo_rel TYPE /gicom/_mat_org_tt

    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

  METHODS delete_makt
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS select_material_title
    IMPORTING
      iv_matnr                 TYPE /gicom/material
    RETURNING
      VALUE(rv_material_title) TYPE  /gicom/title .

  METHODS delete_mara
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS delete_marm
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS delete_mara_ean
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS delete_mat_org
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS insert_mara_ean
    IMPORTING
      it_mara_ean TYPE /gicom/_mara_ean_a_tt
      iv_commit   TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS select_material_with_gtin
    IMPORTING
      iv_gtin TYPE ean11
    RETURNING
      VALUE(rt_material_ean) TYPE /gicom/_mara_ean_a_tt.




ENDINTERFACE.
