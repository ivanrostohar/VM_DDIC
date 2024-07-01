CLASS /gicom/cl_dso_sales_org DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_sales_org .
    INTERFACES if_badi_interface .

    ALIASES select_sales_orgs
      FOR /gicom/if_dso_sales_org~select_sales_orgs .

    ALIASES insert_sales_organizations
     FOR /gicom/if_dso_sales_org~insert_sales_organizations .

    ALIASES delete_sales_organizations
    FOR /gicom/if_dso_sales_org~delete_sales_organizations .

    ALIASES read_sales_organizations
    FOR /gicom/if_dso_sales_org~read_sales_organizations .

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_sales_org .
ENDCLASS.



CLASS /gicom/cl_dso_sales_org IMPLEMENTATION.


  METHOD /gicom/if_dso_sales_org~select_sales_orgs.

    TRY.
        DATA(lb_dso) = me->get_badi( ).

        CALL BADI lb_dso->select_sales_orgs
          IMPORTING
            et_sales_orgs     = et_sales_orgs
            et_sales_orgs_txt = et_sales_orgs_txt.

      CATCH cx_badi.
    ENDTRY.
  ENDMETHOD.


  METHOD get_badi.

    GET BADI rb_dso.

  ENDMETHOD.

  METHOD delete_sales_organizations.

    DELETE FROM /gicom/_sas_og_t .
    DELETE FROM /gicom/_sas_og.

    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_sales_organizations.

    DATA:
      lt_sales_organizations_txt TYPE TABLE OF /gicom/_sas_og_t,
      lt_sales_organizations TYPE TABLE OF /gicom/_sas_og.

    lt_sales_organizations_txt = CORRESPONDING #( it_sales_organizations_txt ).

    INSERT /gicom/_sas_og_t FROM TABLE lt_sales_organizations_txt ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_SAS_OG_T' sy-subrc.

    ENDIF.

    lt_sales_organizations = CORRESPONDING #( it_sales_organizations ).

    INSERT /gicom/_sas_og FROM TABLE lt_sales_organizations ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_SAS_OG' sy-subrc.

    ENDIF.


  ENDMETHOD.

  METHOD read_sales_organizations.

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
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception ).
      ENDTRY.
    ENDIF.

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).

    SELECT
      vkorg
    FROM
      /gicom/_sas_og as sales_org
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_sales_organizations
    WHERE
      (lv_where).

    LOOP AT rt_sales_organizations ASSIGNING FIELD-SYMBOL(<ls_sales_org>).

      SELECT SINGLE
        spras,
        vtext
      FROM
        /gicom/_sas_og_t
      WHERE
        vkorg = @<ls_sales_org>-vkorg AND
        spras = @lv_language
      INTO
        CORRESPONDING FIELDS OF @<ls_sales_org>.

    ENDLOOP.

    IF rt_sales_organizations IS INITIAL.

      RAISE EXCEPTION NEW /gicom/cx_not_found( ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
