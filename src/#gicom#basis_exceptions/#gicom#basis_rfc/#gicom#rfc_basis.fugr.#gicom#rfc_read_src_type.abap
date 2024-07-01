FUNCTION /gicom/rfc_read_src_type.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     VALUE(ET_SOURCING_TYPE) TYPE  /GICOM/SOURCING_TYPE_A_TT
*"     VALUE(ET_SOURCING_TYPE_TXT) TYPE  /GICOM/SRC_TYP_TXT_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lb_src_type  TYPE REF TO /gicom/badi_ds_sourcing_type,
        lo_exception TYPE REF TO /gicom/cx_root_ds.
  GET BADI lb_src_type.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_sourcing_type  ).

      CALL BADI lb_src_type->select
        IMPORTING
          et_sourcing_type     = et_sourcing_type     " Bezugsarten (Attribute)
          et_sourcing_type_txt = et_sourcing_type_txt.
    CATCH /gicom/cx_root_ds INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.





ENDFUNCTION.
