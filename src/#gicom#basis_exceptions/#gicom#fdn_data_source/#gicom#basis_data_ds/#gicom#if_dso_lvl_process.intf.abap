INTERFACE /gicom/if_dso_lvl_process
  PUBLIC.

  INTERFACES if_badi_interface.


  METHODS select
    EXPORTING
      et_lvl_process     TYPE /gicom/lvl_process_tt
      et_lvl_process_txt TYPE /gicom/lvl_process_txt_tty .
  METHODS select_txt
    IMPORTING
      iv_lvl_process            TYPE /gicom/lvl_process OPTIONAL
      iv_lvl_process_txt        TYPE /gicom/lvl_process_txt OPTIONAL
    RETURNING
      VALUE(rt_lvl_process_txt) TYPE /gicom/lvl_process_txt_tty .


ENDINTERFACE.
