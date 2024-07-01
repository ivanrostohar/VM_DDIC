FUNCTION /gicom/rfc_get_table.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_TABNAME) TYPE  TABNAME
*"  EXPORTING
*"     VALUE(ET_TABLE_FIELDS) TYPE  /GICOM/DFIES_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  TRY.

    /gicom/cl_util_ddic=>get_ddic_def(
      EXPORTING
        iv_obj_name = iv_tabname
      CHANGING
        et_dfies    = et_table_fields
    ).
  CATCH /gicom/cx_internal_error INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
