FUNCTION /gicom/rfc_raise_exception.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_ERR) TYPE  STRING
*"----------------------------------------------------------------------
**************************************************************************************************************
*** Deserialize the exception into an object and raise the passed exception.
**************************************************************************************************************


  DATA lo_err TYPE REF TO cx_root.

  /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_general ).

  CALL TRANSFORMATION id_indent SOURCE XML iv_err RESULT oexcp = lo_err.

  IF lo_err IS BOUND.
    DATA(lv_type) = cl_abap_classdescr=>get_class_name( lo_err ).

    DATA lo_ex TYPE REF TO cx_root.

    " Wrap the exception in another instance of itself to preserve the raise location
    CREATE OBJECT lo_ex TYPE (lv_type)
      EXPORTING
        previous = lo_err.

    RAISE EXCEPTION lo_ex. "##NO_CHECK
  ENDIF.


ENDFUNCTION.
