FUNCTION /GICOM/RFC_READ_BUPA_ADDRESS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_BU_ID) TYPE  /GICOM/BU_PARTNER
*"     VALUE(IV_BU_TYPE) TYPE  /GICOM/BO_TYP
*"  EXPORTING
*"     VALUE(ET_ADDRESS) TYPE  /GICOM/ADDRESS_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------
  DATA lb_bp TYPE REF TO /gicom/badi_ds_businesspartner.
  GET BADI lb_bp.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_businesspartner ).

      CALL BADI lb_bp->select_address
        EXPORTING
          iv_bu_id      = iv_bu_id
          iv_bu_type    = iv_bu_type
        RECEIVING
          rt_address    = et_address.
    CATCH /gicom/cx_root_ds INTO DATA(lx_rfc).
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lx_rfc ).
  ENDTRY.

ENDFUNCTION.
