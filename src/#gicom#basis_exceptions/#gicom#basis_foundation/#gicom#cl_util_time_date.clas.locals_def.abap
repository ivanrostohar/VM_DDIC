
TYPES:

  BEGIN OF ts_time_to_date_cache,
    start_date TYPE /gicom/date,
    add_time   TYPE dec_25,
    add_type   TYPE /gicom/type_time_add,
    end_date   TYPE /gicom/date,
  END OF ts_time_to_date_cache,

  tt_time_to_date_cache TYPE SORTED TABLE OF ts_time_to_date_cache WITH UNIQUE KEY start_date add_time add_type.
