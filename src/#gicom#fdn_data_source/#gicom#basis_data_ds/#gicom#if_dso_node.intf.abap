INTERFACE /gicom/if_dso_node
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select
    EXPORTING
      !es_node_doc TYPE /gicom/tcusnd_doc_a_s .
  METHODS save_data
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_internal_error .
  METHODS lock_node
    IMPORTING
      !is_key TYPE /gicom/tcusnd_key_s
    RAISING
      /gicom/cx_locked_data .
  METHODS unlock_node
    IMPORTING
      !is_key TYPE /gicom/tcusnd_key_s .
  METHODS get_node_relations
    RETURNING
      VALUE(rt_rls_notes) TYPE /gicom/tnode_rls_notes_a_tt .
ENDINTERFACE.
