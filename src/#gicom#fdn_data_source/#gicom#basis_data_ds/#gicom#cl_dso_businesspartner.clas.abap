CLASS /gicom/cl_dso_businesspartner DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES /gicom/if_dso_businesspartner.

    ALIASES search
      FOR /gicom/if_dso_businesspartner~search .
    ALIASES select
      FOR /gicom/if_dso_businesspartner~select .
    ALIASES select_relations
      FOR /gicom/if_dso_businesspartner~select_relations.
    ALIASES search_by_data
      FOR /gicom/if_dso_businesspartner~search_by_date.
    ALIASES select_address
      FOR /gicom/if_dso_businesspartner~select_address.
    ALIASES insert_business_partners
      FOR /gicom/if_dso_businesspartner~insert_business_partners.
    ALIASES delete_business_partners
      FOR /gicom/if_dso_businesspartner~delete_business_partners.
    ALIASES read_business_partners
      FOR /gicom/if_dso_businesspartner~read_business_partners.
    ALIASES insert_bp_relations
      FOR /gicom/if_dso_businesspartner~insert_bp_relations.
    ALIASES delete_bp_relations
      FOR /gicom/if_dso_businesspartner~delete_bp_relations.
    ALIASES read_bp_relations
      FOR /gicom/if_dso_businesspartner~read_bp_relations.
    ALIASES is_using_business_partner
      FOR /gicom/if_dso_businesspartner~is_using_business_partner.



    METHODS get_badi
      RETURNING
        VALUE(rb_badi) TYPE REF TO /gicom/badi_ds_businesspartner.

  PROTECTED SECTION.

    METHODS map_activity_bupa
      IMPORTING
        is_businesspartner         TYPE /gicom/bupa_a_s
      RETURNING
        VALUE(rv_allowed_activity) TYPE /gicom/activity_allowed.

    METHODS map_activity_suppl_cocode
      IMPORTING
        is_supplier_cocode         TYPE /gicom/supplier_cocode_s
      RETURNING
        VALUE(rv_allowed_activity) TYPE /gicom/activity_allowed.

    METHODS map_activity_suppl_purch_org
      IMPORTING
        is_supplier_purch_org      TYPE /gicom/supplier_purch_org_s
      RETURNING
        VALUE(rv_allowed_activity) TYPE /gicom/activity_allowed.

    METHODS map_activity_cust_cocode
      IMPORTING
        is_customer_cocode         TYPE /gicom/customer_cocode_s
      RETURNING
        VALUE(rv_allowed_activity) TYPE /gicom/activity_allowed.

    METHODS map_activity_cust_sales_org
      IMPORTING
        is_customer_sales_org      TYPE /gicom/customer_sales_org_s
      RETURNING
        VALUE(rv_allowed_activity) TYPE /gicom/activity_allowed.

    METHODS map_activity_relation
      IMPORTING
        is_relation                TYPE  /gicom/bupa_rel_s
      RETURNING
        VALUE(rv_allowed_activity) TYPE /gicom/activity_allowed.

    METHODS map_activity_default
      IMPORTING
        iv_blocked                 TYPE /gicom/x_blocked
        iv_deleted                 TYPE /gicom/x_deleted
        iv_purpose_complete        TYPE /gicom/x_purpose_complete
      RETURNING
        VALUE(rv_allowed_activity) TYPE /gicom/activity_allowed.


    METHODS map_messages
      IMPORTING
        is_businesspartner TYPE /gicom/bupa_a_s
      RETURNING
        VALUE(rt_messages) TYPE /gicom/bupa_message_tt.

    METHODS copy_record_status_flags
      IMPORTING
        is_source TYPE any
      CHANGING
        cs_target TYPE any.

    METHODS get_where_for_selopt
      IMPORTING
        !it_selopt      TYPE ddshselops
      RETURNING
        VALUE(rv_where) TYPE string .

ENDCLASS.



CLASS /gicom/cl_dso_businesspartner IMPLEMENTATION.


  METHOD /gicom/if_dso_businesspartner~search.
    DATA(lb_badi) = me->get_badi( ).

    CALL BADI lb_badi->search
      EXPORTING
        iv_name_1           = iv_name_1
        iv_name_2           = iv_name_2
        iv_person           = iv_person
      RECEIVING
        rt_businesspartners = rt_businesspartners.
  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~search_by_date.
    DATA(lb_badi) = me->get_badi( ).

    CALL BADI lb_badi->search_by_date
      EXPORTING
        iv_valid_date       = iv_valid_date
      RECEIVING
        rt_businesspartners = rt_businesspartners.
  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~select.
    DATA(lb_badi) = me->get_badi( ).

    CALL BADI lb_badi->select
      EXPORTING
        it_partner          = it_partner
      RECEIVING
        rt_businesspartners = rt_businesspartners.
  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~select_relations.
    DATA(lb_badi) = me->get_badi( ).

    CALL BADI lb_badi->select_relations
      EXPORTING
        it_partner   = it_partner
      RECEIVING
        rt_relations = rt_relations.

  ENDMETHOD.


  METHOD copy_record_status_flags.
    DATA(lt_fields) = VALUE /gicom/string_tt(
      ( `X_BLOCKED` )
      ( `X_DELETED` )
      ( `X_PURPOSE_COMPLETE` )
    ).

    LOOP AT lt_fields INTO DATA(lv_field).
      ASSIGN COMPONENT lv_field OF STRUCTURE is_source TO FIELD-SYMBOL(<lv_src>).
      ASSIGN COMPONENT lv_field OF STRUCTURE cs_target TO FIELD-SYMBOL(<lv_dest>).

      CHECK <lv_src> IS ASSIGNED AND <lv_dest> IS ASSIGNED.
      <lv_dest> = <lv_src>.

      UNASSIGN:
        <lv_src>,
        <lv_dest>.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_badi.
    GET BADI rb_badi.
  ENDMETHOD.


  METHOD map_activity_bupa.
    rv_allowed_activity = me->map_activity_default(
      iv_blocked          = is_businesspartner-x_blocked
      iv_deleted          = is_businesspartner-x_deleted
      iv_purpose_complete = is_businesspartner-x_purpose_complete
    ).
  ENDMETHOD.


  METHOD map_activity_cust_cocode.
    rv_allowed_activity = me->map_activity_default(
      iv_blocked          = is_customer_cocode-x_blocked
      iv_deleted          = is_customer_cocode-x_deleted
      iv_purpose_complete = is_customer_cocode-x_purpose_complete
    ).
  ENDMETHOD.


  METHOD map_activity_cust_sales_org.
    rv_allowed_activity = me->map_activity_default(
      iv_blocked          = is_customer_sales_org-x_blocked
      iv_deleted          = is_customer_sales_org-x_deleted
      iv_purpose_complete = is_customer_sales_org-x_purpose_complete
    ).
  ENDMETHOD.


  METHOD map_activity_default.
    " 0 -> Not show -> archived / deleted
    " 1 -> Show     -> archived / deleted
    " 2 -> Edit     -> blocked
    " 3 -> Create   -> else

    IF iv_deleted = abap_true.
      rv_allowed_activity = /gicom/if_const_record_status=>cv_activity_internal_only.
    ELSEIF iv_purpose_complete = abap_true.
      rv_allowed_activity = /gicom/if_const_record_status=>cv_activity_display_allowed.
    ELSEIF iv_blocked = abap_true.
      rv_allowed_activity = /gicom/if_const_record_status=>cv_activity_change_allowed.
    ELSE.
      rv_allowed_activity = /gicom/if_const_record_status=>cv_activity_all.
    ENDIF.
  ENDMETHOD.


  METHOD map_activity_relation.
    rv_allowed_activity = me->map_activity_default(
      iv_blocked          = is_relation-x_blocked
      iv_deleted          = is_relation-x_deleted
      iv_purpose_complete = is_relation-x_purpose_complete
    ).
  ENDMETHOD.


  METHOD map_activity_suppl_cocode.
    rv_allowed_activity = me->map_activity_default(
      iv_blocked          = is_supplier_cocode-x_blocked
      iv_deleted          = is_supplier_cocode-x_deleted
      iv_purpose_complete = is_supplier_cocode-x_purpose_complete
    ).
  ENDMETHOD.


  METHOD map_activity_suppl_purch_org.
    rv_allowed_activity = me->map_activity_default(
      iv_blocked          = is_supplier_purch_org-x_blocked
      iv_deleted          = is_supplier_purch_org-x_deleted
      iv_purpose_complete = is_supplier_purch_org-x_purpose_complete
    ).
  ENDMETHOD.


  METHOD map_messages.
*    custom implementation will be implemented here

*    DATA ls_message_1 TYPE /gicom/bupa_message_s.
*
*    ls_message-msg_id = 'ZGI_MESSAGES'.
*    ls_message-msg_v1 = is_businesspartner-bu_partner.
*    ls_message-activity_allowed = /gicom/if_const_record_status=>cv_activity_display_allowed.
*    ls_message-msg_no = 'XYZ'.
*
*    APPEND ls_message TO rt_messages.


  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~select_address.
    DATA(lb_badi) = me->get_badi( ).

    CALL BADI lb_badi->select_address
      EXPORTING
        iv_bu_id   = iv_bu_id
        iv_bu_type = iv_bu_type
      RECEIVING
        rt_address = rt_address.

  ENDMETHOD.

  METHOD /gicom/if_dso_businesspartner~insert_business_partners.

    DATA : lt_business_partners         TYPE TABLE OF /gicom/_bupa,
           lt_business_partner_relation TYPE TABLE OF /gicom/_bupa_rel,
           lt_business_partner_role     TYPE TABLE OF /gicom/_bupa_rol,
           lt_business_partner_message  TYPE TABLE OF /gicom/_bupa_msg.

    lt_business_partners  = CORRESPONDING #( it_business_partners ).



    INSERT /gicom/_bupa FROM TABLE lt_business_partners ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.
      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BUPA' sy-subrc.

    ENDIF.

    lt_business_partner_relation  = CORRESPONDING #( it_business_partner_relation ).

    INSERT /gicom/_bupa_rel FROM TABLE lt_business_partner_relation ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.
      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BUPA_REL' sy-subrc.

    ENDIF.


    lt_business_partner_role  = CORRESPONDING #( it_business_partner_role ).

    INSERT /gicom/_bupa_rol FROM TABLE lt_business_partner_role ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.
      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BUPA_ROL' sy-subrc.

    ENDIF.

    lt_business_partner_message   = CORRESPONDING #( it_business_partner_message ).

    INSERT /gicom/_bupa_msg FROM TABLE lt_business_partner_message ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.
      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BUPA_MSG' sy-subrc.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_businesspartner~delete_business_partners.

    DELETE FROM /gicom/_bupa.
    DELETE FROM /gicom/_bupa_rel.
    DELETE FROM /gicom/_bupa_rol.
    DELETE FROM /gicom/_bupa_msg.

    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_businesspartner~delete_bp_relations.

    DELETE FROM /gicom/_bp_rels.
    IF iv_commit = abap_true.
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_businesspartner~insert_bp_relations.

    DATA lt_bp_relations TYPE TABLE OF /gicom/_bp_rels.

    lt_bp_relations = CORRESPONDING #( it_bp_relations ).

    INSERT /gicom/_bp_rels FROM TABLE lt_bp_relations ACCEPTING DUPLICATE KEYS.

    IF sy-subrc = 0 AND iv_commit = abap_true.
      COMMIT WORK.

    ELSEIF sy-subrc <> 0.

      ROLLBACK WORK.

      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        NUMBER 000
        WITH '/GICOM/_BP_RELS' sy-subrc.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_businesspartner~read_bp_relations.

    SELECT
      *
    FROM
      /gicom/_bp_rels
    INTO
      CORRESPONDING FIELDS OF TABLE @rt_bp_relations.


  ENDMETHOD.

  METHOD /gicom/if_dso_businesspartner~read_business_partners.


    "Generate WHERE clause
    DATA lt_where_parts TYPE /gicom/string_tt.

    DATA(lt_selopt) = it_selopt.

    APPEND VALUE #(
      shlpfield = 'ACTIVITY_ALLOWED'
      sign      = 'I'
      option    = 'GE'
      low       = iv_activity
    ) TO lt_selopt.

    "All changes that were done here regarding mantis 20265 is just a work around solution
    "Collecting all role related selection options from lt_selopt into separate table lt_role_selopt
    DATA lt_include_roles_selopt TYPE ddshselops.
    DATA lt_exclude_roles_selopt TYPE ddshselops.
    LOOP AT lt_selopt ASSIGNING FIELD-SYMBOL(<ls_selopt>) WHERE shlpfield = 'ROLE_INTERNAL'.
      IF <ls_selopt>-sign = 'E'.
        " We want everything that is meant to exclude roles from our selection here
        APPEND <ls_selopt> TO lt_exclude_roles_selopt.
      ELSEIF <ls_selopt>-sign = 'I' AND <ls_selopt>-option = 'NE'.
        " Do this conversion to avoid an issue of the current get_where_for_selopt
        APPEND VALUE #(
          shlpname  = <ls_selopt>-shlpname
          shlpfield = <ls_selopt>-shlpfield
          sign      = 'E'
          option    = 'EQ'
          low       = <ls_selopt>-low
        ) TO lt_exclude_roles_selopt.
      ELSE.
        APPEND <ls_selopt> TO lt_include_roles_selopt.
      ENDIF.
    ENDLOOP.

    "Deleting all role related selection options from lt_selopt and preparing dynamic where condition
    DELETE lt_selopt WHERE shlpfield = 'ROLE_INTERNAL'.

    DATA(lv_where_roles)         = me->get_where_for_selopt( lt_include_roles_selopt ).
    DATA(lv_exclude_where_roles) = me->get_where_for_selopt( lt_exclude_roles_selopt ).

    IF lv_where_roles IS NOT INITIAL AND lv_exclude_where_roles IS NOT INITIAL.
      lv_where_roles = |{ lv_where_roles } AND ( { lv_exclude_where_roles } )|.
    ELSEIF lv_exclude_where_roles IS NOT INITIAL.
      lv_where_roles = lv_exclude_where_roles.
    ENDIF.

    DATA(lv_where) = me->get_where_for_selopt( lt_selopt ).

    SELECT
      *
    FROM
      /gicom/_bupa
    INTO
      CORRESPONDING FIELDS OF TABLE @et_business_partners
    WHERE
      (lv_where) .

   IF sy-subrc = 0 AND et_business_partners IS NOT INITIAl.

      SELECT
        *
      FROM
        /gicom/_bupa_rol
      INTO
        CORRESPONDING FIELDS OF TABLE @et_business_partner_role
      FOR ALL ENTRIES IN @et_business_partners

      WHERE
        (lv_where_roles) AND
        bu_partner = @et_business_partners-bu_partner.

      SELECT
        *
      FROM
        /gicom/_bupa_rel
      INTO
        CORRESPONDING FIELDS OF TABLE @et_business_partner_relation
      FOR ALL ENTRIES IN @et_business_partners
      WHERE
        bu_partner = @et_business_partners-bu_partner.

      SELECT
        *
      FROM
        /gicom/_bupa_msg
      INTO
        CORRESPONDING FIELDS OF TABLE @et_business_partner_message
      FOR ALL ENTRIES IN @et_business_partners
      WHERE
        bu_partner = @et_business_partners-bu_partner.

    ENDIF.

  ENDMETHOD.

  METHOD get_where_for_selopt.

    DATA lt_selopt TYPE ddshselops.
    DATA lt_title_selopt TYPE ddshselops.

    CLEAR: lt_selopt, lt_title_selopt.

    "we need to process multiple NAME fields with OR instead of AND
    LOOP AT it_selopt ASSIGNING FIELD-SYMBOL(<ls_selopt>).
      IF <ls_selopt>-shlpfield EQ 'NAME_1' OR <ls_selopt>-shlpfield EQ 'NAME_2' OR <ls_selopt>-shlpfield EQ 'NAME_3' OR <ls_selopt>-shlpfield EQ 'NAME_4'.
        APPEND <ls_selopt> TO lt_title_selopt.
      ELSE.
        APPEND <ls_selopt> TO lt_selopt.
      ENDIF.
    ENDLOOP.

    IF lines( lt_title_selopt ) = 1. "no need for OR
      APPEND lt_title_selopt[ 1 ] TO lt_selopt.
      CLEAR lt_title_selopt.
    ENDIF.

    rv_where = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
      it_selopt = lt_selopt
      iv_statement = '2'
    ).

    IF lines( lt_title_selopt ) > 0.
      DATA(lv_title_where) = /gicom/cl_util_ddic=>conv_shlp_selopt_to_where_exp(
        it_selopt = lt_title_selopt
        iv_statement = '2'
      ).

      CHECK lv_title_where IS NOT INITIAL. " we don't continue because we don't want to add an and ( ) to our where

*      REPLACE 'AND' WITH 'OR' INTO lv_title_where.  "DEL KS_M.16216 does not make sense - incomplete!
      REPLACE ALL OCCURRENCES OF 'AND'  IN lv_title_where WITH 'OR'.  "INS KS_M.16216
      IF rv_where IS NOT INITIAL.
        rv_where = rv_where && ` AND ( ` && lv_title_where && ` )`.
      ELSE.
        rv_where = lv_title_where.
      ENDIF.
    ENDIF.


  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~is_using_business_partner.

    SELECT SINGLE
      type
    FROM
      /gicom/_bupa
    WHERE
      type       = @/gicom/if_constants_bo=>cv_bo_bupa AND
      bu_partner <> @/gicom/if_constants_bupa=>cv_id_deleted_dummy
    INTO @DATA(lv_type).

    IF lv_type IS NOT INITIAL.
      rv_using_business_partner = abap_true.
    ELSE.
      rv_using_business_partner = abap_false.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
