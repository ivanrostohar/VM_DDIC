FUNCTION /GICOM/RFC_DELETE_DDIC_OBJECT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_OBJNAME) TYPE  DDOBJNAME
*"     VALUE(IV_OBJTYPE) TYPE  DDEUTYPE
*"     VALUE(IV_TRKORR) TYPE  TRKORR OPTIONAL
*"  EXPORTING
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      NEW /gicom/cl_dso_ddic_eng( )->delete_ddic_object(
      EXPORTING
        iv_objname = iv_objname     " Name of ABAP Dictionary Object
        iv_objtype = iv_objtype    " DD object type in DE management system
        iv_trkorr  = iv_trkorr    " Request/Task
    ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.


ENDFUNCTION.
