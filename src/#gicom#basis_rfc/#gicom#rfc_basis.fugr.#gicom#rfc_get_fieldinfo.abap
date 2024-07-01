FUNCTION /gicom/rfc_get_fieldinfo.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_STRUCTURE) TYPE  DDOBJNAME
*"     VALUE(IV_FIELDNAME) TYPE  DFIES-FIELDNAME OPTIONAL
*"     VALUE(IV_LANGU) TYPE  SY-LANGU OPTIONAL
*"     VALUE(IV_LVC_FCAT_REQUIRED) TYPE  CHAR1 OPTIONAL
*"  EXPORTING
*"     VALUE(ET_LVC_FCAT) TYPE  LVC_T_FCAT
*"     VALUE(ET_FIELDS) TYPE  DFIES_TABLE
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      et_fields = NEW /gicom/cl_dso_ddic_eng( )->get_fieldinfo(
                    EXPORTING
                      iv_structure = iv_structure  " Name of ABAP Dictionary Object
                      iv_fieldname = iv_fieldname  " Field Name
                      iv_langu     = iv_langu " Language
                      iv_lvc_fcat_required = iv_lvc_fcat_required
                    IMPORTING
                      et_lvc_fcat = et_lvc_fcat
                  ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.

ENDFUNCTION.
