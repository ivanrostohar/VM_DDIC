CLASS /gicom/cl_metric_collector DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS:
      create
        IMPORTING
          iv_object           TYPE /gicom/metric_object
          it_values           TYPE /gicom/metric_vl_tt OPTIONAL
          it_labels           TYPE /gicom/metric_lb_tt OPTIONAL
          iv_level            TYPE int1 OPTIONAL
        RETURNING
          VALUE(ro_collector) TYPE REF TO /gicom/cl_metric_collector
        RAISING
          /gicom/cx_root_ds.
    METHODS
      constructor
        IMPORTING
          iv_object TYPE /gicom/metric_object
          it_values TYPE /gicom/metric_vl_tt OPTIONAL
          it_labels TYPE /gicom/metric_lb_tt OPTIONAL
          iv_level  TYPE int1 OPTIONAL.
    METHODS
      create_sub_measurement
        IMPORTING
          iv_object                 TYPE /gicom/metric_object
          it_values                 TYPE /gicom/metric_vl_tt OPTIONAL
          it_labels                 TYPE /gicom/metric_lb_tt OPTIONAL
          iv_level                  TYPE int1 OPTIONAL
        RETURNING
          VALUE(ro_child_collector) TYPE REF TO /gicom/cl_metric_collector
        RAISING
          /gicom/cx_root_ds.
    METHODS
      create_and_start
        IMPORTING
          iv_object TYPE /gicom/metric_object
          iv_level  TYPE int1 OPTIONAL
        RAISING
          /gicom/cx_root_ds.
    METHODS
      start.
    METHODS
      finish
        EXPORTING
          es_metric TYPE /gicom/metric
        RAISING
          /gicom/cx_root_ds.
    METHODS
      add_value
        IMPORTING
          iv_name  TYPE /gicom/metric_key
          iv_value TYPE /gicom/metric_value
        RAISING
          /gicom/cx_root_ds.
    METHODS
      add_label
        IMPORTING
          iv_name  TYPE /gicom/metric_key
          iv_value TYPE /gicom/metric_value
        RAISING
          /gicom/cx_root_ds.
    METHODS
      save
        EXPORTING
          es_metric TYPE /gicom/metric
        RAISING
          /gicom/cx_root_ds.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS
      save_children
        RAISING
          /gicom/cx_root_ds.
    METHODS
      add_parent_metric
        IMPORTING
          io_parent_metric TYPE REF TO /gicom/cl_metric_collector
        RAISING
          /gicom/cx_root_ds.

    TYPES: BEGIN OF ts_child,
             child_metric TYPE REF TO /gicom/cl_metric_collector,
           END OF ts_child,
           tt_child TYPE STANDARD TABLE OF ts_child.

    DATA: gt_child         TYPE tt_child,
          gt_values        TYPE /gicom/metric_vl_tt,
          gt_labels        TYPE /gicom/metric_lb_tt,
          gs_head          TYPE /gicom/metric_data_s,
          go_parent_metric TYPE REF TO /gicom/cl_metric_collector,
          gv_start_time    TYPE /gicom/timestmps,
          gv_end_time      TYPE /gicom/timestmps.
    CLASS-DATA: gv_parent_metric_id TYPE /gicom/metric_id.

ENDCLASS.



CLASS /GICOM/CL_METRIC_COLLECTOR IMPLEMENTATION.


  METHOD constructor.

    gt_labels = it_labels.
    gt_values = it_values.
    gs_head   = VALUE #( object     = iv_object
                         created_by = /gicom/cl_system=>get_username( )
                         created_on = /gicom/cl_util_time_date=>get_time_stamp( ) ).

  ENDMETHOD.


  METHOD create.

    ro_collector = NEW #( iv_object = iv_object
                          it_labels = it_labels
                          it_values = it_values
                          iv_level  = iv_level ).

  ENDMETHOD.


  METHOD create_sub_measurement.

    ro_child_collector = NEW /gicom/cl_metric_collector( iv_object = iv_object
                                                         it_labels = it_labels
                                                         it_values = it_values
                                                         iv_level  = iv_level ).

    ro_child_collector->add_parent_metric( me ).

    APPEND VALUE #( child_metric = ro_child_collector ) TO gt_child.

  ENDMETHOD.


  METHOD create_and_start.

    me->create( iv_object = iv_object iv_level = iv_level ).
    me->start(  ).

  ENDMETHOD.


  METHOD start.

    gv_start_time = /gicom/cl_util_time_date=>get_time_stamp( ).

  ENDMETHOD.


  METHOD finish.

    IF gv_start_time IS INITIAL.

      "Measurement has not started yet
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_METRIC'
        TYPE 'E'
        NUMBER 001.

    ENDIF.

    gv_end_time = /gicom/cl_util_time_date=>get_time_stamp( ).

    me->save( IMPORTING es_metric = es_metric ).

  ENDMETHOD.


  METHOD add_value.

    APPEND VALUE #( name = iv_name value = iv_value ) TO gt_values.

  ENDMETHOD.


  METHOD add_label.

    APPEND VALUE #( name = iv_name value = iv_value ) TO gt_labels.

  ENDMETHOD.


  METHOD save.

    IF go_parent_metric IS BOUND.

      CHECK gv_parent_metric_id IS NOT INITIAL. "Parent has to be saved first
      gs_head-parent_id = gv_parent_metric_id.

    ENDIF.

    TRY.

        IF gv_start_time IS INITIAL.

          "Measurement has not started yet
          RAISE EXCEPTION TYPE /gicom/cx_internal_error
            MESSAGE ID '/GICOM/MSG_METRIC'
            TYPE 'E'
            NUMBER 001.

        ENDIF.

        IF gv_end_time IS INITIAL.

          "Measurement has not finished yet
          RAISE EXCEPTION TYPE /gicom/cx_internal_error
            MESSAGE ID '/GICOM/MSG_METRIC'
            TYPE 'E'
            NUMBER 002.

        ENDIF.

        gs_head-duration = gv_end_time - gv_start_time.

        DATA(lo_dso_metric) = NEW /gicom/cl_dso_metric( ).

        lo_dso_metric->insert_metric(
               EXPORTING
                 is_metric = gs_head
               IMPORTING
                ev_metric_id = DATA(lv_metric_id)
                                     ).

        es_metric    = CORRESPONDING #( gs_head ).
        es_metric-id = lv_metric_id.

        LOOP AT gt_labels ASSIGNING FIELD-SYMBOL(<ls_label>).
          <ls_label>-id = lv_metric_id.
        ENDLOOP.

        lo_dso_metric->insert_metric_labels(
                EXPORTING
                    it_labels = gt_labels
                                           ).
        LOOP AT gt_values ASSIGNING FIELD-SYMBOL(<ls_value>).
          <ls_value>-id = lv_metric_id.
        ENDLOOP.

        lo_dso_metric->insert_metric_values(
                EXPORTING
                    it_values = gt_values
                                           ).

        gv_parent_metric_id = lv_metric_id.

        me->save_children(  ).

      CATCH /gicom/cx_root_ds INTO DATA(lo_ex).

        ROLLBACK WORK.
        RAISE EXCEPTION TYPE /gicom/cx_internal_error EXPORTING previous = lo_ex.

    ENDTRY.

  ENDMETHOD.


  METHOD save_children.

    LOOP AT gt_child ASSIGNING FIELD-SYMBOL(<lo_child>).

      <lo_child>-child_metric->save(  ).

    ENDLOOP.

  ENDMETHOD.


  METHOD add_parent_metric.

    go_parent_metric = io_parent_metric.

  ENDMETHOD.
ENDCLASS.
