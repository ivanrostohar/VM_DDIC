FUNCTION /GICOM/RFC_GET_DEVCLS_FROM_OBJ.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_PGMID) TYPE  PGMID
*"     VALUE(IV_OBJECT) TYPE  TROBJTYPE
*"     VALUE(IV_OBJNAME) TYPE  SOBJ_NAME
*"  EXPORTING
*"     VALUE(ES_DEVCLASS) TYPE  TRDEVCLASS
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------

  "Call DSO Method
  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_ddic_engine ).

      es_devclass =  NEW /gicom/cl_dso_ddic_eng( )->get_devclass_from_object(
                                                  EXPORTING
                                                    iv_pgmid    = iv_pgmid
                                                    iv_object   = iv_object
                                                    iv_objname  = iv_objname ).

    CATCH /gicom/cx_root_ds INTO DATA(lo_exception).

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.



ENDFUNCTION.
