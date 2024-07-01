class /GICOM/CL_DSO_VSR definition
  public
  create public .

public section.

  interfaces /GICOM/IF_DSO_VSR .
  interfaces IF_BADI_INTERFACE .

  aliases SELECT_DATA
    for /GICOM/IF_DSO_VSR~SELECT_DATA .
protected section.
private section.

  methods GET_BADI
    returning
      value(RB_DSO_VSR) type ref to /GICOM/BADI_DS_VSR .
ENDCLASS.



CLASS /GICOM/CL_DSO_VSR IMPLEMENTATION.


METHOD /gicom/if_dso_vsr~select_data.
***********************************************************************
*                      METHOD SELECT_DATA                             *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :   02/05/2017                                        *
*  Mantis       :   12030                                             *
*                                                                     *
*  Description  :   Call DSO Badi to fetch Vendor Subranges data      *
*                                                                     *
***********************************************************************

***********************************************************************
*** Get DSO Badi Instance
***********************************************************************

  DATA(lb_dso_vsr) = get_badi( ).

***********************************************************************
*** Invoke DSO Method to get Vendor Subranges data
***********************************************************************

  TRY.
      CALL BADI lb_dso_vsr->select_data
        IMPORTING
          et_vsr        = et_vsr
          et_vsr_txt    = et_vsr_txt
          et_vsr_matnr  = et_vsr_matnr.

    CATCH /gicom/cx_root_ds.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error.
  ENDTRY.

ENDMETHOD.


METHOD get_badi.
***********************************************************************
*                         METHOD GET_BADI                             *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :   02/05/2017                                        *
*  Mantis       :   12030                                             *
*                                                                     *
*  Description  :   Get DSO Badi Reference                            *
*                                                                     *
***********************************************************************

***********************************************************************
*** Get DSO Badi Instance
***********************************************************************

  GET BADI rb_dso_vsr.

ENDMETHOD.
ENDCLASS.
