CLASS /gicom/cl_dso_cost_center DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_cost_center .
    INTERFACES if_badi_interface .

    ALIASES select_cost_centers
      FOR /gicom/if_dso_cost_center~select_cost_centers .

    ALIASES delete_cost_centers
      FOR /gicom/if_dso_cost_center~delete_cost_centers .

   ALIASES insert_cost_centers
      FOR /gicom/if_dso_cost_center~insert_cost_centers .

   ALIASES read_cost_centers
      FOR /gicom/if_dso_cost_center~read_cost_centers .


  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_cost_center .
ENDCLASS.



CLASS /gicom/cl_dso_cost_center IMPLEMENTATION.


  METHOD /gicom/if_dso_cost_center~select_cost_centers.

    DATA(lo_dso) = me->get_badi( ).

    CALL BADI lo_dso->select_cost_centers
      IMPORTING
        et_cost_centers     = et_cost_centers
        et_cost_centers_txt = et_cost_centers_txt.

  ENDMETHOD.


  METHOD get_badi.

    GET BADI rb_dso.

  ENDMETHOD.

  METHOD delete_cost_centers.

    DELETE FROM /gicom/_cst_cnt.
    DELETE FROM /gicom/_cst_cntt.

    IF sy-subrc = 0.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_cost_centers.

    DATA : lt_cost_centers TYPE TABLE OF /gicom/_cst_cnt,
           lt_cost_centers_text TYPE TABLE OF /gicom/_cst_cntt.


    lt_cost_centers = CORRESPONDING #( it_cost_centers ).

    INSERT /gicom/_cst_cnt FROM TABLE lt_cost_centers ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_CST_CNT' SY-SUBRC.

     ENDIF.

   lt_cost_centers_text = CORRESPONDING #( it_cost_centers_text ).

   INSERT /gicom/_cst_cntt FROM TABLE lt_cost_centers_text ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_CST_CNTT' SY-SUBRC.

     ENDIF.


  ENDMETHOD.

  METHOD read_cost_centers.

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).

    "Generating WHERE clause
    IF it_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt    = it_selopt
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
      /gicom/_cst_cnt
    INTO
      CORRESPONDING FIELDS OF TABLE @et_cost_centers
    WHERE
      (lv_where).

    IF sy-subrc = 0 AND et_cost_centers IS NOT INITIAL.

      SELECT
        *
      FROM
        /gicom/_cst_cntt
      INTO
        CORRESPONDING FIELDS OF TABLE @et_cost_centers_text
      FOR ALL ENTRIES IN @et_cost_centers
      WHERE
        kokrs =  @et_cost_centers-kokrs AND
        kostl =  @et_cost_centers-kostl AND
        datbi =  @et_cost_centers-datbi AND
        spras =  @lv_language.

    ELSEIF sy-subrc <> 0.

      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
