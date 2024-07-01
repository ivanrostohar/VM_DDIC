FUNCTION /gicom/rfc_check_unit_corresp.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_UNIT_FROM) TYPE  /GICOM/UOM
*"     VALUE(IV_UNIT_TO) TYPE  /GICOM/UOM
*"  EXPORTING
*"     VALUE(RV_RESULT) TYPE  /GICOM/ABAP_BOOL
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lb_uom       TYPE REF TO /gicom/badi_ds_uom,
        lo_exception TYPE REF TO /gicom/cx_root_ds.

  GET BADI lb_uom.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_uom ).

      CALL BADI lb_uom->check_unit_correspondence
        EXPORTING
          iv_unit_from = iv_unit_from
          iv_unit_to   = iv_unit_to
        RECEIVING
          rv_result    = rv_result.

    CATCH /gicom/cx_root_ds INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.



ENDFUNCTION.
