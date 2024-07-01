INTERFACE /gicom/if_dso_urole
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_wl
    EXPORTING
      !et_usrole_wl TYPE /gicom/bafusrole_wl_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select
    IMPORTING
      !it_usrole     TYPE /gicom/afusrole_tt
      !iv_read_users TYPE char1
    EXPORTING
      !et_usr_doc    TYPE /gicom/usr_doc_tt
    RAISING
      /gicom/cx_not_found .
  METHODS db_update
    IMPORTING
      !iv_tabname TYPE tabname
      !it_insert  TYPE table
      !it_update  TYPE table
      !it_delete  TYPE table
    RAISING
      /gicom/cx_internal_error.

  METHODS select_users
    IMPORTING
      !is_usrole_data TYPE /gicom/tusrole_comm_s
    EXPORTING
      !et_user        TYPE /gicom/tbuser_db_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_usrole
    EXPORTING
      !et_usroles     TYPE /gicom/busrole_tt
      !et_usroles_txt TYPE /gicom/busrole_txt_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_user_by_role
    RETURNING
      VALUE(rt_userbyrole) TYPE /gicom/buser_by_role_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_uroles_by_usrnm
    IMPORTING
      !iv_usrnm   TYPE xubname
    EXPORTING
      !et_usroles TYPE /gicom/tbuser_db_tt .
  METHODS select_all
    IMPORTING
      !iv_user_role   TYPE /gicom/afusrole OPTIONAL
    EXPORTING
      !et_user        TYPE /gicom/tbuser_tt
      !et_user_perm   TYPE /gicom/tusrperm_tt
      !et_user_assign TYPE /gicom/tusrasgn_tt
    RAISING
      /gicom/cx_not_found .
  METHODS select_aon_rov
    RETURNING
      VALUE(rt_permissions) TYPE /gicom/user_perm_tt
    RAISING
      /gicom/cx_root_da .
   METHODS select_users_by_astusr
      IMPORTING
        it_role    TYPE /gicom/afusrole_tt
      RETURNING VALUE(rt_users) TYPE /GICOM/TBUSER_TT.
ENDINTERFACE.
