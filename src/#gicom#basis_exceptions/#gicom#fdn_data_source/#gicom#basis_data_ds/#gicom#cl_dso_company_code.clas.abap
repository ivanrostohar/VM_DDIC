CLASS /gicom/cl_dso_company_code DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES /gicom/if_dso_company_code .

    ALIASES insert_company_codes
      FOR /gicom/if_dso_company_code~insert_company_codes .

    ALIASES delete_company_codes
      FOR /gicom/if_dso_company_code~delete_company_codes .

    ALIASES read_company_codes
      FOR /gicom/if_dso_company_code~read_company_codes .

    ALIASES select_company_codes
      FOR /gicom/if_dso_company_code~select_company_codes .

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_company_code.

ENDCLASS.

CLASS /gicom/cl_dso_company_code IMPLEMENTATION.

  METHOD /gicom/if_dso_company_code~select_company_codes.

    DATA(lb_dso) = me->get_badi( ).

    CALL BADI lb_dso->select_company_codes
      RECEIVING
        rt_cuco = rt_cuco.

  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_dso.
  ENDMETHOD.

  METHOD delete_company_codes.

    DELETE FROM  /gicom/_ccode.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_company_codes.

    DATA lt_company_codes TYPE TABLE OF /gicom/_ccode.

    lt_company_codes = CORRESPONDING #( it_company_codes ).

    INSERT /gicom/_ccode FROM TABLE lt_company_codes ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_CCODE' SY-SUBRC.

     ENDIF.

  ENDMETHOD.

  METHOD read_company_codes.

    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt   = it_selopt
        iv_statement = '2'
      ).
    ENDIF.

     "Security check: check where clause
    IF lv_where <> space.
      DATA(lv_whilelist) = lv_where.
      TRY.
         lv_where = cl_abap_dyn_prg=>check_whitelist_str(
                      val       = lv_where
                      whitelist = lv_whilelist
                    ).

        CATCH cx_abap_not_in_whitelist INTO DATA(lx_exception).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ) .
      ENDTRY.
    ENDIF.

    SELECT
      *
    FROM
      /gicom/_ccode
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_company_codes
    WHERE
      (lv_where).

    IF sy-subrc <> 0.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.


  ENDMETHOD.

ENDCLASS.
