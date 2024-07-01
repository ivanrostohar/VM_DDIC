FUNCTION /GICOM/RFC_READ_MATERIAL_GRP.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_MATERIAL_GRP) TYPE  /GICOM/CMATERIAL_GRP_A_STT
*"     VALUE(ET_MATERIAL_GRP_TXT) TYPE  /GICOM/CMATERIAL_GRP_TXT_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

 DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_mat_grp ).

     NEW /gicom/cl_dso_material_grp( )->select_material_grp(
                      IMPORTING
                        et_material_grp     = et_material_grp
                        et_material_grp_txt = et_material_grp_txt ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
