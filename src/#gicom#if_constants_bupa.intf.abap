INTERFACE /gicom/if_constants_bupa
  PUBLIC.

  CONSTANTS:
    cv_role_supplier       TYPE /gicom/bupa_internal_role VALUE 'SUPPLIER',
    cv_role_customer       TYPE /gicom/bupa_internal_role VALUE 'CUSTOMER',
    cv_role_contact_person TYPE /gicom/bupa_internal_role VALUE 'CONTACT',

    cv_transaction_partner TYPE /gicom/partner_category VALUE 'T',
    cv_contract_partner    TYPE /gicom/partner_category VALUE 'C',
    cv_settlement_partner  TYPE /gicom/partner_category VALUE 'S',

    cv_id_deleted_dummy    TYPE /gicom/bu_partner VALUE '@@@DELETED',

    BEGIN OF cs_msg_creation_not_allowed,
      id     TYPE msgid VALUE '/GICOM/MSG_FOUNDAT',
      number TYPE msgno VALUE 038,
    END OF cs_msg_creation_not_allowed,

    BEGIN OF cs_msg_changing_not_allowed,
      id     TYPE msgid VALUE '/GICOM/MSG_FOUNDAT',
      number TYPE msgno VALUE 039,
    END OF cs_msg_changing_not_allowed.

ENDINTERFACE.
