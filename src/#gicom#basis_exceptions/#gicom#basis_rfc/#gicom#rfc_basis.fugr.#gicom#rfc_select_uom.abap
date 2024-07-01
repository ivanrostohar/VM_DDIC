FUNCTION /gicom/rfc_select_uom.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     VALUE(ET_UOM) TYPE  /GICOM/UOM_TT
*"     VALUE(ET_UOM_TXT) TYPE  /GICOM/UOM_TXT_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lo_exception TYPE REF TO /gicom/cx_root_ds.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_uom ).

      NEW /gicom/cl_dso_uom( )->select(
                                  IMPORTING
                                        et_uom      = et_uom
                                        et_uom_txt  = et_uom_txt ).

    CATCH /gicom/cx_root_ds INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).
      .
  ENDTRY.




ENDFUNCTION.
