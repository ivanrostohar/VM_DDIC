CLASS /gicom/cl_dso_product_hier DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_product_hier .
    INTERFACES if_badi_interface .

    ALIASES select_product_hier
      FOR /gicom/if_dso_product_hier~select_product_hier .

    ALIASES insert_product_hierarchys
      FOR /gicom/if_dso_product_hier~insert_product_hierarchys .

    ALIASES delete_product_hierarchys
      FOR /gicom/if_dso_product_hier~delete_product_hierarchys .

    ALIASES read_product_hierarchys
      FOR /gicom/if_dso_product_hier~read_product_hierarchys .



  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_product_hier .
ENDCLASS.



CLASS /gicom/cl_dso_product_hier IMPLEMENTATION.


  METHOD get_badi.
    GET BADI rb_dso.
  ENDMETHOD.


  METHOD /gicom/if_dso_product_hier~select_product_hier.
    DATA(lb_dso) = get_badi( ).

    CALL BADI lb_dso->select_product_hier
      IMPORTING
        et_product_hier     = et_product_hier
        et_product_hier_txt = et_product_hier_txt.

  ENDMETHOD.

  METHOD insert_product_hierarchys.

    DATA lt_product_hierarchys TYPE TABLE OF /gicom/_prd_hr.

    lt_product_hierarchys = CORRESPONDING #( it_product_hierarchys ).

    INSERT /gicom/_prd_hr FROM TABLE lt_product_hierarchys ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_PRD_HR' SY-SUBRC.

    ENDIF.

    DATA lt_product_hierarchys_text TYPE TABLE OF /gicom/_prd_hr_t.

    lt_product_hierarchys_text = CORRESPONDING #( it_product_hierarchys_text ).

    INSERT /gicom/_prd_hr_t FROM TABLE lt_product_hierarchys_text ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_PRD_HR_T' SY-SUBRC.

    ENDIF.


  ENDMETHOD.

  METHOD delete_product_hierarchys.

    DELETE FROM /gicom/_prd_hr_t.
    DELETE FROM /gicom/_prd_hr.

    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD read_product_hierarchys.

    DATA(lv_language) = /gicom/cl_system=>get_language( ) .

    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt    = it_selopt
        iv_statement = '2'
      ).
    ENDIF.

     "Security check: check where clause
    IF lv_where NE space.
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
      /gicom/_prd_hr
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_product_hierarchys
    WHERE
      (lv_where).

    LOOP AT rt_product_hierarchys ASSIGNING FIELD-SYMBOL(<ls_prod_hr>).

      SELECT SINGLE
        spras,
        vtext
      FROM
        /gicom/_prd_hr_t
      WHERE
        prodh = @<ls_prod_hr>-prodh AND
        spras = @lv_language
      INTO
        CORRESPONDING FIELDS OF @<ls_prod_hr>.

    ENDLOOP.

    IF rt_product_hierarchys IS INITIAL.

      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

    ENDIF.

  ENDMETHOD.


ENDCLASS.
