INTERFACE /gicom/if_dso_plant
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_plant
    EXPORTING
      !et_plants TYPE /gicom/cplant_a_stt .

  METHODS insert_plants
    IMPORTING
      it_plants TYPE /gicom/_plant_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_plants
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_plants
    IMPORTING
      it_selopt        TYPE ddshselops
    RETURNING
      VALUE(rt_plants) TYPE /gicom/_plant_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

ENDINTERFACE.
