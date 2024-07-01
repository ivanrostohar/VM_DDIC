INTERFACE /gicom/if_dso_uom
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS search
    IMPORTING
      !it_uom       TYPE /gicom/uom_tty
    RETURNING
      VALUE(rt_uom) TYPE /gicom/uom_tt
    RAISING
      /gicom/cx_internal_error .

  METHODS select
    EXPORTING
      !et_uom     TYPE /gicom/uom_tt
      !et_uom_txt TYPE /gicom/uom_txt_tt .

  METHODS get_conversion_factor
    IMPORTING
      iv_unit_from     TYPE /gicom/uom
      iv_unit_to       TYPE /gicom/uom
    RETURNING
      VALUE(rv_factor) TYPE /gicom/unit_factor
    RAISING
      /gicom/cx_root_ds.

  METHODS check_unit_correspondence
    IMPORTING
      iv_unit_from     TYPE /gicom/uom
      iv_unit_to       TYPE /gicom/uom
    RETURNING
      VALUE(rv_result) TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_root_ds.


   METHODS insert_unit_of_measurements
    IMPORTING
      it_unit_of_measurements TYPE  /gicom/_uom_a_tt
      it_unit_of_measurements_text TYPE  /gicom/_uom_t_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_unit_of_measurements
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_unit_of_measurements
    IMPORTING
       it_selopt   TYPE ddshselops OPTIONAL
    EXPORTING
      et_unit_of_measurements      TYPE  /gicom/_uom_a_tt
      et_unit_of_measurements_text TYPE  /gicom/_uom_t_a_tt
   RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.


ENDINTERFACE.
