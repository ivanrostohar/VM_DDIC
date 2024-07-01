CLASS /gicom/cl_dso_uom_bapi_nw DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cl_dso_uom
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    METHODS /gicom/if_dso_uom~search
        REDEFINITION.
    METHODS /gicom/if_dso_uom~select
        REDEFINITION.
    METHODS /gicom/if_dso_uom~get_conversion_factor
        REDEFINITION.
    METHODS /gicom/if_dso_uom~check_unit_correspondence
        REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS resolve_subrc
      IMPORTING iv_subrc            TYPE sy-subrc
      RETURNING VALUE(rv_errorcode) TYPE string.

ENDCLASS.



CLASS /GICOM/CL_DSO_UOM_BAPI_NW IMPLEMENTATION.


  METHOD /gicom/if_dso_uom~check_unit_correspondence.
    CALL FUNCTION 'UNIT_CORRESPONDENCE_CHECK'
      EXPORTING
        unit_in                  = iv_unit_from
        unit_out                 = iv_unit_to
      EXCEPTIONS
        dimensions_are_different = 1
        unit_in_not_found        = 2
        unit_out_not_found       = 3
        OTHERS                   = 999.

    IF sy-subrc = 0.
      rv_result = abap_true.
    ELSE.
      rv_result = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD /gicom/if_dso_uom~get_conversion_factor.
    CALL FUNCTION 'UNIT_CONVERSION_SIMPLE'
      EXPORTING
        input    = CONV /gicom/unit_factor( 1 )
        unit_in  = iv_unit_from
        unit_out = iv_unit_to
      IMPORTING
        output   = rv_factor
      EXCEPTIONS
        OTHERS   = 999.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_invalid_arguments.
    ENDIF.
  ENDMETHOD.


  METHOD /gicom/if_dso_uom~search.
**
**  Author: Patrick Böhm  - gicom GmbH
**  Date:   08.12.2016
**  Mantis:
**
**  Description:
**    Reading unit
**
***********************************************************************************************************
***********************************************************************************************************
*** 0. Declarations
***********************************************************************************************************

    DATA: ls_uom       TYPE /gicom/uom_s,
          ls_values    TYPE t006,
          lv_errorcode TYPE string.

***********************************************************************************************************
*** 1. Check units of measurement
***********************************************************************************************************

    LOOP AT it_uom INTO DATA(lv_uom).

      CALL FUNCTION 'BUX_CHECK_VALUES_UNIT'
        EXPORTING
          iv_field_value  = lv_uom
        IMPORTING
          es_field_values = ls_values
        EXCEPTIONS
          not_found       = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.

        lv_errorcode = resolve_subrc( sy-subrc ).

        RAISE EXCEPTION TYPE /gicom/cx_internal_error.
          " MESSAGE ID '/GICOM/MSG_BASIS_DS'
          " TYPE 'E'
          " NUMBER 002
          " WITH lv_uom
          " lv_errorcode.

      ELSE.
        ls_uom-uom        = ls_values-msehi.
        ls_uom-dimension  = ls_values-dimid.
        ls_uom-isocode    = ls_values-isocode.
*        ls_uom-title = ls_values-mseht.

        APPEND ls_uom TO rt_uom.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.


  METHOD /gicom/if_dso_uom~select.

    SELECT
        t006~msehi  AS uom,
        t006a~msehl AS title,
        t006~dimid  AS dimension,
        t006~isocode AS isocode
    FROM
        t006
        LEFT OUTER JOIN
            t006a ON t006~msehi EQ t006a~msehi AND spras EQ @sy-langu
    INTO
        CORRESPONDING FIELDS OF TABLE @et_uom.

    SELECT
        msehi AS uom,
        spras AS langu,
        msehl AS title
    FROM
        t006a
    INTO
        TABLE @et_uom_txt.

  ENDMETHOD.


  METHOD resolve_subrc.

    CASE iv_subrc.
      WHEN 1.
        rv_errorcode = 'not found'.
      WHEN 2.
        rv_errorcode = 'others'.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
