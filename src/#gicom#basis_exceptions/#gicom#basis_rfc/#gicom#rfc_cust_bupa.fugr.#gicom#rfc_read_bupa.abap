FUNCTION /GICOM/RFC_READ_BUPA.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PARTNER) TYPE  /GICOM/BUPA_ID_TT OPTIONAL
*"  EXPORTING
*"     VALUE(ET_BUSINESSPARTNERS) TYPE  /GICOM/BUPA_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------
  DATA: lb_bp        TYPE REF TO /gicom/badi_ds_businesspartner,
        lo_exception TYPE REF TO /gicom/cx_root_ds.
  GET BADI lb_bp.

  TRY.

*  /GICOM/CL_BUPA_HELPER=>enqueue_bupa(  )
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_businesspartner ).

      CALL BADI lb_bp->select
        EXPORTING
          it_partner          = it_partner
        RECEIVING
          rt_businesspartners = et_businesspartners.

    CATCH /gicom/cx_root_ds INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
