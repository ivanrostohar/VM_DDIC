CLASS /gicom/cl_dso_distr_channel DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES /gicom/if_dso_distr_channel .

    ALIASES select_distr_channel
      FOR /gicom/if_dso_distr_channel~select_distr_channel .

    ALIASES insert_distribution_channels
      FOR /gicom/if_dso_distr_channel~insert_distribution_channels .

    ALIASES delete_distribution_channels
      FOR /gicom/if_dso_distr_channel~delete_distribution_channels .

    ALIASES read_distribution_channels
      FOR /gicom/if_dso_distr_channel~read_distribution_channels .

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS get_badi
      RETURNING
        VALUE(rb_dso) TYPE REF TO /gicom/badi_ds_distr_channel .

ENDCLASS.



CLASS /gicom/cl_dso_distr_channel IMPLEMENTATION.


  METHOD /gicom/if_dso_distr_channel~select_distr_channel.

    DATA(lb_dso) = get_badi( ).

    CALL BADI lb_dso->select_distr_channel
      IMPORTING
        et_distr_chanl     = et_distr_chanl
        et_distr_chanl_txt = et_distr_chanl_txt.

  ENDMETHOD.


  METHOD get_badi.


    GET BADI rb_dso.

  ENDMETHOD.

  METHOD delete_distribution_channels.

    DELETE FROM /gicom/_dis_ch_t.
    DELETE FROM /gicom/_dis_ch.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD insert_distribution_channels.

     DATA lt_distribution_channels TYPE TABLE OF /gicom/_dis_ch.

     lt_distribution_channels = CORRESPONDING #( it_distribution_channels ).

     INSERT /gicom/_dis_ch FROM TABLE lt_distribution_channels ACCEPTING DUPLICATE KEYS.

     IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

     ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH ' /GICOM/_DIS_CH' SY-SUBRC.

     ENDIF.


     DATA lt_distribution_channels_txt TYPE TABLE OF /gicom/_dis_ch_t.

     lt_distribution_channels_txt = CORRESPONDING #( it_distribution_channels_txt ).

     INSERT /gicom/_dis_ch_t FROM TABLE lt_distribution_channels_txt ACCEPTING DUPLICATE KEYS.

     IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

     ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH ' /GICOM/_DIS_CH_T' SY-SUBRC.

     ENDIF.

  ENDMETHOD.

  METHOD read_distribution_channels.

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

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).

    SELECT
      vtweg
    FROM
      /gicom/_dis_ch
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_distribution_channels
    WHERE
      (lv_where).

    LOOP AT rt_distribution_channels ASSIGNING FIELD-SYMBOL(<ls_distr_channel>).

      SELECT SINGLE
        spras,
        vtext
      FROM
        /gicom/_dis_ch_t
      WHERE
        vtweg = @<ls_distr_channel>-vtweg AND
        spras = @lv_language
      INTO
        CORRESPONDING FIELDS OF @<ls_distr_channel>.

    ENDLOOP.

    IF rt_distribution_channels IS INITIAL.
      RAISE EXCEPTION NEW /gicom/cx_not_found(  ).
    ENDIF.


  ENDMETHOD.

ENDCLASS.
