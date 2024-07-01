FUNCTION /gicom/rfc_get_devcls_for_obj.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_OBJTYPE) TYPE  TROBJTYPE
*"     VALUE(IV_OBJNAME) TYPE  SOBJ_NAME
*"  EXPORTING
*"     VALUE(EV_DEVCLASS) TYPE  DEVCLASS
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      NEW /gicom/cl_dso_ddic_eng( )->get_devclass_for_object(
      EXPORTING
        iv_objtype  = iv_objtype    " Object Type
        iv_objname  = iv_objname    " Object Name in Object Directory
      IMPORTING
        ev_devclass = ev_devclass    " Package
    ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.



ENDFUNCTION.
