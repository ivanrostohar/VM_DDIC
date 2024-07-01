FUNCTION /GICOM/RFC_READ_RELATIONS_BUPA.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PARTNER) TYPE  /GICOM/BUPA_ID_TT
*"  EXPORTING
*"     VALUE(ET_RELATIONS) TYPE  FSBP_BAPI_RELATIONS_TTY
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lb_bp        TYPE REF TO /gicom/badi_ds_businesspartner,
        lo_exception TYPE REF TO cx_root.
  GET BADI lb_bp.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_businesspartner ).

      CALL BADI lb_bp->select_relations
        EXPORTING
          it_partner   = it_partner
        RECEIVING
          rt_relations = et_relations.

*    CATCH /gicom/cx_root_ds /gicom/cx_no_auth_rfc INTO lo_exception.
CATCH /gicom/cx_root_ds INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.






ENDFUNCTION.
