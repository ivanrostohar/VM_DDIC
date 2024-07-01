FUNCTION /gicom/rfc_execute_tm.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_EVENT) TYPE  /GICOM/TRANS_EVENT
*"     VALUE(IV_SOURCE_COPY_DATA) TYPE  XSTRING
*"     VALUE(IT_GROUPS) TYPE  /GICOM/TRANSFER_GROUP_TT
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  CHANGING
*"     VALUE(CV_TARGET_COPY_DATA) TYPE  XSTRING
*"  EXCEPTIONS
*"      SYSTEM_FAILURE
*"      COMMUNICATION_FAILURE
*"----------------------------------------------------------------------

  DATA: lt_source_copy_data TYPE /gicom/wlf_tm_copy_data_tt,
        lt_target_copy_data TYPE /gicom/wlf_tm_copy_data_tt.

***********************************************************************
*** Invoke DSO
***********************************************************************
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_transfer_manager ).

      "convert XML data into internal table
      CALL TRANSFORMATION id
        SOURCE XML iv_source_copy_data
        RESULT source_data = lt_source_copy_data.

      CALL TRANSFORMATION id
        SOURCE XML cv_target_copy_data
        RESULT target_data = lt_target_copy_data.

      "Call DSO Method to execute transfer manager
      NEW /gicom/cl_dso_tm( )->execute_tm(
        EXPORTING
          iv_event            = iv_event
          it_groups           = it_groups
          it_source_copy_data = lt_source_copy_data
        IMPORTING
          et_target_copy_data = lt_target_copy_data
      ).

      CALL TRANSFORMATION id
        SOURCE target_data = lt_target_copy_data
        RESULT XML cv_target_copy_data.

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
