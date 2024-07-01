INTERFACE /gicom/if_dso_grouping
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    IMPORTING
      iv_language  TYPE syst_langu DEFAULT sy-langu
    EXPORTING
      !et_grouping TYPE /gicom/grp_a_tt
      !et_grp_txt  TYPE /gicom/grp_txt_tt
    RAISING
      /gicom/cx_root_ds.
ENDINTERFACE.
