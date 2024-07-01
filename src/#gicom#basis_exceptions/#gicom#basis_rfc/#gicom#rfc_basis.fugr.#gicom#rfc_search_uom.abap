FUNCTION /GICOM/RFC_SEARCH_UOM.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_UOM) TYPE  /GICOM/UOM_TTY
*"  EXPORTING
*"     VALUE(ET_UOM) TYPE  /GICOM/UOM_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lb_uom       TYPE REF TO /gicom/badi_ds_uom,
        lo_exception TYPE REF TO /gicom/cx_root_ds.
  GET BADI lb_uom.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_uom ).

      CALL BADI lb_uom->search
        EXPORTING
          it_uom = it_uom
        RECEIVING
          rt_uom = et_uom.
  CATCH /gicom/cx_root_ds INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
      .
ENDTRY.



    ENDFUNCTION.
