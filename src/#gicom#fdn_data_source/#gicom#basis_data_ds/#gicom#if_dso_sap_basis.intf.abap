INTERFACE /gicom/if_dso_sap_basis
  PUBLIC .

  INTERFACES if_badi_interface .

  METHODS get_status_of_sap_object
    IMPORTING
      iv_client            TYPE syst_mandt DEFAULT sy-mandt
    EXPORTING
      ev_fetch_numbers     TYPE syst_tabix
    CHANGING
      ct_sap_object        TYPE /gicom/sap_status_object_tt
      ct_sap_object_data   TYPE /gicom/sap_status_obj_data_tt
      ct_sap_object_status TYPE /gicom/sap_status_obj_stat_tt.

ENDINTERFACE.
