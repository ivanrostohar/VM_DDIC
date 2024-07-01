FUNCTION /gicom/rfc_read_division.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_DIVISION) TYPE  /GICOM/CDIVISION_A_STT
*"     VALUE(ET_DIVISION_TXT) TYPE  /GICOM/CDIVISION_TXT_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lo_exception TYPE REF TO /gicom/cx_root_da.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_division ).

      NEW /gicom/cl_dso_division( )->select_division(
                IMPORTING
                  et_division     = et_division
                  et_division_txt = et_division_txt ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.



ENDFUNCTION.
