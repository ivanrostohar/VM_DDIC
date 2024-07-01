INTERFACE /gicom/if_dso_comments
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_comments
    IMPORTING
      !iv_bo_typ             TYPE /gicom/bo_typ
      !iv_bo_id              TYPE /gicom/bo_id
    RETURNING
      VALUE(rt_comments_doc) TYPE /gicom/comments_doc_a_tt
    RAISING
      /gicom/cx_root_ds.
  METHODS save_comments
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_root_ds.

ENDINTERFACE.
