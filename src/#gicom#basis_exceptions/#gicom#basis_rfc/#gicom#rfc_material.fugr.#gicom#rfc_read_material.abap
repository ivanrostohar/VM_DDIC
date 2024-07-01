FUNCTION /gicom/rfc_read_material.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_MATERIAL) TYPE  /GICOM/MATERIAL_A_TT
*"     VALUE(ET_MATERIAL_TXT) TYPE  /GICOM/MATERIAL_TXT_TT
*"     VALUE(ET_MATERIAL_BO_REL) TYPE  /GICOM/MATERIAL_BO_REL_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------
  DATA: lb_bp            TYPE REF TO /gicom/badi_ds_material,
        lo_exception     TYPE REF TO /gicom/cx_root_appl,
        ls_gicom_bapiret TYPE /gicom/bapiret2.

  GET BADI lb_bp.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_material  ).

      CALL BADI lb_bp->select
        IMPORTING
          et_material        = et_material
          et_material_txt    = et_material_txt
          et_material_bo_rel = et_material_bo_rel.

    CATCH /gicom/cx_root_appl INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.



ENDFUNCTION.
