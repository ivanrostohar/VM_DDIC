*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_local_helper DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS: insert_objects_into_tr IMPORTING  is_e071 TYPE ko200,

      create_task_if_not_exists IMPORTING iv_trkorr    TYPE trkorr
                                          iv_task_type TYPE trfunction,

      create_task        IMPORTING iv_trkorr             TYPE trkorr
                                   iv_as4text            TYPE as4text
                                   iv_task_type          TYPE trfunction
                         RETURNING VALUE(rv_task_trkorr) TYPE trkorr,

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

    .
    "EXCEPTIONS /gicom/cx_internal_error.

ENDCLASS.

CLASS lcl_local_helper IMPLEMENTATION.

  METHOD create_task.

    DATA ls_e07t TYPE e07t.

    CALL FUNCTION '/GICOM/TR_INSERT_NEW_COMM'
      EXPORTING
        iv_kurztext             = iv_as4text
        iv_trfunction           = iv_task_type
        iv_strkorr              = iv_trkorr
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

  METHOD get_task_type.

    DATA: lt_tadir  TYPE scts_tadir.

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

  ENDMETHOD.

  METHOD create_task_if_not_exists.

    DATA: lv_task    TYPE trkorr.

    DATA(lv_username) = /gicom/cl_system=>get_username( ).

    SELECT SINGLE trkorr
         FROM e070
         INTO lv_task
         WHERE as4user = lv_username AND
               trfunction = iv_task_type AND
               strkorr = iv_trkorr.

    IF lv_task IS INITIAL.

      create_task(
        iv_trkorr = iv_trkorr
        iv_as4text = COND #( WHEN iv_task_type = lc_tr_req_type-work_task
                                THEN 'Development / Correction'
                             WHEN iv_task_type = lc_tr_req_type-repair_task
                                THEN 'Repair' )
        iv_task_type = iv_task_type
      ).

    ENDIF.

  ENDMETHOD.

  METHOD insert_objects_into_tr.

    DATA: BEGIN OF ls_ddstruc,              "DICT-Structure
            objtype TYPE e071-object,
            objname TYPE e071-obj_name,
          END OF ls_ddstruc.

    ls_ddstruc-objtype = is_e071-object.
    ls_ddstruc-objname = is_e071-obj_name.

    " Create Task of Type 'Development/Correction' or 'Repair' based on Package Source System
    IF is_e071-devclass IS NOT INITIAL.

      DATA(lv_task_type) = get_task_type( iv_package = is_e071-devclass ).

      IF lv_task_type IS NOT INITIAL.
        create_task_if_not_exists( iv_trkorr = is_e071-trkorr iv_task_type = lv_task_type ).
      ENDIF.

    ENDIF.

    " Method for assigning Package and Transport Request(if any) to the structure/table

    CALL FUNCTION '/GICOM/RS_CORR_INSERT'
      EXPORTING
        iv_object           = ls_ddstruc
        iv_object_class     = 'DICT'
        iv_mode             = 'I'
        iv_global_lock      = is_e071-lockflag
        iv_devclass         = is_e071-devclass
        iv_korrnum          = is_e071-trkorr
        iv_author           = is_e071-author
        iv_master_language  = sy-langu
        iv_suppress_dialog  = abap_true
      EXCEPTIONS
        cancelled           = 1
        permission_failure  = 2
        unknown_objectclass = 3
        OTHERS              = 4.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

*    CALL FUNCTION 'RS_CORR_INSERT'
*      EXPORTING
*        object              = ls_ddstruc
*        object_class        = 'DICT'          " Dictionary Object
*        mode                = 'I'             " Insert
*        global_lock         = is_e071-lockflag
*        devclass            = is_e071-devclass
*        korrnum             = is_e071-trkorr
*        author              = is_e071-author
*        master_language     = sy-langu
*        suppress_dialog     = abap_true
*      EXCEPTIONS
*        cancelled           = 1
*        permission_failure  = 2
*        unknown_objectclass = 3
*        OTHERS              = 4.
*    IF sy-subrc <> 0.
** Implement suitable error handling here
*    ENDIF.

  ENDMETHOD.

ENDCLASS.
