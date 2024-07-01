CLASS /gicom/cl_dso_uom DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_uom .
    INTERFACES if_badi_interface
      ALL METHODS ABSTRACT .

    ALIASES search
      FOR /gicom/if_dso_uom~search .

    ALIASES select
      FOR /gicom/if_dso_uom~select .

    ALIASES get_conversion_factor
      FOR /gicom/if_dso_uom~get_conversion_factor.

    ALIASES check_unit_correspondence
      FOR /gicom/if_dso_uom~check_unit_correspondence.

    ALIASES insert_unit_of_measurements
      FOR /gicom/if_dso_uom~insert_unit_of_measurements.

    ALIASES delete_unit_of_measurements
      FOR /gicom/if_dso_uom~delete_unit_of_measurements.

    ALIASES read_unit_of_measurements
      FOR /gicom/if_dso_uom~read_unit_of_measurements.
  PRIVATE SECTION.

    METHODS:
      get_badi
        RETURNING
          VALUE(rb_badi) TYPE REF TO /gicom/badi_ds_uom.

ENDCLASS.



CLASS /gicom/cl_dso_uom IMPLEMENTATION.


  METHOD check_unit_correspondence.
    DATA(lb_dso_uom) = me->get_badi( ).

    CALL BADI lb_dso_uom->check_unit_correspondence
      EXPORTING
        iv_unit_from = iv_unit_from
        iv_unit_to   = iv_unit_to
      RECEIVING
        rv_result    = rv_result.
  ENDMETHOD.


  METHOD search.
    DATA(lb_dso_uom) = me->get_badi( ).

    CALL BADI lb_dso_uom->search
      EXPORTING
        it_uom = it_uom
      RECEIVING
        rt_uom = rt_uom.
  ENDMETHOD.


  METHOD select.
    DATA(lb_dso_uom) = me->get_badi( ).

    CALL BADI lb_dso_uom->select
      IMPORTING
        et_uom     = et_uom
        et_uom_txt = et_uom_txt.

  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_badi.
  ENDMETHOD.


  METHOD get_conversion_factor.
    DATA(lb_dso_uom) = me->get_badi( ).

    CALL BADI lb_dso_uom->get_conversion_factor
      EXPORTING
        iv_unit_from = iv_unit_from
        iv_unit_to   = iv_unit_to
      RECEIVING
        rv_factor    = rv_factor.
  ENDMETHOD.

  METHOD delete_unit_of_measurements.

    DELETE FROM /gicom/_uom.
    DELETE FROM /gicom/_uom_t.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_unit_of_measurements.

    DATA : lt_unit_of_measurements TYPE TABLE OF /gicom/_uom,
           lt_unit_of_measurements_text TYPE TABLE OF /gicom/_uom_t.

    lt_unit_of_measurements = CORRESPONDING #( it_unit_of_measurements ).

    INSERT /gicom/_uom FROM TABLE lt_unit_of_measurements ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_UOM' SY-SUBRC.

   ENDIF.

   lt_unit_of_measurements_text = CORRESPONDING #( it_unit_of_measurements_text ).

    INSERT /gicom/_uom_t FROM TABLE lt_unit_of_measurements_text ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_UOM_T' SY-SUBRC.

   ENDIF.

  ENDMETHOD.


  METHOD read_unit_of_measurements.

     "Generate WHERE clause
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
      /gicom/_uom
    INTO
      CORRESPONDING FIELDS OF TABLE @et_unit_of_measurements
    WHERE
      (lv_where).

    IF sy-subrc = 0 AND et_unit_of_measurements IS NOT INITIAL.

      SELECT
        *
      FROM
        /gicom/_uom_t
      INTO
        CORRESPONDING FIELDS OF TABLE @et_unit_of_measurements_text
      FOR ALL ENTRIES IN @et_unit_of_measurements
      WHERE
        uom   =  @et_unit_of_measurements-uom .

    ELSEIF sy-subrc <> 0.

      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

    ENDIF.

   ENDMETHOD.

ENDCLASS.
