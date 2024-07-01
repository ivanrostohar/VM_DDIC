FUNCTION /GICOM/RFC_READ_PLANT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_PLANTS) TYPE  /GICOM/CPLANT_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_plant ).

     NEW /gicom/cl_dso_plant( )->select_plant(
                          IMPORTING
                            et_plants = et_plants ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
