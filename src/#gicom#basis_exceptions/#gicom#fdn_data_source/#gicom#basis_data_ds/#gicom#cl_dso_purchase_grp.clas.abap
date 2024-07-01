CLASS /gicom/cl_dso_purchase_grp DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_purchase_grp .
    INTERFACES if_badi_interface .

    ALIASES select_purchase_grps
      FOR /gicom/if_dso_purchase_grp~select_purchase_grps .

    ALIASES insert_purchasing_groups
      FOR /gicom/if_dso_purchase_grp~insert_purchasing_groups .

    ALIASES delete_purchasing_groups
      FOR /gicom/if_dso_purchase_grp~delete_purchasing_groups .

    ALIASES read_purchasing_groups
    FOR /gicom/if_dso_purchase_grp~read_purchasing_groups .

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_purchase_grp .
ENDCLASS.


CLASS /gicom/cl_dso_purchase_grp IMPLEMENTATION.


  METHOD get_badi.
    GET BADI rb_dso.
  ENDMETHOD.


  METHOD /gicom/if_dso_purchase_grp~select_purchase_grps.

    DATA(lo_dso) = me->get_badi( ).

    TRY .
        CALL BADI lo_dso->select_purchase_grps
          IMPORTING
            et_purchase_grps = et_purchase_grps.

      CATCH /gicom/cx_not_found INTO DATA(lx_exception).
        RAISE EXCEPTION NEW /gicom/cx_rfc_error( previous = lx_exception ).

    ENDTRY.

  ENDMETHOD.


  METHOD insert_purchasing_groups.

    DATA lt_purchasing_groups TYPE TABLE OF /gicom/_pur_gr_t.

    lt_purchasing_groups = CORRESPONDING #( it_purchasing_groups ).

    INSERT /gicom/_pur_gr_t FROM TABLE @lt_purchasing_groups ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_PUR_GR_T' SY-SUBRC.

    ENDIF.

  ENDMETHOD.

  METHOD delete_purchasing_groups.

    DELETE FROM /gicom/_pur_gr_t.

    IF iv_commit = abap_true.
      COMMIT WORK.
   ENDIF.

  ENDMETHOD.

  METHOD read_purchasing_groups.

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
      /gicom/_pur_gr_t
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_purchasing_groups
    WHERE
      (lv_where).

    IF sy-subrc <> 0.

      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

   ENDIF.

  ENDMETHOD.

ENDCLASS.
