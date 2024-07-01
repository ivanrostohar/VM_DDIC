class /GICOM/CL_ODATA_CLIENT_FACTORY definition
  public
  create private .

public section.

  constants CV_PATH_ODATA_SAP type STRING value '/sap/opu/odata/sap' ##NO_TEXT.
  constants CV_PATH_API_BUSINESS_PARTNER type STRING value 'API_BUSINESS_PARTNER' ##NO_TEXT.
  constants CV_PATH_API_MATERIAL type STRING value 'API_PRODUCT_SRV' ##NO_TEXT.
  constants CV_PATH_API_COND_CNTR_TYPE type STRING value 'API_CONDITION_CONTRACT_TYPE' ##NO_TEXT.

  class-methods CREATE
    returning
      value(RO_CLIENT) type ref to /GICOM/CL_ODATA_CLIENT .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /GICOM/CL_ODATA_CLIENT_FACTORY IMPLEMENTATION.


  METHOD create.

    ro_client = NEW /gicom/cl_odata_client( ).

  ENDMETHOD.
ENDCLASS.
