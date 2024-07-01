CLASS /gicom/cl_sap_user DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES /GICOM/IF_SAP_USER.
    ALIASES: bapi_user_get_detail FOR /gicom/if_sap_user~bapi_user_get_detail,
             bapi_user_existence_check FOR /gicom/if_sap_user~bapi_user_existence_check.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_SAP_USER IMPLEMENTATION.


  METHOD bapi_user_existence_check.

    CALL FUNCTION 'BAPI_USER_EXISTENCE_CHECK'
      EXPORTING
        username = iv_username
      IMPORTING
        return   = es_return.

  ENDMETHOD.


  METHOD bapi_user_get_detail.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username       = iv_username
        cache_results  = iv_cache_results
      IMPORTING
        logondata      = es_logondata
        defaults       = es_defaults
        address        = es_address
      TABLES
        return         = ct_return
        addsmtp        = ct_addsmtp.

  ENDMETHOD.
ENDCLASS.
