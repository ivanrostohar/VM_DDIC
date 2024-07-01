INTERFACE /gicom/if_dso_metric
  PUBLIC .
  METHODS
    insert_metric
      IMPORTING
        is_metric    TYPE /gicom/metric_data_s
      EXPORTING
        ev_metric_id TYPE /gicom/metric_id
      RAISING
        /gicom/cx_root_ds.
  METHODS
    insert_metric_values
      IMPORTING
        it_values TYPE /gicom/metric_vl_tt
      RAISING
        /gicom/cx_root_ds.
  METHODS
    insert_metric_labels
      IMPORTING
        it_labels TYPE /GICOM/METRIC_lb_TT
      RAISING
        /gicom/cx_root_ds.
  METHODS
    delete_metric_by_id
      IMPORTING
        iv_metric_id TYPE /gicom/metric_id
      RAISING
        /gicom/cx_root_ds.
  METHODS
    delete_metric_values_by_id
      IMPORTING
        iv_metric_id TYPE /gicom/metric_id
      RAISING
        /gicom/cx_root_ds.
  METHODS
    delete_metric_labels_by_id
      IMPORTING
        iv_metric_id TYPE /gicom/metric_id
      RAISING
        /gicom/cx_root_ds.
  METHODS
    get_metric_data_by_id
      IMPORTING
        iv_metric_id     TYPE /gicom/metric_id
      RETURNING
        VALUE(rs_metric) TYPE /gicom/metric
      RAISING
        /gicom/cx_root_ds.
  METHODS
    get_metric_values_by_id
      IMPORTING
        iv_metric_id     TYPE /gicom/metric_id
      RETURNING
        VALUE(rt_values) TYPE /gicom/metric_vl_tt
      RAISING
        /gicom/cx_root_ds.
  METHODS
    get_metric_labels_by_id
      IMPORTING
        iv_metric_id     TYPE /gicom/metric_id
      RETURNING
        VALUE(rt_labels) TYPE /gicom/metric_lb_tt
      RAISING
        /gicom/cx_root_ds.

ENDINTERFACE.
