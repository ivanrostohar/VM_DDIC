CLASS /gicom/cl_dso_country_bapi_nw DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cl_dso_country
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS: /gicom/if_dso_country~search REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS resolve_subrc
      IMPORTING
        lv_subrc            TYPE sy-subrc
      RETURNING
        VALUE(rv_errorcode) TYPE string.

ENDCLASS.



CLASS /GICOM/CL_DSO_COUNTRY_BAPI_NW IMPLEMENTATION.


  METHOD /gicom/if_dso_country~search.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   08.12.2016
**  Mantis:
**
**  Description:
**    Reading countries
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************

    DATA: ls_country   TYPE /gicom/country_s,
          lv_errorcode TYPE string,
          ls_values    TYPE t005.

***********************************************************************************************************
*** 1. Read country data
***********************************************************************************************************

    LOOP AT it_countries INTO DATA(lv_country).

      CALL FUNCTION 'ADDR_POSTAL_CODE_CHECK'
        EXPORTING
          country                        = lv_country
        IMPORTING
          t005_wa                        = ls_values
          "T005_WA_PO_BOX                 =
        EXCEPTIONS
          country_not_valid              = 1
          region_not_valid               = 2
          postal_code_city_not_valid     = 3
          postal_code_po_box_not_valid   = 4
          postal_code_company_not_valid  = 5
          po_box_missing                 = 6
          postal_code_po_box_missing     = 7
          postal_code_missing            = 8
          postal_code_pobox_comp_missing = 9
          po_box_region_not_valid        = 10
          po_box_country_not_valid       = 11
          pobox_and_poboxnum_filled      = 12
          OTHERS                         = 13.

      IF sy-subrc <> 0.

        lv_errorcode = resolve_subrc( sy-subrc ).

        RAISE EXCEPTION TYPE /gicom/cx_internal_error.
         " MESSAGE ID '/GICOM/MSG_BASIS_DS'
         " TYPE 'E'
         " NUMBER 001
         " WITH lv_country
         " lv_errorcode.

      ELSE.

        ls_country-code = ls_values-land1.

        APPEND ls_country TO rt_countries.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD resolve_subrc.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   09.12.2016
**  Mantis:
**
**  Description:
**    Resolve sy-subrc code to get error code
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************

***********************************************************************************************************
*** 1. Resolve and return error code
**********************************************************************************************************
    CASE lv_subrc.
      WHEN 1.
        rv_errorcode = 'country not valid'.
      WHEN 2.
        rv_errorcode = 'region not valid'.
      WHEN 3.
        rv_errorcode = 'postal code city not valid'.
      WHEN 4.
        rv_errorcode = 'postal code po box not valid'.
      WHEN 5.
        rv_errorcode = 'postal code company not valid'.
      WHEN 6.
        rv_errorcode = 'po box missing'.
      WHEN 7.
        rv_errorcode = 'postal code po box missing'.
      WHEN 8.
        rv_errorcode = 'postal code missing'.
      WHEN 9.
        rv_errorcode = 'postal code pobox comp missing'.
      WHEN 10.
        rv_errorcode = 'po box region not valid'.
      WHEN 11.
        rv_errorcode = 'po box country not valid'.
      WHEN 12.
        rv_errorcode = 'pobox and poboxnum filled'.
      WHEN 13.
        rv_errorcode = 'others'.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
