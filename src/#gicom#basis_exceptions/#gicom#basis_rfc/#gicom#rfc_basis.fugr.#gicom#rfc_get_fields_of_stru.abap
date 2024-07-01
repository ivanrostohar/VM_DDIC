FUNCTION /gicom/rfc_get_fields_of_stru.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_DATATYPE) TYPE  /GICOM/DATATYPE
*"  EXPORTING
*"     VALUE(ES_TTYPE_INFO) TYPE  DD40V
*"     VALUE(ET_FIELDS) TYPE  DFIES_TABLE
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      et_fields =  NEW /gicom/cl_dso_ddic_eng( )->get_fields_of_structure(
                     EXPORTING
                       iv_datatype = iv_datatype
                     IMPORTING
                       es_ttype_info = es_ttype_info ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
