*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_dso_tr_eng_helper DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS:

      get_tr_functions          IMPORTING iv_tr_type             TYPE trfunction
                                RETURNING VALUE(rt_tr_functions) TYPE /gicom/trfunction_rtt,

      create_task               IMPORTING is_tr_req_comm        TYPE /gicom/trnspt_req_comm_s
                                RETURNING VALUE(rv_task_trkorr) TYPE trkorr,

      create_task_if_not_exists IMPORTING iv_trkorr    TYPE trkorr
                                          iv_tr_type   TYPE trfunction OPTIONAL
                                          iv_task_type TYPE trfunction OPTIONAL,

      get_task_type             IMPORTING  iv_package          TYPE devclass
                                RETURNING  VALUE(rv_task_type) TYPE trfunction
                                EXCEPTIONS /gicom/cx_not_found.


    CONSTANTS:
      BEGIN OF lc_tr_req_type,
        cust_tr     TYPE trfunction VALUE 'W',
        work_tr     TYPE trfunction VALUE 'K',
        cust_task   TYPE trfunction VALUE 'Q',
        work_task   TYPE trfunction VALUE 'S',
        repair_task TYPE trfunction VALUE 'R',
      END OF lc_tr_req_type .

ENDCLASS.

CLASS lcl_dso_tr_eng_helper IMPLEMENTATION.

  METHOD get_tr_functions.

    CASE iv_tr_type.

      WHEN 'K'.
        rt_tr_functions = VALUE #( ( sign = 'I' option = 'EQ' low = 'K' )
                                   ( sign = 'I' option = 'EQ' low = 'S' )
                                   ( sign = 'I' option = 'EQ' low = 'R' )
                                   ( sign = 'I' option = 'EQ' low = 'X' ) ).

      WHEN 'W'.
        rt_tr_functions = VALUE #( ( sign = 'I' option = 'EQ' low = 'W' )
                                   ( sign = 'I' option = 'EQ' low = 'Q' ) ).

      WHEN OTHERS.
        rt_tr_functions = VALUE #( ( sign = 'I' option = 'EQ' low = iv_tr_type ) ).

    ENDCASE.

  ENDMETHOD.

  METHOD get_task_type.

***********************************************************************************************************
*** Old Logic
***********************************************************************************************************
    DATA: lt_tadir  TYPE scts_tadir.

    IF  1 = 2.

      CALL FUNCTION 'TR_READ_TADIRS'
        EXPORTING
          it_tadir = VALUE scts_tadir( ( pgmid = 'R3TR' object = 'DEVC' obj_name = iv_package ) )
        IMPORTING
          et_tadir = lt_tadir.

      IF lt_tadir IS INITIAL.

      ELSE.

        IF sy-sysid EQ lt_tadir[ 1 ]-srcsystem.
          rv_task_type = lc_tr_req_type-work_task.
        ELSE.
          rv_task_type = lc_tr_req_type-repair_task.
        ENDIF.

      ENDIF.

    ENDIF.

***********************************************************************************************************
*** New Logic
***********************************************************************************************************
    DATA: ls_new_gtadir TYPE gtadir,
          ls_new_tadir  TYPE tadir.

    " get the tadir details for current object
    CALL FUNCTION '/GICOM/TRINT_TADIR_INTERFACE'
      EXPORTING
        wi_test_modus     = 'X'
        wi_tadir_pgmid    = 'R3TR'
        wi_tadir_object   = 'CLAS'
        wi_tadir_obj_name = CONV sobj_name( iv_package )
        wi_tadir_devclass = iv_package
      IMPORTING
        new_gtadir_entry  = ls_new_gtadir
        new_tadir_entry   = ls_new_tadir.

    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    rv_task_type = COND #( WHEN ls_new_tadir-srcsystem EQ sy-sysid THEN lc_tr_req_type-work_task
                           ELSE lc_tr_req_type-repair_task ).

  ENDMETHOD.

  METHOD create_task.

    DATA ls_e07t TYPE e07t.

    CALL FUNCTION '/GICOM/TR_INSERT_NEW_COMM'
      EXPORTING
        iv_kurztext             = is_tr_req_comm-as4text
        iv_trfunction           = is_tr_req_comm-task_type
        iv_strkorr              = is_tr_req_comm-trkorr
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
      MOVE ls_e07t-trkorr TO rv_task_trkorr.
    ENDIF.

  ENDMETHOD.

  METHOD create_task_if_not_exists.

    DATA: lv_task    TYPE trkorr,
          lv_tr_type TYPE trfunction,
          ls_tr_comm TYPE /gicom/trnspt_req_comm_s.

    DATA(lt_task_type) = COND /gicom/trfunction_rtt( WHEN iv_task_type IS INITIAL THEN VALUE #( ( sign = 'E' option = 'EQ' low = abap_true ) )
                                                     ELSE VALUE #( ( sign = 'I' option = 'EQ' low = iv_task_type ) )
                         ).

    DATA(lv_username) = /gicom/cl_system=>get_username( ).

    SELECT SINGLE trkorr
         FROM e070
         INTO lv_task
         WHERE trfunction IN lt_task_type
           AND as4user    EQ lv_username
           AND strkorr    EQ iv_trkorr
           AND trstatus   NE 'R'.

    IF lv_task IS INITIAL.

      IF iv_task_type IS INITIAL.

        IF iv_tr_type IS INITIAL.
          SELECT SINGLE trfunction
                 FROM e070
                 INTO lv_tr_type
                 WHERE trkorr = iv_trkorr.
        ELSE.
          lv_tr_type = iv_tr_type.
        ENDIF.

        CASE lv_tr_type.
          WHEN lc_tr_req_type-cust_tr.
            ls_tr_comm-task_type = lc_tr_req_type-cust_task.
            ls_tr_comm-as4text   = TEXT-t02.
          WHEN lc_tr_req_type-work_tr.
            ls_tr_comm-task_type = lc_tr_req_type-work_task.
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

ENDCLASS.
