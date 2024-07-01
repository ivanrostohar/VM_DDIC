FUNCTION /gicom/rfc_read_distr_channel.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(ET_DISTR_CHANL) TYPE  /GICOM/CDISTR_CHANNEL_A_STT
*"     VALUE(ET_DISTR_CHANL_TXT) TYPE  /GICOM/CDIST_CHANNEL_TXT_A_STT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  DATA: lo_exception TYPE REF TO /gicom/cx_root_da.
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_distr_channel ).

      NEW /gicom/cl_dso_distr_channel( )->select_distr_channel(
              IMPORTING
                et_distr_chanl     = et_distr_chanl
                et_distr_chanl_txt = et_distr_chanl_txt
                   ).

    CATCH /gicom/cx_root_da INTO lo_exception.
      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.




ENDFUNCTION.
