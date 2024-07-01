FUNCTION /GICOM/RFC_GET_CONVERSION_FACT.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_UNIT_FROM) TYPE  /GICOM/UOM
*"     VALUE(IV_UNIT_TO) TYPE  /GICOM/UOM
*"  EXPORTING
*"     VALUE(EV_FACTOR) TYPE  /GICOM/UNIT_FACTOR
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lb_uom       TYPE REF TO /gicom/badi_ds_uom,
        lo_exception TYPE REF TO /gicom/cx_root_ds.

  GET BADI lb_uom.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_uom ).

      CALL BADI lb_uom->get_conversion_factor
        EXPORTING
          iv_unit_from = iv_unit_from
          iv_unit_to   = iv_unit_to
        RECEIVING
          rv_factor    = ev_factor.

    CATCH /gicom/cx_root_ds INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.



ENDFUNCTION.
