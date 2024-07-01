FUNCTION /gicom/rfc_read_gi_cust.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_PARA_KEY) TYPE  /GICOM/KEY_PARA_RTT OPTIONAL
*"  EXPORTING
*"     VALUE(ET_PARA) TYPE  /GICOM/TPARA_A_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"  EXCEPTIONS
*"      INTERNAL_ERROR
*"----------------------------------------------------------------------

  DATA: lo_exception     TYPE REF TO /gicom/cx_root_ds,
        ls_gicom_bapiret TYPE /gicom/bapiret2,
        lb_dso_cust      TYPE REF TO /gicom/badi_ds_basis_cust_gi.


  TRY .
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_general ).


      "Get DSO Badi Instance
      GET BADI lb_dso_cust.

      IF lb_dso_cust IS BOUND.
        TRY.
            CALL BADI lb_dso_cust->select_para_values
              EXPORTING
                itr_para_key   = it_para_key
              RECEIVING
                rt_para_values = et_para.
          CATCH /gicom/cx_root_ds.    "
        ENDTRY.
      ENDIF.


    CATCH /gicom/cx_no_auth_rfc.    "

  ENDTRY.

ENDFUNCTION.
