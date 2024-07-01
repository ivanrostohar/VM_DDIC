CLASS /gicom/cl_auth_rfc_da DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-DATA:
      gv_auth_object TYPE xuobject VALUE '/GICOM/RFC',
      BEGIN OF gs_auth_fields,
        actvt TYPE fieldname VALUE 'ACTVT', "Please do not use constants from cl_authcheck -> wrong software component
        rfo   TYPE fieldname VALUE '/GICOM/RFO',
      END OF gs_auth_fields.

    CLASS-METHODS:
      class_constructor,
      authority_check
        IMPORTING
          !iv_rfc_object TYPE /gicom/rfc_object_id
        EXPORTING
          !ev_authorized TYPE /gicom/abap_bool
        RAISING
          /gicom/cx_no_auth_rfc.

ENDCLASS.



CLASS /GICOM/CL_AUTH_RFC_DA IMPLEMENTATION.


  METHOD authority_check.

    DATA(lv_user) = /gicom/cl_system=>get_username( ).

    TEST-SEAM authcheck.
      AUTHORITY-CHECK OBJECT gv_auth_object FOR USER lv_user
        ID gs_auth_fields-actvt    FIELD '16' "Please do not use constants from cl_authcheck -> wrong software component
        ID gs_auth_fields-rfo      FIELD iv_rfc_object.
    END-TEST-SEAM.

    IF sy-subrc = 0.
      ev_authorized = abap_true.
    ELSE.
      RAISE EXCEPTION NEW /gicom/cx_no_auth_rfc( ).
    ENDIF.

  ENDMETHOD.


  METHOD class_constructor.

    " Get parameter to allow old authorizations or not

    DATA(ls_tpara) = NEW /gicom/cl_dso_tpara( )->select_cust_for_para(
      /gicom/if_constants_tpara=>cv_allow_old_authorization
    ).

    IF ls_tpara IS NOT INITIAL AND
       ls_tpara-value = abap_true.

      gv_auth_object = 'ZGI_RFC_DA'.
      gs_auth_fields-rfo = 'ZGI_RFCOBJ'.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
