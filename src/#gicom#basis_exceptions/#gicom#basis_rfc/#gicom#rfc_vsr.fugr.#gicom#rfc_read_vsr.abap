FUNCTION /gicom/rfc_read_vsr.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXPORTING
*"     VALUE(ET_VSR) TYPE  /GICOM/VSR_A_TT
*"     VALUE(ET_VSR_TXT) TYPE  /GICOM/VSR_TEXT_A_TT
*"     VALUE(ET_VSR_MATNR) TYPE  /GICOM/VSR_MATNR_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

***********************************************************************
*               FUNCTION MODULE /GICOM/RFC_READ_VSR                   *
***********************************************************************
*  Author       :   Prasad Kanchustambam  - Gicom India               *
*  Date         :   02/05/2017                                        *
*  Mantis       :   12030                                             *
*                                                                     *
*  Description  :   Get Vendor Subranges information                  *
*                                                                     *
***********************************************************************

***********************************************************************
*** Invoke DSO
***********************************************************************

  "Call DSO Method to get the data
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_businesspartner  ).

      NEW /gicom/cl_dso_vsr( )->select_data(
                                  IMPORTING
                                    et_vsr        = et_vsr
                                    et_vsr_txt    = et_vsr_txt
                                    et_vsr_matnr  = et_vsr_matnr ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
