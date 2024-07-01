FUNCTION /GICOM/RFC_SEARCH_BUPA.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_NAME_1) TYPE  /GICOM/NAME OPTIONAL
*"     VALUE(IV_NAME_2) TYPE  /GICOM/NAME OPTIONAL
*"     VALUE(IV_PERSON) TYPE  BOOLEAN DEFAULT ABAP_UNDEFINED
*"  EXPORTING
*"     VALUE(ET_BUSINESSPARTNERS) TYPE  /GICOM/BUPA_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------
  DATA: lb_bp TYPE REF TO /gicom/badi_ds_businesspartner,
        lo_exception     TYPE REF TO /gicom/cx_root_ds.
        GET BADI lb_bp.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_businesspartner ).


      CALL BADI lb_bp->search
        EXPORTING
          iv_name_1           = iv_name_1
          iv_name_2           = iv_name_2
          iv_person           = iv_person
        RECEIVING
          rt_businesspartners = et_businesspartners.
    CATCH /gicom/cx_root_ds INTO lo_exception.
       et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
  ENDTRY.
ENDFUNCTION.
