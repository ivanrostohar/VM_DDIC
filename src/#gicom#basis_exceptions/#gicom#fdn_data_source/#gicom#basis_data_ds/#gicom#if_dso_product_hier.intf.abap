INTERFACE /gicom/if_dso_product_hier
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_product_hier
    EXPORTING
      !et_product_hier     TYPE /gicom/cproduct_hier_a_stt
      !et_product_hier_txt TYPE /gicom/cproduct_hier_txt_a_stt .


  METHODS insert_product_hierarchys
    IMPORTING
      it_product_hierarchys      TYPE /gicom/_prd_hr_a_tt
      it_product_hierarchys_text TYPE /gicom/_prd_hr_t_a_tt
      iv_commit                  TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_product_hierarchys
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_product_hierarchys
    IMPORTING
      it_selopt                    TYPE ddshselops
    RETURNING
      VALUE(rt_product_hierarchys) TYPE /gicom/_prd_hr_t_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.



ENDINTERFACE.
