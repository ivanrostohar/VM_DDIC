FUNCTION /GICOM/RFC_READ_TAX_CODE.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IV_TAX_CODE) TYPE  MWSKZ
*"     VALUE(IV_COUNTRY) TYPE  LAND1
*"  EXPORTING
*"     VALUE(ES_TAX) TYPE  /GICOM/TAX_S
*"     VALUE(ET_RETURN) TYPE  /GICOM/BAPIRET_TT
*"----------------------------------------------------------------------
  DATA lo_not_found TYPE REF TO /gicom/cx_not_found.

  TRY.
      /gicom/cl_auth_rfc_da=>authority_check( /gicom/cl_rfc_manager=>cv_tax  ).

      NEW /gicom/cl_dso_tax_code( )->read_tax_data(
        EXPORTING
          iv_tax_code         = iv_tax_code
          iv_country          = iv_country
        RECEIVING
          rs_tax              = es_tax
      ).
    CATCH /gicom/cx_not_found INTO lo_not_found.

      et_return = /gicom/cl_rfc_helper=>exeption_to_bapiret( lo_not_found ).

  ENDTRY.


ENDFUNCTION.
