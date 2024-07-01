class /GICOM/CL_DSO_TR_ENG definition
  public
  create public .

public section.
  constants:
    BEGIN OF gc_tr_req_type,
        cust_tr     TYPE trfunction VALUE 'W',
        work_tr     TYPE trfunction VALUE 'K',
        cust_task   TYPE trfunction VALUE 'Q',
        work_task   TYPE trfunction VALUE 'S',
        repair_task TYPE trfunction VALUE 'R',
      END OF gc_tr_req_type .
  methods CREATE_TASK_IF_NOT_EXISTS
    importing
      !IV_TRKORR type TRKORR
      !IV_TR_TYPE type TRFUNCTION optional
      !IV_TASK_TYPE type TRFUNCTION optional .
  interfaces /GICOM/IF_DSO_TR_ENG .

  aliases ASSIGN_DOMA_TO_TRANSPORT_REQ
    for /GICOM/IF_DSO_TR_ENG~ASSIGN_DOMA_TO_TRANSPORT_REQ .
  aliases ASSIGN_DTEL_TO_TRANSPORT_REQ
    for /GICOM/IF_DSO_TR_ENG~ASSIGN_DTEL_TO_TRANSPORT_REQ .
  aliases ASSIGN_OBJS_TO_TRANSPORT_REQ
    for /GICOM/IF_DSO_TR_ENG~ASSIGN_OBJS_TO_TRANSPORT_REQ .
  aliases ASSIGN_STRUC_TO_TRANSPORT_REQ
    for /GICOM/IF_DSO_TR_ENG~ASSIGN_STRUC_TO_TRANSPORT_REQ .
  aliases ASSIGN_TABLE_TO_TRANSPORT_REQ
    for /GICOM/IF_DSO_TR_ENG~ASSIGN_TABLE_TO_TRANSPORT_REQ .
  aliases ASSIGN_TTYPE_TO_TRANSPORT_REQ
    for /GICOM/IF_DSO_TR_ENG~ASSIGN_TTYPE_TO_TRANSPORT_REQ .
  aliases CREATE_TRANSPORT_REQUEST
    for /GICOM/IF_DSO_TR_ENG~CREATE_TRANSPORT_REQUEST .
  aliases CREATE_TRANSPORT_TASK
    for /GICOM/IF_DSO_TR_ENG~CREATE_TRANSPORT_TASK .
  aliases SELECT_TRANS_REQS_FOR_USER
    for /GICOM/IF_DSO_TR_ENG~SELECT_TRANS_REQS_FOR_USER .
  aliases SELECT_TRANS_REQ_FOR_KEY
    for /GICOM/IF_DSO_TR_ENG~SELECT_TRANS_REQ_FOR_KEY .
  aliases SELECT_TRANS_REQ_FOR_OBJECT
    for /GICOM/IF_DSO_TR_ENG~SELECT_TRANS_REQ_FOR_OBJECT .
protected section.
private section.
ENDCLASS.



CLASS /GICOM/CL_DSO_TR_ENG IMPLEMENTATION.


METHOD /gicom/if_dso_tr_eng~assign_objs_to_transport_req.

  DATA: lv_no_show ,
        lv_trkorr  TYPE trkorr,
        lv_task    TYPE trkorr,
        lv_tr_type TYPE trfunction,
        ls_tr_comm TYPE /gicom/trnspt_req_comm_s.

  IF iv_trkorr IS INITIAL.

  ELSE.
    lv_trkorr = iv_trkorr.
    lv_no_show = abap_true.
  ENDIF.

  CHECK ct_e071 IS NOT INITIAL.

  lcl_dso_tr_eng_helper=>create_task_if_not_exists( iv_trkorr = iv_trkorr ).

  TRY.

      CALL FUNCTION '/GICOM/TR_OBJECTS_CHECK'
        EXPORTING
          iv_no_show_option       = lv_no_show
        IMPORTING
          ev_order                = lv_trkorr
        TABLES
          it_ko200                = ct_e071
          it_e071k                = ct_e071k
        EXCEPTIONS
          cancel_edit_other_error = 4
          show_only_other_error   = 8
          OTHERS                  = 8.

      IF sy-subrc <> 0.

      ENDIF.

      MOVE iv_trkorr TO lv_trkorr.

      CALL FUNCTION '/GICOM/TR_OBJECTS_INSERT'
        EXPORTING
          iv_order                = lv_trkorr
          iv_no_show_option       = lv_no_show
        IMPORTING
          ev_order                = rv_trkorr
        TABLES
          it_ko200                = ct_e071
          it_e071k                = ct_e071k
        EXCEPTIONS
          cancel_edit_other_error = 1
          show_only_other_error   = 2
          OTHERS                  = 3.

      IF sy-subrc <> 0.

      ENDIF.

    CATCH cx_sy_send_dynpro_no_receiver.

*      RAISE EXCEPTION TYPE /GICOM/CX_SAP_CALL_ERROR
*        MESSAGE
*          ID sy-msgid
*          TYPE sy-msgty
*          NUMBER sy-msgno
*          WITH
*            sy-msgv1
*            sy-msgv2
*            sy-msgv3
*            sy-msgv4
*        EXPORTING
*          iv_function_module = '/GICOM/TR_OBJECTS_CHECK'
*          iv_subrc = sy-subrc.

  ENDTRY.

ENDMETHOD.


METHOD /GICOM/IF_DSO_TR_ENG~ASSIGN_DOMA_TO_TRANSPORT_REQ.

  DATA: lwa_ko200 TYPE ko200,
        lt_ko200  TYPE TABLE OF ko200.

  CHECK it_objname IS NOT INITIAL.

  LOOP AT it_objname INTO DATA(lwa_objname).
    lwa_ko200-trkorr = iv_trkorr.
    lwa_ko200-pgmid = 'R3TR'.
    lwa_ko200-object = 'DOMA'.
    lwa_ko200-obj_name = lwa_objname.
    lwa_ko200-objfunc = space.
    lwa_ko200-devclass = iv_devclass.
    lwa_ko200-lang = lwa_ko200-masterlang = sy-langu.
    lwa_ko200-author = /gicom/cl_system=>get_username( ).
    APPEND lwa_ko200 TO lt_ko200.
    CLEAR lwa_ko200.
  ENDLOOP.

  rv_trkorr = me->assign_objs_to_transport_req( EXPORTING iv_trkorr = iv_trkorr CHANGING ct_e071 = lt_ko200 ).

ENDMETHOD.


METHOD /GICOM/IF_DSO_TR_ENG~ASSIGN_STRUC_TO_TRANSPORT_REQ.

  DATA: lwa_ko200 TYPE ko200,
        lt_ko200  TYPE TABLE OF ko200.

  CHECK it_objname IS NOT INITIAL.

  LOOP AT it_objname  INTO DATA(lwa_objname).
    lwa_ko200-trkorr = iv_trkorr.
    lwa_ko200-pgmid  = 'R3TR'.
    lwa_ko200-object = 'TABL'.
    lwa_ko200-obj_name = lwa_objname.
    lwa_ko200-objfunc = space.
    lwa_ko200-devclass = iv_devclass.
    lwa_ko200-lang = lwa_ko200-masterlang = sy-langu.
    lwa_ko200-author = /gicom/cl_system=>get_username( ).
    APPEND lwa_ko200 TO lt_ko200.
    CLEAR lwa_ko200.
  ENDLOOP.

  rv_trkorr = me->assign_objs_to_transport_req( EXPORTING iv_trkorr = iv_trkorr CHANGING ct_e071 = lt_ko200 ).

ENDMETHOD.


METHOD /gicom/if_dso_tr_eng~select_trans_req_for_key.

  CALL FUNCTION '/GICOM/GET_TRANS_REQ_OBJECT'
    EXPORTING
      iv_pgmid   = 'R3TR'
      iv_object  = 'TABU'
      iv_objname = CONV trobj_name( iv_tabname )
      iv_tabkey  = iv_key
    IMPORTING
      ev_trkorr  = rv_trkorr.

ENDMETHOD.


METHOD /GICOM/IF_DSO_TR_ENG~ASSIGN_TTYPE_TO_TRANSPORT_REQ.

  DATA: lwa_ko200 TYPE ko200,
        lt_ko200  TYPE TABLE OF ko200.

  CHECK it_objname IS NOT INITIAL.

  LOOP AT it_objname INTO DATA(lwa_objname).
    lwa_ko200-trkorr = iv_trkorr.
    lwa_ko200-pgmid = 'R3TR'.
    lwa_ko200-object = 'TTYP'.
    lwa_ko200-obj_name = lwa_objname.
    lwa_ko200-devclass = iv_devclass.
    lwa_ko200-objfunc = space.
    lwa_ko200-lang = lwa_ko200-masterlang = sy-langu.
    lwa_ko200-author = /gicom/cl_system=>get_username( ).
    APPEND lwa_ko200 TO lt_ko200.
    CLEAR lwa_ko200.
  ENDLOOP.

  rv_trkorr = me->assign_objs_to_transport_req( EXPORTING iv_trkorr = iv_trkorr CHANGING ct_e071 = lt_ko200 ).

ENDMETHOD.


METHOD /GICOM/IF_DSO_TR_ENG~ASSIGN_DTEL_TO_TRANSPORT_REQ.

  DATA: lwa_ko200 TYPE ko200,
        lt_ko200  TYPE TABLE OF ko200.

  CHECK it_objname IS NOT INITIAL.

  LOOP AT it_objname INTO DATA(lwa_objname).
    lwa_ko200-trkorr = iv_trkorr.
    lwa_ko200-pgmid = 'R3TR'.
    lwa_ko200-object = 'DTEL'.
    lwa_ko200-obj_name = lwa_objname.
    lwa_ko200-objfunc = space.
    lwa_ko200-devclass = iv_devclass.
    lwa_ko200-lang = lwa_ko200-masterlang = sy-langu.
    lwa_ko200-author = /gicom/cl_system=>get_username( ).
    APPEND lwa_ko200 TO lt_ko200.
    CLEAR lwa_ko200.
  ENDLOOP.

  rv_trkorr = me->assign_objs_to_transport_req( EXPORTING iv_trkorr = iv_trkorr CHANGING ct_e071 = lt_ko200 ).

ENDMETHOD.


METHOD /gicom/if_dso_tr_eng~create_transport_request.

  DATA: ls_e07t TYPE e07t.

  IF  es_tr_req_comm-tr_req_type IS NOT INITIAL
  AND es_tr_req_comm-as4text IS NOT INITIAL.

    CALL FUNCTION '/GICOM/TR_INSERT_NEW_COMM'
      EXPORTING
        iv_kurztext             = es_tr_req_comm-as4text
        iv_trfunction           = es_tr_req_comm-tr_req_type
      IMPORTING
        es_e07t                 = ls_e07t
      EXCEPTIONS
        client_range_full       = 1
        e070l_insert_error      = 2
        e070l_update_error      = 3
        e070_insert_error       = 4
        e07t_insert_error       = 5
        e070c_insert_error      = 6
        e070m_insert_error      = 7
        no_systemname           = 8
        no_systemtype           = 9
        sap_range_full          = 10
        unallowed_trfunction    = 11
        unallowed_user          = 12
        order_not_found         = 13
        invalid_targetsystem    = 14
        invalid_target_devclass = 15
        invalid_devclass        = 16
        invalid_target_layer    = 17
        invalid_status          = 18
        not_an_order            = 19
        order_lock_failed       = 20
        no_authorization        = 21
        wrong_client            = 22
        file_access_error       = 23
        wrong_category          = 24
        internal_error          = 25
        OTHERS                  = 26.
    IF sy-subrc EQ 0.

      MOVE-CORRESPONDING ls_e07t TO es_tr_req_comm.

      CASE es_tr_req_comm-tr_req_type.
        WHEN gc_tr_req_type-cust_tr.

          es_tr_req_comm-task_type = gc_tr_req_type-cust_task.

        WHEN gc_tr_req_type-work_tr.

          IF iv_package IS NOT INITIAL.
            es_tr_req_comm-task_type = lcl_dso_tr_eng_helper=>get_task_type( iv_package = iv_package ).
          ELSE.
            es_tr_req_comm-task_type = gc_tr_req_type-work_task.
          ENDIF.

      ENDCASE.

      DATA(lv_task_trkorr) = lcl_dso_tr_eng_helper=>create_task( es_tr_req_comm ).
    ENDIF.

  ENDIF.

ENDMETHOD.


  METHOD create_task_if_not_exists.

    DATA(ls_tr_comm) = VALUE /gicom/trnspt_req_comm_s( ).

    DATA(lt_task_type) = COND /gicom/trfunction_rtt(
      WHEN iv_task_type IS INITIAL THEN VALUE #( ( sign = 'E' option = 'EQ' low = abap_true ) )
      ELSE VALUE #( ( sign = 'I' option = 'EQ' low = iv_task_type ) )
    ).

    DATA(lv_username) = /gicom/cl_system=>get_username( ).

    SELECT SINGLE
      trkorr
    FROM
      e070
    INTO
      @DATA(lv_task)
    WHERE
      trfunction IN @lt_task_type AND
      as4user    EQ @lv_username AND
      strkorr    EQ @iv_trkorr AND
      trstatus   NE 'R'.

    IF lv_task IS INITIAL.

      IF iv_task_type IS INITIAL.

        IF iv_tr_type IS INITIAL.
          SELECT SINGLE
            trfunction
          FROM
            e070
          INTO
            @DATA(lv_tr_type)
          WHERE
            trkorr EQ @iv_trkorr.
        ELSE.
          lv_tr_type = iv_tr_type.
        ENDIF.

        CASE lv_tr_type.
          WHEN 'W'.
            ls_tr_comm-task_type = 'Q'.
            ls_tr_comm-as4text   = TEXT-t02.
          WHEN 'K'.
            ls_tr_comm-task_type = 'S'.
            ls_tr_comm-as4text   = TEXT-t01.
        ENDCASE.

      ELSE.

        ls_tr_comm-task_type = iv_task_type.
        ls_tr_comm-as4text   = TEXT-t03.

      ENDIF.

      IF ls_tr_comm-task_type IS NOT INITIAL.
        ls_tr_comm-trkorr = iv_trkorr.
        lcl_dso_tr_eng_helper=>create_task( is_tr_req_comm = ls_tr_comm ).
      ENDIF.

    ENDIF.

  ENDMETHOD.


METHOD /gicom/if_dso_tr_eng~select_trans_req_for_object.

  CALL FUNCTION '/GICOM/GET_TRANS_REQ_OBJECT'
    EXPORTING
      iv_pgmid   = 'R3TR'
      iv_object  = iv_object
      iv_objname = iv_obj_name
    IMPORTING
      ev_trkorr  = rv_trkorr.

ENDMETHOD.


METHOD /GICOM/IF_DSO_TR_ENG~SELECT_TRANS_REQS_FOR_USER.

  DATA: ls_ranges   TYPE trsel_ts_ranges,
        lrt_trkorrs TYPE trrngtrkor_tab,
        lt_requests TYPE trwbo_request_headers.

**********************************************************************
*** Fill Username
**********************************************************************
  IF iv_uname IS INITIAL.
    DATA(lv_user) = /gicom/cl_system=>get_username( ).
  ELSE.
    lv_user = iv_uname.
  ENDIF.

**********************************************************************
*** Fill Client
**********************************************************************
  IF iv_client IS INITIAL.
    DATA(lv_client) = sy-mandt.
  ELSE.
    lv_client = iv_client.
  ENDIF.

**********************************************************************
*** Get List of TR Functions based on input
**********************************************************************
  IF iv_tr_type IS INITIAL.
    DATA(lrt_trfunction) = VALUE /gicom/trfunction_rtt( ( sign = 'I' option = 'CP' low = '*' ) ).
  ELSE.
    lrt_trfunction = lcl_dso_tr_eng_helper=>get_tr_functions( iv_tr_type ).
  ENDIF.

**********************************************************************
*** Prepare Ranges
**********************************************************************
  ls_ranges-as4user = VALUE #( ( sign = 'I' option = 'EQ' low = lv_user ) ).
  ls_ranges-request_funcs = lrt_trfunction.
  ls_ranges-request_status = VALUE #( ( sign = 'I' option = 'EQ' low = 'D' )
                                      ( sign = 'I' option = 'EQ' low = 'L' )
                             ).
  ls_ranges-client = VALUE #( ( sign = 'I' option = 'EQ' low = lv_client ) ).

**********************************************************************
*** Get List of TRs Functions based on input
**********************************************************************

  CALL FUNCTION '/GICOM/TRINT_SELECT_REQUESTS'
    EXPORTING
      iv_username_pattern    = lv_user
      iv_complete_projects   = abap_false
    IMPORTING
      et_requests            = lt_requests
    CHANGING
      cs_ranges              = ls_ranges
    EXCEPTIONS
      action_aborted_by_user = 1
      OTHERS                 = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    RETURN.
  ENDIF.

**********************************************************************
*** Prepare result
**********************************************************************
  LOOP AT lt_requests ASSIGNING FIELD-SYMBOL(<lwa_request>).

    IF <lwa_request>-strkorr IS NOT INITIAL.
      APPEND VALUE #( trkorr  = <lwa_request>-strkorr
                      as4text = <lwa_request>-as4text ) TO rt_e07t.
    ELSE.
      APPEND VALUE #( trkorr  = <lwa_request>-trkorr
                      as4text = <lwa_request>-as4text ) TO rt_e07t.
    ENDIF.

  ENDLOOP.

  SORT rt_e07t BY trkorr.
  DELETE ADJACENT DUPLICATES FROM rt_e07t COMPARING trkorr.



*************************************************************************
****** Fill Username
*************************************************************************
***  IF iv_uname IS INITIAL.
***    DATA(lv_user) = /gicom/cl_system=>get_username( ).
***  ELSE.
***    lv_user = iv_uname.
***  ENDIF.
***
*************************************************************************
****** Get List of TR Functions based on input
*************************************************************************
***  IF iv_tr_type IS INITIAL.
***    DATA(lrt_trfunction) = VALUE /gicom/trfunction_rtt( ( sign = 'I' option = 'CP' low = '*' ) ).
***  ELSE.
***    lrt_trfunction = lcl_dso_tr_eng_helper=>get_tr_functions( iv_tr_type ).
***  ENDIF.
***
***  SELECT trkorr, strkorr
***    FROM e070
***    INTO TABLE @DATA(lt_e070)
***   WHERE trfunction IN @lrt_trfunction
***     AND trstatus   IN ('D','L')
***     AND as4user    EQ @lv_user.
***  IF NOT lt_e070 IS INITIAL.
***
***    "Collect the Main/Header Requests
***    LOOP AT lt_e070 ASSIGNING FIELD-SYMBOL(<lwa_e070>).
***      IF <lwa_e070>-strkorr IS NOT INITIAL.
***        APPEND VALUE #( sign = 'I' option = 'EQ' low = <lwa_e070>-strkorr ) TO lrt_trkorrs.
***      ELSE.
***        APPEND VALUE #( sign = 'I' option = 'EQ' low = <lwa_e070>-trkorr ) TO lrt_trkorrs.
***      ENDIF.
***    ENDLOOP.
***
***    "TODO: Get the Tr only related to current client
******    SELECT trkorr
******      FROM e070c
******      INTO TABLE @data(lt_e070c)
******     WHERE trkorr IN @lrt_trkorrs.
***
***    "Get Transport Header Texts
***    SELECT trkorr, as4text
***      FROM e07t
***      INTO CORRESPONDING FIELDS OF TABLE @rt_e07t
***     WHERE trkorr IN @lrt_trkorrs.
***
***    IF sy-subrc EQ 0.
***
***      SORT rt_e07t BY trkorr.
***      DELETE ADJACENT DUPLICATES FROM rt_e07t COMPARING trkorr.
***
***    ENDIF.
***
***  ENDIF.

ENDMETHOD.


METHOD /gicom/if_dso_tr_eng~create_transport_task.

  CHECK es_tr_req_comm-trkorr IS NOT INITIAL AND
        es_tr_req_comm-task_type IS NOT INITIAL.

  " new logic
  lcl_dso_tr_eng_helper=>create_task_if_not_exists(
    EXPORTING
      iv_trkorr    = es_tr_req_comm-trkorr
      iv_tr_type   = es_tr_req_comm-tr_req_type
      iv_task_type = es_tr_req_comm-task_type
  ).

  " previous logic
  IF 1 = 2.
    rv_task = lcl_dso_tr_eng_helper=>create_task( es_tr_req_comm ).
  ENDIF.

ENDMETHOD.


METHOD /GICOM/IF_DSO_TR_ENG~ASSIGN_TABLE_TO_TRANSPORT_REQ.

  DATA: lwa_ko200 TYPE ko200,
        lwa_e071k TYPE e071k,
        lt_ko200  TYPE TABLE OF ko200,
        lt_e071k  TYPE TABLE OF e071k.

  CHECK it_objname IS NOT INITIAL.

  LOOP AT it_objname INTO DATA(lwa_tabname).
    lwa_ko200-trkorr = iv_trkorr.
    lwa_ko200-pgmid = 'R3TR'.
    lwa_ko200-object = 'TABL'.
    lwa_ko200-obj_name = lwa_tabname.
    lwa_ko200-objfunc = space.
    lwa_ko200-devclass = iv_devclass.
    lwa_ko200-lang  = lwa_ko200-masterlang = sy-langu.
    lwa_ko200-author = /gicom/cl_system=>get_username( ).
    APPEND lwa_ko200 TO lt_ko200.
    CLEAR: lwa_ko200.
  ENDLOOP.

  rv_trkorr = me->assign_objs_to_transport_req( EXPORTING iv_trkorr = iv_trkorr CHANGING ct_e071 = lt_ko200  ).

ENDMETHOD.
ENDCLASS.
