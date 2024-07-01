CLASS /gicom/cl_dso_division DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES /gicom/if_dso_division .

    ALIASES select_division
      FOR /gicom/if_dso_division~select_division .

    ALIASES insert_divisions
      FOR /gicom/if_dso_division~insert_divisions .

    ALIASES delete_divisions
      FOR /gicom/if_dso_division~delete_divisions .

    ALIASES read_divisions
      FOR /gicom/if_dso_division~read_divisions .


  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_division .
ENDCLASS.


CLASS /gicom/cl_dso_division IMPLEMENTATION.


  METHOD /gicom/if_dso_division~select_division.
    DATA(lb_dso) = get_badi( ).
    CALL BADI lb_dso->select_division
      IMPORTING
        et_division     = et_division
        et_division_txt = et_division_txt.
  ENDMETHOD.


  METHOD get_badi.


    GET BADI rb_dso.

  ENDMETHOD.

  METHOD delete_divisions.

    DELETE FROM /gicom/_divisn_t.
    DELETE FROM /gicom/_divisn.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_divisions.

    DATA lt_divisions_txt TYPE TABLE OF /gicom/_divisn_t.

    lt_divisions_txt = CORRESPONDING #( it_divisions_txt ).

    INSERT /gicom/_divisn_t FROM TABLE lt_divisions_txt ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_DIVISN_T' SY-SUBRC.

   ENDIF.


   DATA lt_division TYPE TABLE OF /gicom/_divisn.

    lt_division = CORRESPONDING #( it_divisions ).

    INSERT /gicom/_divisn FROM TABLE lt_division ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_DIVISN' SY-SUBRC.

   ENDIF.

  ENDMETHOD.

  METHOD read_divisions.

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

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).

    SELECT
      spart
    FROM
      /gicom/_divisn
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_divisions
    WHERE
      (lv_where).

    LOOP AT rt_divisions ASSIGNING FIELD-SYMBOL(<ls_division>).

      SELECT SINGLE
        spras,
        vtext
      FROM
        /gicom/_divisn_t
      WHERE
        spart = @<ls_division>-spart AND
        spras = @lv_language
      INTO
        CORRESPONDING FIELDS OF @<ls_division>.

    ENDLOOP.

    IF rt_divisions IS INITIAL.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
