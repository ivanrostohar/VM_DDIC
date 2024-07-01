CLASS /gicom/cl_dso_bupa_api_s4 DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cl_dso_businesspartner
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS /gicom/if_dso_businesspartner~search
        REDEFINITION .
    METHODS /gicom/if_dso_businesspartner~search_by_date
        REDEFINITION .
    METHODS /gicom/if_dso_businesspartner~select
        REDEFINITION .
    METHODS /gicom/if_dso_businesspartner~select_relations
        REDEFINITION .
    METHODS /gicom/if_dso_businesspartner~select_address
        REDEFINITION .


  PROTECTED SECTION.
  PRIVATE SECTION.



    METHODS execute_bupa_read_request
      IMPORTING
                it_selopt      TYPE ddshselops OPTIONAL
      RETURNING VALUE(rt_bupa) TYPE /gicom/bupa_a_tt.
    METHODS map_bupa_api_gicom
      IMPORTING
                it_bupa_api          TYPE tt_gicom_bp
      RETURNING VALUE(rt_bupa_gicom) TYPE /gicom/bupa_a_tt.
ENDCLASS.



CLASS /GICOM/CL_DSO_BUPA_API_S4 IMPLEMENTATION.


  METHOD /gicom/if_dso_businesspartner~search.
    rt_businesspartners = me->execute_bupa_read_request( )."it_selopt = lt_selopt ).
  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~search_by_date.
    rt_businesspartners = me->execute_bupa_read_request( )."it_selopt = lt_selopt ).
  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~select.
    rt_businesspartners = me->execute_bupa_read_request( )."it_selopt = lt_selopt ).
  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~select_relations.

    CLEAR: rt_relations.

    DATA: lt_results TYPE TABLE OF /gicom/a_businesspartnercont.


    DATA(lo_client) = /gicom/cl_odata_client_factory=>create( ).
    lo_client->execute(
      EXPORTING
       iv_rfc_object = /gicom/cl_rfc_manager=>cv_businesspartner
       iv_entity_set = 'A_BusinessPartnerContact'
*     iv_entity_id  =
*     it_selopt     =
*     it_expand_clauses =
      IMPORTING
       e_result  = lt_results
    ).


    LOOP AT lt_results ASSIGNING FIELD-SYMBOL(<ls_results>).

      APPEND INITIAL LINE TO rt_relations ASSIGNING FIELD-SYMBOL(<ls_relations>).
      <ls_relations>-partner1                  = <ls_results>-businesspartnercompany.
      <ls_relations>-partner2                  = <ls_results>-businesspartnerperson.
      <ls_relations>-relationshipcategory      = <ls_results>-relationshipcategory.
      <ls_relations>-validfromdate             = <ls_results>-validitystartdate.
      <ls_relations>-validuntildate            = <ls_results>-validityenddate.
      <ls_relations>-defaultrelationship       = <ls_results>-isstandardrelationship.
      <ls_relations>-relationshiptype          = <ls_results>-relationshipcategory.

    ENDLOOP.



  ENDMETHOD.


  METHOD execute_bupa_read_request.

    DATA: lt_bupa_api TYPE tt_gicom_bp.


    DATA(lo_client) = /gicom/cl_odata_client_factory=>create( ).
    lo_client->execute(
    EXPORTING
    iv_rfc_object = /gicom/cl_rfc_manager=>cv_businesspartner
    iv_entity_set = 'A_BusinessPartner'
*IV_ENTITY_ID =
    it_selopt     = it_selopt
    it_expand_clauses = VALUE #( ( `to_Supplier/to_SupplierCompany` )
                                 ( `to_Supplier/to_SupplierPurchasingOrg` )
                                 ( `to_Customer/to_CustomerCompany` )
                                 ( `to_Customer/to_CustomerSalesArea` )
*                               ( `to_BusinessPartnerContact` )
                                 ( `to_BusinessPartnerRole` )
                                 ( `to_BusinessPartnerAddress/to_EmailAddress` )
                                 ( `to_BusinessPartnerAddress/to_AddressUsage` )
                                )
    IMPORTING
    e_result  = lt_bupa_api
    ).

    rt_bupa = me->map_bupa_api_gicom( lt_bupa_api ).

  ENDMETHOD.


  METHOD map_bupa_api_gicom.
    CLEAR: rt_bupa_gicom.

    LOOP AT it_bupa_api ASSIGNING FIELD-SYMBOL(<ls_bupa_api>).
      APPEND INITIAL LINE TO rt_bupa_gicom ASSIGNING FIELD-SYMBOL(<ls_bupa_gicom>).
      <ls_bupa_gicom>-bu_partner      = <ls_bupa_api>-businesspartner.
      <ls_bupa_gicom>-type            =  'BUS1006'.     " I am a S/4 business partner

      " Fill the name fields correctly, depending on BUPA type
      IF <ls_bupa_api>-isnaturalperson EQ 'X'.
        <ls_bupa_gicom>-name_1          = <ls_bupa_api>-firstname.
        <ls_bupa_gicom>-name_2          = <ls_bupa_api>-lastname.
        "<ls_bupa_gicom>-name_3          = <ls_bupa_api>-
        "<ls_bupa_gicom>-name_4          = <ls_bupa_api>-
      ELSE.
        <ls_bupa_gicom>-name_1          = <ls_bupa_api>-organizationbpname1.
        <ls_bupa_gicom>-name_2          = <ls_bupa_api>-organizationbpname2.
        <ls_bupa_gicom>-name_3          = <ls_bupa_api>-organizationbpname3.
        <ls_bupa_gicom>-name_4          = <ls_bupa_api>-organizationbpname4.
      ENDIF.



      DATA: lv_default TYPE /gicom/abap_bool.
      FIELD-SYMBOLS: <ls_emailaddress> TYPE /gicom/a_addressemailaddress.
      CLEAR: lv_default.

      LOOP AT <ls_bupa_api>-to_businesspartneraddress-results ASSIGNING FIELD-SYMBOL(<ls_businesspartneraddress>).
        LOOP AT <ls_businesspartneraddress>-to_addressusage-results ASSIGNING FIELD-SYMBOL(<ls_addressusage>) WHERE addressusage EQ 'XXDEFAULT'
                                                                                                                AND validitystartdate LE /gicom/cl_system=>get_time_stamp( )
                                                                                                                AND validityenddate  GE /gicom/cl_system=>get_time_stamp( ).
          lv_default = abap_true.
        ENDLOOP.

        IF lv_default EQ abap_true.

          <ls_bupa_gicom>-country                   = <ls_businesspartneraddress>-country.
          <ls_bupa_gicom>-region                    = <ls_businesspartneraddress>-region.

          UNASSIGN <ls_emailaddress>.
          ASSIGN <ls_businesspartneraddress>-to_emailaddress-results[ isdefaultemailaddress = 'X' ] TO <ls_emailaddress>.
          IF <ls_emailaddress> IS ASSIGNED.
            <ls_bupa_gicom>-email                     = <ls_emailaddress>-emailaddress.
          ENDIF.

          EXIT.
        ENDIF.

      ENDLOOP.



      <ls_bupa_gicom>-supplier_number           = <ls_bupa_api>-supplier.
      <ls_bupa_gicom>-customer_number           = <ls_bupa_api>-customer.


      "<ls_bupa_gicom>-x_manufacturer
      "<ls_bupa_gicom>-x_distributor



      " Deletion and blocked flags
      <ls_bupa_gicom>-x_blocked          = <ls_bupa_api>-businesspartnerisblocked.
      <ls_bupa_gicom>-x_deleted          = <ls_bupa_api>-ismarkedforarchiving.
*      <ls_bupa_gicom>-x_purpose_complete = <ls_bupa_api>-isbusinesspurposecompleted.        "not exposed in A view

      " Check flags to determine access level
      <ls_bupa_gicom>-activity_allowed = me->map_activity_bupa( <ls_bupa_gicom> ).


      " Move the BUPA roles to the business partner
      <ls_bupa_gicom>-roles = VALUE #( FOR <ls_> IN <ls_bupa_api>-to_businesspartnerrole-results (
          role       = <ls_>-businesspartnerrole
          valid_from = CONV #( CONV string( <ls_>-validfrom ) )
          valid_to   = CONV #( CONV string( <ls_>-validto ) )
      ) ).


      IF  <ls_bupa_api>-supplier IS NOT INITIAL.
        LOOP AT <ls_bupa_api>-to_supplier-to_suppliercompany-results ASSIGNING FIELD-SYMBOL(<ls_suppliercompany>).
          APPEND VALUE #(
            role               = /gicom/if_constants_bupa=>cv_role_supplier
            bo_typ             = /gicom/if_constants_bo=>cv_bo_cocode
            bo_id              = <ls_suppliercompany>-companycode
            x_blocked = <ls_suppliercompany>-supplierisblockedforposting
            x_deleted = <ls_suppliercompany>-deletionindicator
            "x_purpose_complete  = <ls_suppliercompany>-IsBusinessPurposeCompleted     "not exposed in A view
            ) TO <ls_bupa_gicom>-relationships ASSIGNING FIELD-SYMBOL(<ls_relation>).

          <ls_relation>-activity_allowed =  me->map_activity_relation( <ls_relation> ).
        ENDLOOP.

        LOOP AT <ls_bupa_api>-to_supplier-to_supplierpurchasingorg-results ASSIGNING FIELD-SYMBOL(<ls_supplierpurchasingorg>).
          DATA(lv_group) = /gicom/cl_util_guid=>get_guid_32( ). "INS SO 20190528 M.17466
          APPEND VALUE #(
                 role               = /gicom/if_constants_bupa=>cv_role_supplier
                 bo_typ             = /gicom/if_constants_bo=>cv_bo_purch_org
                 bo_id              = <ls_supplierpurchasingorg>-purchasingorganization "purchasinggroup "MOD SO M.17466
                 group              = lv_group  "INS SO 20190528 M.17466
                 x_blocked = <ls_supplierpurchasingorg>-purchasingisblockedforsupplier
                 x_deleted = <ls_supplierpurchasingorg>-deletionindicator
                 "x_purpose_complete  = <ls_supplierpurchasingorg>-     "not available at supplier purch.org (LFM1)
               ) TO <ls_bupa_gicom>-relationships ASSIGNING <ls_relation>.

          <ls_relation>-activity_allowed =  me->map_activity_relation( <ls_relation> ).
*        "ENDLOOP. "DEL SO 20190528
*
         "INS SO 20190528 M.17466 Begin
         IF <ls_supplierpurchasingorg>-purchasinggroup IS NOT INITIAL.
           APPEND VALUE #(
                   role               = /gicom/if_constants_bupa=>cv_role_supplier
                   bo_typ             = /gicom/if_constants_bo=>cv_bo_purch_grp
                   bo_id              = <ls_supplierpurchasingorg>-purchasinggroup
                   group              = lv_group
                   x_blocked = <ls_supplierpurchasingorg>-purchasingisblockedforsupplier
                   x_deleted = <ls_supplierpurchasingorg>-deletionindicator
                  ) TO <ls_bupa_gicom>-relationships ASSIGNING <ls_relation>.

            <ls_relation>-activity_allowed =  me->map_activity_relation( <ls_relation> ).
          ENDIF.
        ENDLOOP.
        "INS SO 20190528 M.17466  End
      ENDIF.

      IF  <ls_bupa_api>-customer IS NOT INITIAL.
        " Read the company codes
        LOOP AT <ls_bupa_api>-to_customer-to_customercompany-results ASSIGNING FIELD-SYMBOL(<ls_customercompany>).
          APPEND VALUE #(
            role             = /gicom/if_constants_bupa=>cv_role_customer
            bo_typ           = /gicom/if_constants_bo=>cv_bo_cocode
            bo_id            = <ls_customercompany>-companycode
            x_blocked        = <ls_customercompany>-physicalinventoryblockind
            x_deleted        = <ls_customercompany>-deletionindicator
            "x_purpose_complete  = <ls_customercompany>-IsBusinessPurposeCompleted     "not exposed in A view
        ) TO <ls_bupa_gicom>-relationships ASSIGNING <ls_relation>.

          <ls_relation>-activity_allowed =  me->map_activity_relation( <ls_relation> ).
        ENDLOOP.

        " Read sales orgs
        LOOP AT <ls_bupa_api>-to_customer-to_customersalesarea-results ASSIGNING FIELD-SYMBOL(<ls_customersalesarea>).
          " This is a combined key of sales org, dist channel and division, so we need a group id
          lv_group = /gicom/cl_util_guid=>get_guid_32( ). "MOD SO 20190528 M.17466

          APPEND VALUE #(
            role             = /gicom/if_constants_bupa=>cv_role_customer
            bo_typ           = /gicom/if_constants_bo=>cv_bo_sales_org
            bo_id            = <ls_customersalesarea>-salesorganization
            group            =  lv_group
            x_blocked        = <ls_customersalesarea>-deliveryisblockedforcustomer
            x_deleted        = <ls_customersalesarea>-deletionindicator
            "x_purpose_complete  = <ls_customersalesarea>-IsBusinessPurposeCompleted     "not exposed in A view
          ) TO <ls_bupa_gicom>-relationships ASSIGNING <ls_relation>.

          <ls_relation>-activity_allowed =  me->map_activity_relation( <ls_relation> ).


          APPEND VALUE #(
            role             = /gicom/if_constants_bupa=>cv_role_customer
            bo_typ           = /gicom/if_constants_bo=>cv_bo_distribution_channel
            bo_id            = <ls_customersalesarea>-distributionchannel
            group            = lv_group
            x_blocked        = <ls_customersalesarea>-deliveryisblockedforcustomer
            x_deleted        = <ls_customersalesarea>-deletionindicator
            "x_purpose_complete  = <ls_customersalesarea>-IsBusinessPurposeCompleted     "not exposed in A view
           ) TO <ls_bupa_gicom>-relationships ASSIGNING <ls_relation>.

          <ls_relation>-activity_allowed =  me->map_activity_relation( <ls_relation> ).


          APPEND VALUE #(
            role             = /gicom/if_constants_bupa=>cv_role_customer
            bo_typ           = /gicom/if_constants_bo=>cv_bo_division
            bo_id            = <ls_customersalesarea>-division
            group            = lv_group
            x_blocked        = <ls_customersalesarea>-deliveryisblockedforcustomer
            x_deleted        = <ls_customersalesarea>-deletionindicator
            "x_purpose_complete  = <ls_customersalesarea>-IsBusinessPurposeCompleted     "not exposed in A view
           ) TO <ls_bupa_gicom>-relationships ASSIGNING <ls_relation>.

          <ls_relation>-activity_allowed =  me->map_activity_relation( <ls_relation> ).

        ENDLOOP.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.


  METHOD /gicom/if_dso_businesspartner~select_address.

  ENDMETHOD.
ENDCLASS.
