FUNCTION /GICOM/RFC_SEARCH_MATERIAL.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IV_NAME_1) TYPE  /GICOM/NAME OPTIONAL
*"     REFERENCE(IV_NAME_2) TYPE  /GICOM/NAME OPTIONAL
*"     REFERENCE(IV_PERSON) TYPE  BOOLEAN DEFAULT ABAP_UNDEFINED
*"  EXPORTING
*"     REFERENCE(ET_BUSINESSPARTNERS) TYPE  /GICOM/BUPA_A_TT
*"  RAISING
*"      /GICOM/CX_ROOT_DS
*"----------------------------------------------------------------------
*  DATA lb_bp TYPE REF TO /gicom/badi_ds_businesspartner.
*  GET BADI lb_bp.
*
*  CALL BADI lb_bp->search
*    EXPORTING
*      iv_name_1           = iv_name_1
*      iv_name_2           = iv_name_2
*      iv_person           = iv_person
*    RECEIVING
*      rt_businesspartners = et_businesspartners.

ENDFUNCTION.
