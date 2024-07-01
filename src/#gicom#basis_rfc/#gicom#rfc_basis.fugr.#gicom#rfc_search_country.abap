FUNCTION /GICOM/RFC_SEARCH_COUNTRY.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IT_COUNTRIES) TYPE  /GICOM/COUNTRY_CODE_TT
*"  EXPORTING
*"     VALUE(ET_COUNTRY) TYPE  /GICOM/COUNTRY_TT
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA: lb_country            TYPE REF TO /gicom/badi_ds_country,
        lo_exception     TYPE REF TO /gicom/cx_root,
        ls_gicom_bapiret TYPE /gicom/bapiret2.

  GET BADI lb_country.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_country  ).

      CALL BADI lb_country->search
        EXPORTING
          it_countries             = it_countries
        RECEIVING
          rt_countries             = et_country.

    CATCH /gicom/cx_root_appl INTO lo_exception.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_exception ).

  ENDTRY.






ENDFUNCTION.
