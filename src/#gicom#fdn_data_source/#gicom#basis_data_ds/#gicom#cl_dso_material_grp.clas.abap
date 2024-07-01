CLASS /gicom/cl_dso_material_grp DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_material_grp .
    INTERFACES if_badi_interface .

    ALIASES select_material_grp
      FOR /gicom/if_dso_material_grp~select_material_grp .

    ALIASES insert_material_groups
      FOR /gicom/if_dso_material_grp~insert_material_groups .

    ALIASES delete_material_groups
      FOR /gicom/if_dso_material_grp~delete_material_groups .

    ALIASES read_material_groups
      FOR /gicom/if_dso_material_grp~read_material_groups .

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_material_grp .

ENDCLASS.


CLASS /gicom/cl_dso_material_grp IMPLEMENTATION.


  METHOD /gicom/if_dso_material_grp~select_material_grp.
    DATA(lb_dso) = get_badi( ).

    CALL BADI lb_dso->select_material_grp
      IMPORTING
        et_material_grp     = et_material_grp
        et_material_grp_txt = et_material_grp_txt.

  ENDMETHOD.


  METHOD get_badi.

    GET BADI rb_dso.

  ENDMETHOD.

  METHOD delete_material_groups.

    DELETE FROM /gicom/_matkl_t.
    DELETE FROM /gicom/_matkl.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_material_groups.

    DATA:
      lt_material_groups_txt TYPE TABLE OF /gicom/_matkl_t,
      lt_material_groups     TYPE TABLE OF /gicom/_matkl.

    lt_material_groups_txt = CORRESPONDING #( it_material_groups_txt ).

    INSERT /gicom/_matkl_t FROM TABLE lt_material_groups_txt ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_MATKL_T' SY-SUBRC.

    ENDIF.


    lt_material_groups = CORRESPONDING #( it_material_groups ).

    INSERT /gicom/_matkl FROM TABLE lt_material_groups ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_MATKL' SY-SUBRC.

   ENDIF.


  ENDMETHOD.

  METHOD read_material_groups.

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

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).

    SELECT
      matkl
    FROM
      /gicom/_matkl
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_material_groups
    WHERE
      (lv_where).

    LOOP AT rt_material_groups ASSIGNING FIELD-SYMBOL(<ls_material_group>).

      SELECT SINGLE
        spras,
        wgbez
      FROM
        /gicom/_matkl_t
      WHERE
        matkl = @<ls_material_group>-matkl AND
        spras = @lv_language
      INTO
        CORRESPONDING FIELDS OF @<ls_material_group>.

    ENDLOOP.

    IF rt_material_groups IS INITIAL.

      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
