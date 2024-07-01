FUNCTION /GICOM/RFC_READ_GROUPING.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_LANGUAGE) TYPE  SYST_LANGU
*"  EXPORTING
*"     VALUE(ET_GROUPING) TYPE  /GICOM/GRP_A_TT
*"     VALUE(ET_GRP_TXT) TYPE  /GICOM/GRP_TXT_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lb_bp        TYPE REF TO /gicom/badi_ds_grouping,
        lo_exception TYPE REF TO /gicom/cx_root_ds.
  GET BADI lb_bp.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_grouping  ).

      CALL BADI lb_bp->select
        IMPORTING
          et_grouping = et_grouping
          et_grp_txt  = et_grp_txt.

    CATCH /gicom/cx_root_ds INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.






ENDFUNCTION.
