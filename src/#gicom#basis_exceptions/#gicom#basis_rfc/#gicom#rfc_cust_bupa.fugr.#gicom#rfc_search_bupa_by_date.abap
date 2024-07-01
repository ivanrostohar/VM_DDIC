FUNCTION /GICOM/RFC_SEARCH_BUPA_BY_DATE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_VALID_DATE) TYPE  /GICOM/DATE
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
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_businesspartner ).

      CALL BADI lb_bp->search_by_date
        EXPORTING
          iv_valid_date = iv_valid_date
        RECEIVING
          rt_businesspartners = et_businesspartners.
    CATCH /gicom/cx_root_ds INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.





ENDFUNCTION.
