CLASS /gicom/cl_dso_material_api_s4 DEFINITION
  PUBLIC
  INHERITING FROM /gicom/cl_dso_material
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /gicom/if_dso_material~select
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS execute_material_read_request
      IMPORTING
        it_selopt          TYPE ddshselops OPTIONAL
      EXPORTING
        et_material        TYPE /gicom/material_a_tt
        et_material_txt    TYPE /gicom/material_txt_tt
        et_material_bo_rel TYPE /gicom/material_bo_rel_tt.
    METHODS map_material_api_gicom
      IMPORTING
        it_material_api    TYPE tt_gicom_material
      EXPORTING
        et_material        TYPE /gicom/material_a_tt
        et_material_txt    TYPE /gicom/material_txt_tt
        et_material_bo_rel TYPE /gicom/material_bo_rel_tt.
ENDCLASS.



CLASS /GICOM/CL_DSO_MATERIAL_API_S4 IMPLEMENTATION.


  METHOD /gicom/if_dso_material~select.
    me->execute_material_read_request(
*  EXPORTING
*    it_selopt          =
      IMPORTING
        et_material        = et_material
        et_material_txt    = et_material_txt
        et_material_bo_rel = et_material_bo_rel
    ).
  ENDMETHOD.


  METHOD execute_material_read_request.
    DATA: lt_material_api TYPE tt_gicom_material.

    DATA(lo_client) = /gicom/cl_odata_client_factory=>create( ).

    lo_client->execute(
    EXPORTING
    iv_rfc_object = /gicom/cl_rfc_manager=>cv_material
    iv_entity_set = 'A_Product'
*IV_ENTITY_ID =
    it_selopt     = it_selopt
    it_expand_clauses = VALUE #( ( `to_Description` ) )
    IMPORTING
    e_result  = lt_material_api
    ).

    me->map_material_api_gicom(
      EXPORTING
        it_material_api    = lt_material_api
      IMPORTING
        et_material        = et_material
        et_material_txt    = et_material_txt
        et_material_bo_rel = et_material_bo_rel
    ).

  ENDMETHOD.


  METHOD map_material_api_gicom.
    LOOP AT it_material_api ASSIGNING FIELD-SYMBOL(<ls_material_api>).
      APPEND INITIAL LINE TO et_material ASSIGNING FIELD-SYMBOL(<ls_material>).
      <ls_material>-matnr = <ls_material_api>-product.
*      <ls_material>-title = <ls_material_api>-.                        " not to be filled in DSO
      <ls_material>-matnr_old = <ls_material_api>-productoldid.
      <ls_material>-base_uom = <ls_material_api>-baseunit.
*      <ls_material>-uom = <ls_material_api>-.                          " ToDo : not supplied by view
*      <ls_material>-is_gen_mat = <ls_material_api>-.                   " ToDo : BFLME is not supplied by view yet
      <ls_material>-mfrnr = <ls_material_api>-manufacturernumber.       " ToDo : use BuPa-number when supplied by view -> use manufacturernumber for now
      <ls_material>-group = <ls_material_api>-productgroup.
*      <ls_material>-x_blocked = <ls_material_api>-.                    " ToDo
      <ls_material>-x_deleted = <ls_material_api>-ismarkedfordeletion.

      <ls_material>-activity_allowed = COND #( WHEN <ls_material_api>-ismarkedfordeletion = abap_true
                                                     THEN /gicom/if_const_record_status=>cv_activity_change_allowed
                                               ELSE /gicom/if_const_record_status=>cv_activity_all ).

      LOOP AT <ls_material_api>-to_description-results ASSIGNING FIELD-SYMBOL(<ls_description>).
        APPEND INITIAL LINE TO et_material_txt ASSIGNING FIELD-SYMBOL(<ls_material_txt>).
        <ls_material_txt>-matnr = <ls_description>-product.
        <ls_material_txt>-langu = <ls_description>-language.
        <ls_material_txt>-title = <ls_description>-productdescription.
      ENDLOOP.

      "ToDo : fill ET_MATERIAL_BO_REL
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
