CLASS /gicom/cl_dso_material DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:
      /gicom/if_dso_material.


    ALIASES select FOR /gicom/if_dso_material~select .
    ALIASES delete_makt FOR /gicom/if_dso_material~delete_makt .
    ALIASES delete_mara FOR /gicom/if_dso_material~delete_mara .
    ALIASES delete_marm FOR /gicom/if_dso_material~delete_marm .
    ALIASES insert_mara_ean FOR /gicom/if_dso_material~insert_mara_ean .
    ALIASES delete_mara_ean FOR /gicom/if_dso_material~delete_mara_ean .
    ALIASES delete_mat_org FOR /gicom/if_dso_material~delete_mat_org .
    ALIASES select_material_title FOR /gicom/if_dso_material~select_material_title .
    ALIASES select_materials FOR /gicom/if_dso_material~select_materials .
    ALIASES select_material_with_gtin FOR /gicom/if_dso_material~select_material_with_gtin .

    METHODS:
      insert_makt
        IMPORTING
          it_makt TYPE /gicom/_makt_tt
        RAISING
          /gicom/cx_inconsistent_data,

      insert_mara
        IMPORTING
          it_mara TYPE /gicom/_mara_tt
        RAISING
          /gicom/cx_inconsistent_data,

      insert_marm
        IMPORTING
          it_marm TYPE /gicom/marm_a_tt
        RAISING
          /gicom/cx_inconsistent_data,

      insert_mat_org
        IMPORTING
          it_mat_org TYPE /gicom/_mat_org_tt
        RAISING
          /gicom/cx_inconsistent_data.



  PRIVATE SECTION.

    METHODS:

      get_badi
        RETURNING
          VALUE(rb_badi) TYPE REF TO /gicom/badi_ds_material.


ENDCLASS.



CLASS /gicom/cl_dso_material IMPLEMENTATION.


  METHOD /gicom/if_dso_material~select.
    DATA(lb_badi) = me->get_badi( ).

    CALL BADI lb_badi->select
      IMPORTING
        et_material        = et_material
        et_material_txt    = et_material_txt
        et_material_bo_rel = et_material_bo_rel.
  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_badi.
  ENDMETHOD.


  METHOD insert_makt.

    INSERT /gicom/_makt FROM TABLE @it_makt ACCEPTING DUPLICATE KEYS.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_inconsistent_data
        MESSAGE
        ID '/GICOM/BS_GENERAL'
        TYPE 'E'
        NUMBER 002
        WITH '/GICOM/_MAKT'.
    ENDIF.
  ENDMETHOD.


  METHOD insert_mara.

    INSERT /gicom/_mara FROM TABLE @it_mara ACCEPTING DUPLICATE KEYS.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_inconsistent_data
        MESSAGE
        ID '/GICOM/BS_GENERAL'
        TYPE 'E'
        NUMBER 002
        WITH '/GICOM/_MARA'.
    ENDIF.
  ENDMETHOD.

  METHOD insert_marm.

    INSERT /gicom/_marm FROM TABLE @it_marm ACCEPTING DUPLICATE KEYS.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_inconsistent_data
        MESSAGE
        ID '/GICOM/BS_GENERAL'
        TYPE 'E'
        NUMBER 002
        WITH '/GICOM/_MARM'.
    ENDIF.
  ENDMETHOD.

  METHOD insert_mat_org.

    INSERT /gicom/_mat_org FROM TABLE @it_mat_org ACCEPTING DUPLICATE KEYS.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_inconsistent_data
        MESSAGE
        ID '/GICOM/BS_GENERAL'
        TYPE 'E'
        NUMBER 002
        WITH '/GICOM/_MAT_ORG'.
    ENDIF.

  ENDMETHOD.



  METHOD /gicom/if_dso_material~delete_makt.

    DELETE FROM /gicom/_makt.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_material~delete_mara.

    DELETE FROM /gicom/_mara.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_material~delete_marm.

    DELETE FROM /gicom/_marm.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_material~insert_mara_ean.

    DATA lt_mara_ean TYPE TABLE OF /gicom/_mara_ean.
    lt_mara_ean = CORRESPONDING #( it_mara_ean ).
    INSERT /gicom/_mara_ean FROM TABLE @lt_mara_ean ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.

      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_MARA_EAN' sy-subrc.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_material~delete_mara_ean.

    DELETE FROM /gicom/_mara_ean.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_material~delete_mat_org.

    DELETE FROM /gicom/_mat_org.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.



  METHOD /gicom/if_dso_material~select_material_title.

    SELECT SINGLE title
    FROM
       /gicom/_makt
    WHERE
      material = @iv_matnr
    INTO (@rv_material_title).



  ENDMETHOD.

  METHOD /gicom/if_dso_material~select_materials.

    DATA(lv_language) = /gicom/cl_system=>get_language(  ).
    DATA(lt_selopt) = it_selopt.

    LOOP AT lt_selopt ASSIGNING FIELD-SYMBOL(<ls_selopt_matnr>) WHERE shlpfield = 'MATNR'.
      <ls_selopt_matnr>-shlpfield = 'MATERIAL'.
    ENDLOOP.


     TRY.
        DATA(lv_title_pattern) = lt_selopt[ shlpfield = 'TITLE' ]-low.

        IF NOT lv_title_pattern CS '*'.
          lv_title_pattern = lv_title_pattern && '*'.
        ENDIF.

        DELETE lt_selopt WHERE shlpfield = 'TITLE'.
      CATCH cx_sy_itab_line_not_found.
        " Ignore this one
    ENDTRY.

    "Generate Where clause for sender
    " In UI5, there are two ways to filter for sender, so we have 2 different selopt-fields, which have to be moved to one
    DATA lt_selopt_sender TYPE ddshselops.
    DATA lt_sender TYPE /gicom/bo_id_tt.

    LOOP AT lt_selopt ASSIGNING FIELD-SYMBOL(<ls_selopt>) WHERE shlpfield = 'SENDER_MULTI' OR shlpfield = 'SENDER' .
      IF <ls_selopt>-shlpfield EQ 'SENDER_MULTI' OR <ls_selopt>-shlpfield EQ 'SENDER'.

        <ls_selopt>-shlpfield = 'OID'.

        /gicom/cl_util_ddic=>conv_bo_id_rem_to_loc(
          EXPORTING
            iv_bo_typ                = /gicom/cl_util_bo=>cv_bo_bupa
            iv_input                 = <ls_selopt>-low
          IMPORTING
            ev_output                = <ls_selopt>-low
        ).

        SELECT SINGLE
          org_ext~id AS oid
        FROM
          /gicom/org_ext AS org_ext
        WHERE
          bo_id_repr = @<ls_selopt>-low AND
          bo_typ_repr = @/gicom/cl_util_bo=>cv_bo_bupa
        INTO  @<ls_selopt>-low.

      ENDIF.

      APPEND <ls_selopt> TO lt_selopt_sender.

    ENDLOOP.

    DATA(lv_where_sender) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
      it_selopt = lt_selopt_sender
      iv_statement = '2'
    ).

    "Security check: check where clause
    IF lv_where_sender <> space.
      DATA(lv_whilelist_sender) = lv_where_sender.
      TRY.
          lv_where_sender = cl_abap_dyn_prg=>check_whitelist_str(
                                 val       = lv_where_sender
                                 whitelist = lv_whilelist_sender
                            ).

        CATCH cx_abap_not_in_whitelist INTO DATA(lx_exception_sender).
          RAISE EXCEPTION NEW /gicom/cx_internal_error( previous = lx_exception_sender ).
      ENDTRY.
    ENDIF.

    DELETE lt_selopt WHERE shlpfield = 'BO_ID' OR shlpfield = 'BO_TYP' OR shlpfield = 'OID'.


     SELECT
       *
     FROM
      /gicom/_mat_org
     INTO
      CORRESPONDING FIELDS OF TABLE @et_material_bo_rel
     WHERE
      (lv_where_sender).


    LOOP AT lt_selopt ASSIGNING FIELD-SYMBOL(<ls_selopt_mfrnr>) WHERE shlpfield = 'MANUFACTURER'.
      <ls_selopt_mfrnr>-shlpfield = 'MFRNR'.
    ENDLOOP.

    "Generate WHERE clause
    IF lt_selopt IS NOT INITIAL.
      DATA(lv_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt = lt_selopt
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

    SELECT
     *
    FROM
      /gicom/_mara
    INTO CORRESPONDING FIELDS OF TABLE @et_mara
    WHERE
      (lv_where).


      SELECT
       *
      FROM
        /gicom/_mara_ean
      FOR ALL ENTRIES IN @et_mara
      WHERE
        matnr = @et_mara-material
      INTO
        CORRESPONDING FIELDS OF TABLE @et_mara_ean.


     SELECT
       *
     FROM
      /gicom/_marm
     FOR ALL ENTRIES IN @et_mara
      WHERE
        material = @et_mara-material
     INTO CORRESPONDING FIELDS OF TABLE @et_marm.

     SELECT
      *
     FROM
      /gicom/_makt
     FOR ALL ENTRIES IN @et_mara
      WHERE
        material = @et_mara-material AND
        spras    = @lv_language
     INTO CORRESPONDING FIELDS OF TABLE @et_makt.



  ENDMETHOD.

  METHOD /gicom/if_dso_material~select_material_with_gtin.

    SELECT
      *
    FROM
      /gicom/_mara_ean
    WHERE
      ean_upc = @iv_gtin
    INTO CORRESPONDING FIELDS OF TABLE @rt_material_ean.

  ENDMETHOD.

ENDCLASS.
