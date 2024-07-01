FUNCTION /gicom/rfc_read_tm.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_TMTG) TYPE  /GICOM/TMGROUP_A_STT
*"     VALUE(ET_TMTGT) TYPE  /GICOM/TMGROUP_TEXT_A_STT
*"     VALUE(ET_TMTR) TYPE  /GICOM/TMRULE_A_STT
*"     VALUE(ET_TMSS) TYPE  /GICOM/TMSS_A_STT
*"     VALUE(ET_TMTS) TYPE  /GICOM/TMTS_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

***********************************************************************
*** Invoke DSO
***********************************************************************

  "Call DSO Method to get the data
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_transfer_manager ).

      NEW /gicom/cl_dso_tm( )->select_tm_data(
        IMPORTING
          et_tmtg  = et_tmtg
          et_tmtgt = et_tmtgt
          et_tmtr  = et_tmtr
          et_tmss  = et_tmss
          et_tmts  = et_tmts ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
