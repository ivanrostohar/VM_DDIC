*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

**********************************************************************
* A_SUPPLIER
**********************************************************************
    TYPES: BEGIN OF tt_gicom_suppliercompany,
             results TYPE TABLE OF /gicom/a_suppliercompany WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_suppliercompany.

    TYPES: BEGIN OF tt_gicom_supplierpurchasingorg,
             results TYPE TABLE OF /gicom/a_supplierpurchasingorg WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_supplierpurchasingorg.

    TYPES: BEGIN OF ts_gicom_supplier.
        INCLUDE TYPE /gicom/a_supplier.
    TYPES: to_suppliercompany       TYPE tt_gicom_suppliercompany,
           to_supplierpurchasingorg TYPE tt_gicom_supplierpurchasingorg,
           END OF ts_gicom_supplier.

**********************************************************************
* A_CUSTOMER
**********************************************************************
    TYPES: BEGIN OF tt_gicom_customercompany,
             results TYPE TABLE OF /gicom/a_customercompany WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_customercompany.

    TYPES: BEGIN OF tt_gicom_customersalesarea,
             results TYPE TABLE OF /gicom/a_customersalesarea WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_customersalesarea.

    TYPES: BEGIN OF ts_gicom_customer.
        INCLUDE TYPE /gicom/a_customer.
    TYPES: to_customercompany   TYPE tt_gicom_customercompany,
           to_customersalesarea TYPE tt_gicom_customersalesarea,
           END OF ts_gicom_customer.

**********************************************************************
* A_BUSINESSPARTNERCONTACT
**********************************************************************
*    TYPES: BEGIN OF tt_gicom_businesspartnercontac,
*             results TYPE TABLE OF a_businesspartnercontact WITH NON-UNIQUE DEFAULT KEY,
*           END OF tt_gicom_businesspartnercontac.

**********************************************************************
* A_BUSINESSPARTNERROLE
**********************************************************************
    TYPES: BEGIN OF tt_gicom_businesspartnerrole,
             results TYPE TABLE OF /gicom/a_businesspartnerrole WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_businesspartnerrole.

**********************************************************************
* A_BUSINESSPARTNERADDRESS
**********************************************************************
    TYPES: BEGIN OF tt_gicom_emailaddress,
             results TYPE TABLE OF /gicom/a_addressemailaddress WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_emailaddress.
    TYPES: BEGIN OF tt_gicom_addressusage,
             results TYPE TABLE OF /gicom/a_bupaaddressusage WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_addressusage.

    TYPES: BEGIN OF ts_gicom_partneraddress.
        INCLUDE TYPE /gicom/a_businesspartneraddr.
    TYPES: to_emailaddress TYPE tt_gicom_emailaddress,
           to_addressusage TYPE tt_gicom_addressusage,
           END OF ts_gicom_partneraddress.
    TYPES: BEGIN OF tt_gicom_partneraddress,
             results TYPE TABLE OF ts_gicom_partneraddress WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_partneraddress.

**********************************************************************
* A_BUSINESSPARTNER
**********************************************************************
    TYPES: BEGIN OF ts_gicom_bp.
        INCLUDE TYPE /gicom/a_businesspartner.
    TYPES: to_supplier               TYPE ts_gicom_supplier,
           to_customer               TYPE ts_gicom_customer,
*           to_businesspartnercontact TYPE tt_gicom_businesspartnercontac,
           to_businesspartnerrole    TYPE tt_gicom_businesspartnerrole,
           to_businesspartneraddress TYPE tt_gicom_partneraddress,
           END OF ts_gicom_bp.

    TYPES: tt_gicom_bp TYPE STANDARD TABLE OF ts_gicom_bp WITH NON-UNIQUE DEFAULT KEY.
