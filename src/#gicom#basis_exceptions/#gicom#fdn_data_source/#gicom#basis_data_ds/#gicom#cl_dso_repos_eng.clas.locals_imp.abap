*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_local_helper DEFINITION.

  PUBLIC SECTION.

    CLASS-METHODS prepare_method_sources
      IMPORTING
        iv_interface     TYPE seoclsname
        iv_class         TYPE seoclsname
      EXPORTING
        et_method_source TYPE seo_method_source_table
        et_aliases       TYPE seoo_aliases_r .

    CLASS-METHODS validate_tr
      IMPORTING
        iv_class    TYPE seoclsname
        iv_devclass TYPE devclass OPTIONAL
        iv_trkorr   TYPE trkorr.

    CLASS-METHODS get_tr_task_type_for_class
      IMPORTING
        iv_class            TYPE seoclsname
        iv_devclass         TYPE devclass OPTIONAL
      RETURNING
        VALUE(rv_task_type) TYPE trfunction.

ENDCLASS.

CLASS lcl_local_helper IMPLEMENTATION.

  METHOD prepare_method_sources.

    DATA lo_interface TYPE REF TO cl_abap_objectdescr.

    "Get the details of Interface
    lo_interface ?= cl_abap_objectdescr=>describe_by_name( iv_interface ).

    IF lo_interface IS BOUND.

      "Loop through interface methods
      LOOP AT lo_interface->methods ASSIGNING FIELD-SYMBOL(<lwa_method>).

        "Full method name including interface
        DATA(lv_method) = |{ iv_interface }~{ <lwa_method>-name }|.

      " Method Sources
        APPEND VALUE #( cpdname = lv_method
                        source  = VALUE #( ( |METHOD { lv_method }.| )
                                           ( | | )
                                           ( |ENDMETHOD.| )
                                         )
                      ) TO et_method_source.

        " Aliases
        APPEND VALUE #( clsname     = iv_class
                        cmpname     = <lwa_method>-name
                        version     = 1             "0 - Inactive; 1 - Active
                        exposure    = 2             "0 - Private; 1 - Protected; 2 - Public
                        cmptype     = 1             "0 - Attribute; 1 - Method; 3 - Type; 4 - Event
                        refclsname  = iv_interface
                        refcmpname  = <lwa_method>-name
                      ) TO et_aliases.


      ENDLOOP.

    ENDIF.
  ENDMETHOD.

  METHOD validate_tr.

    " This method is mainly intended to check the required task available within given TR
    " if not avaiable, required task needs to be created

    " get the task type for current class
    DATA(lv_task_type) = get_tr_task_type_for_class(
                           iv_class     = iv_class
                           iv_devclass  = iv_devclass
                         ).

    DATA(ls_tr_req_comm) = VALUE /gicom/trnspt_req_comm_s(
                             tr_req_type = 'K'
                             task_type   = lv_task_type
                             trkorr      = iv_trkorr
                           ).

    " call create task under this TR if required task is not available
    DATA(lv_task) = NEW /gicom/cl_dso_tr_eng( )->create_transport_task(
                      IMPORTING
                        es_tr_req_comm = ls_tr_req_comm
                    ).

  ENDMETHOD.

  METHOD get_tr_task_type_for_class.

    DATA: ls_new_gtadir TYPE gtadir,
          ls_new_tadir  TYPE tadir.

    " get the tadir details for current object
    CALL FUNCTION '/GICOM/TRINT_TADIR_INTERFACE'
      EXPORTING
        wi_test_modus     = 'X'
        wi_tadir_pgmid    = 'R3TR'
        wi_tadir_object   = 'CLAS'
        wi_tadir_obj_name = CONV sobj_name( iv_class )
        wi_tadir_devclass = iv_devclass
      IMPORTING
        new_gtadir_entry  = ls_new_gtadir
        new_tadir_entry   = ls_new_tadir.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    rv_task_type = COND #( WHEN ls_new_tadir-srcsystem EQ sy-sysid THEN 'S' ELSE 'R' ).

  ENDMETHOD.

ENDCLASS.
