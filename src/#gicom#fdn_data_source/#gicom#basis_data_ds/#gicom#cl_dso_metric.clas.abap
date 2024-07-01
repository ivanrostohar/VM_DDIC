CLASS /gicom/cl_dso_metric DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES /gicom/if_dso_metric.

    ALIASES insert_metric
        FOR /gicom/if_dso_metric~insert_metric.
    ALIASES insert_metric_values
        FOR /gicom/if_dso_metric~insert_metric_values.
    ALIASES insert_metric_labels
        FOR /gicom/if_dso_metric~insert_metric_labels.
    ALIASES delete_metric_by_id
        FOR /gicom/if_dso_metric~delete_metric_by_id.
    ALIASES delete_metric_values_by_id
        FOR /gicom/if_dso_metric~delete_metric_values_by_id.
    ALIASES delete_metric_labels_by_id
        FOR /gicom/if_dso_metric~delete_metric_labels_by_id.
    ALIASES get_metric_data_by_id
        FOR /gicom/if_dso_metric~get_metric_data_by_id.
    ALIASES get_metric_values_by_id
        FOR /gicom/if_dso_metric~get_metric_values_by_id.
    ALIASES get_metric_labels_by_id
        FOR /gicom/if_dso_metric~get_metric_labels_by_id.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS
      get_next_metric_id
        EXPORTING
          ev_next_id TYPE /gicom/metric_id
        RAISING
          /gicom/cx_internal_error.
ENDCLASS.



CLASS /gicom/cl_dso_metric IMPLEMENTATION.

  METHOD /gicom/if_dso_metric~insert_metric.

    DATA: ls_metric TYPE /gicom/metric.

    /gicom/cl_util_table=>move_structure(
        EXPORTING
          is_source      = is_metric
        IMPORTING
          es_destination = ls_metric
        ).

    me->get_next_metric_id(
      IMPORTING
        ev_next_id = ls_metric-id
      ).

    INSERT /gicom/metric FROM ls_metric.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        TYPE 'E'
        NUMBER 000
        WITH '/GICOM/METRIC'
        sy-subrc.
    ENDIF.

    ev_metric_id = ls_metric-id.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~insert_metric_values.

    IF it_values IS NOT INITIAL.

      INSERT /gicom/metric_vl FROM TABLE it_values.

      IF sy-subrc IS NOT INITIAL.

        RAISE EXCEPTION TYPE /gicom/cx_internal_error
          MESSAGE ID '/GICOM/MSG_BASIS_DS'
          TYPE 'E'
          NUMBER 000
          WITH '/GICOM/METRIC_VL'
          sy-subrc.

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~insert_metric_labels.

    IF it_labels IS NOT INITIAL.

      INSERT /gicom/metric_lb FROM TABLE it_labels.

      IF sy-subrc IS NOT INITIAL.

        RAISE EXCEPTION TYPE /gicom/cx_internal_error
          MESSAGE ID '/GICOM/MSG_BASIS_DS'
          TYPE 'E'
          NUMBER 000
          WITH '/GICOM/METRIC_LB'
          sy-subrc.

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~delete_metric_by_id.

    IF iv_metric_id IS NOT INITIAL.

      DELETE FROM /gicom/metric WHERE id EQ iv_metric_id.

      IF sy-subrc IS NOT INITIAL.

        RAISE EXCEPTION TYPE /gicom/cx_internal_error
          MESSAGE ID '/GICOM/MSG_BASIS_DS'
          TYPE 'E'
          NUMBER 012
          WITH '/GICOM/METRIC'
          iv_metric_id.

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~delete_metric_values_by_id.

    IF iv_metric_id IS NOT INITIAL.

      DELETE FROM /gicom/metric_vl WHERE id EQ iv_metric_id.

      IF sy-subrc IS NOT INITIAL.

        RAISE EXCEPTION TYPE /gicom/cx_internal_error
          MESSAGE ID '/GICOM/MSG_BASIS_DS'
          TYPE 'E'
          NUMBER 012
          WITH '/GICOM/METRIC_VL'
          iv_metric_id.

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~delete_metric_labels_by_id.

    IF iv_metric_id IS NOT INITIAL.

      DELETE FROM /gicom/metric_lb WHERE id EQ iv_metric_id.

      IF sy-subrc IS NOT INITIAL.

        RAISE EXCEPTION TYPE /gicom/cx_internal_error
          MESSAGE ID '/GICOM/MSG_BASIS_DS'
          TYPE 'E'
          NUMBER 012
          WITH '/GICOM/METRIC_LB'
          iv_metric_id.

      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~get_metric_data_by_id.

    SELECT SINGLE
      id,
      object,
      parent_id,
      duration,
      start_metric,
      end_metric,
      created_by,
      created_on
    FROM
      /gicom/metric
    WHERE
      id = @iv_metric_id
    INTO CORRESPONDING FIELDS OF
      @rs_metric.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        TYPE 'E'
        NUMBER 003
        WITH iv_metric_id
        '/GICOM/METRIC'.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~get_metric_values_by_id.

    SELECT
      id,
      name,
      value
    FROM
      /gicom/metric_vl
    WHERE
      id = @iv_metric_id
    INTO CORRESPONDING FIELDS OF TABLE
      @rt_values.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        TYPE 'E'
        NUMBER 003
        WITH iv_metric_id
        '/GICOM/METRIC_VL'.
    ENDIF.

  ENDMETHOD.

  METHOD /gicom/if_dso_metric~get_metric_labels_by_id.

    SELECT
      id,
      name,
      value
    FROM
      /gicom/metric_lb
    WHERE
      id = @iv_metric_id
    INTO CORRESPONDING FIELDS OF TABLE
      @rt_labels.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /gicom/cx_internal_error
        MESSAGE ID '/GICOM/MSG_BASIS_DS'
        TYPE 'E'
        NUMBER 003
        WITH iv_metric_id
        '/GICOM/METRIC_LB'.
    ENDIF.

  ENDMETHOD.

  METHOD get_next_metric_id.

    IF ev_next_id IS SUPPLIED.

      /gicom/cl_number_range_objects=>get_next_number(
        EXPORTING
          iv_proc_snro   = /gicom/cl_number_range_objects=>cv_metric_id
        IMPORTING
          ev_next_number = ev_next_id
      ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
