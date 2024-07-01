FUNCTION /gicom/rfc_adjust_source_pos.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_LINE) TYPE  I
*"     VALUE(IV_CLSNAME) TYPE  SEOCLSNAME
*"     VALUE(IV_INCLUDE) TYPE  PROGNAME
*"  EXPORTING
*"     VALUE(EV_ADJUSTED_LINE) TYPE  I
*"----------------------------------------------------------------------
  /gicom/cl_util_code=>prevent_rfc_call_once( ).

  ev_adjusted_line = /gicom/cl_util_code=>adjust_source_line(
    iv_line    = iv_line
    iv_clsname = iv_clsname
    iv_include = iv_include
  ).

ENDFUNCTION.
