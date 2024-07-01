CLASS /gicom/cl_dso_plant DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES /gicom/if_dso_plant .

    ALIASES select_plant
      FOR /gicom/if_dso_plant~select_plant .

    ALIASES insert_plants
      FOR /gicom/if_dso_plant~insert_plants .

    ALIASES delete_plants
      FOR /gicom/if_dso_plant~delete_plants .

    ALIASES read_plants
      FOR /gicom/if_dso_plant~read_plants .

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_plant .
ENDCLASS.



CLASS /gicom/cl_dso_plant IMPLEMENTATION.


  METHOD /gicom/if_dso_plant~select_plant.
    DATA(lb_dso) = get_badi( ).

    CALL BADI lb_dso->select_plant
      IMPORTING
        et_plants = et_plants.

  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_dso.
  ENDMETHOD.

  METHOD delete_plants.

    DELETE FROM /gicom/_plant.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_plants.

    DATA lt_plants TYPE TABLE OF /gicom/_plant.

    lt_plants = CORRESPONDING #( it_plants ).

    INSERT /gicom/_plant FROM TABLE lt_plants ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
      MESSAGE ID '/GICOM/MSG_BASIS_DS'
      NUMBER 000
      WITH '/GICOM/_PLANT' SY-SUBRC.

   ENDIF.

  ENDMETHOD.

  METHOD read_plants.

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
     /gicom/_plant
   INTO
     CORRESPONDING FIELDS OF TABLE @rt_plants
   WHERE
        (lv_where).

   IF sy-subrc <> 0.

     RAISE EXCEPTION NEW /gicom/cx_not_found(  ).

   ENDIF.

  ENDMETHOD.

ENDCLASS.
