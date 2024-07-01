CLASS /gicom/cl_dso_purchase_org DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_purchase_org .
    INTERFACES if_badi_interface .

    ALIASES select_purchase_orgs
      FOR /gicom/if_dso_purchase_org~select_purchase_orgs .
    ALIASES insert_purchase_organzations
      FOR /gicom/if_dso_purchase_org~insert_purchase_organzations .
    ALIASES delete_purchase_organizations
    FOR /gicom/if_dso_purchase_org~delete_purchase_organizations .
    ALIASES read_purchase_organizations
    FOR /gicom/if_dso_purchase_org~read_purchase_organizations .

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_purchase_org .
ENDCLASS.

CLASS /gicom/cl_dso_purchase_org IMPLEMENTATION.

  METHOD select_purchase_orgs.

    DATA(lo_dso) = me->get_badi( ).

    TRY.
        CALL BADI lo_dso->select_purchase_orgs
          IMPORTING
            et_purchase_orgs = et_purchase_orgs.

     CATCH /gicom/cx_not_found INTO DATA(lx_exception).
        RAISE EXCEPTION NEW /gicom/cx_rfc_error( previous = lx_exception ).

    ENDTRY.

  ENDMETHOD.

  METHOD get_badi.

    GET BADI rb_dso.

  ENDMETHOD.

  METHOD insert_purchase_organzations.

    DATA lt_purchasing_organizations TYPE TABLE OF /gicom/_pur_og_t.

    lt_purchasing_organizations = CORRESPONDING #( it_purchasing_organizations ).

    INSERT /gicom/_pur_og_t FROM TABLE lt_purchasing_organizations ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_PUR_OG_T' SY-SUBRC.

    ENDIF.

  ENDMETHOD.

  METHOD delete_purchase_organizations.

    DELETE FROM /gicom/_pur_og_t.

    IF iv_commit = abap_true.
      COMMIT WORK.
   ENDIF.

  ENDMETHOD.

  METHOD read_purchase_organizations.

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
      /gicom/_pur_og_t
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_purchasing_organizations
    WHERE
      (lv_where).

    IF sy-subrc <> 0.

      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
