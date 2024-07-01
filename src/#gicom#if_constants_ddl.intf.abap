INTERFACE /gicom/if_constants_ddl
  PUBLIC .


  CONSTANTS c_true TYPE xfeld VALUE 'X' ##NO_TEXT.
  CONSTANTS c_false TYPE xfeld VALUE space ##NO_TEXT.
  CONSTANTS:
    BEGIN OF c_updkz,
      insert TYPE char1 VALUE 'I',
      update TYPE char1 VALUE 'U',
      delete TYPE char1 VALUE 'D',
    END OF c_updkz .
  CONSTANTS:
    BEGIN OF c_mode,
      create  TYPE char1 VALUE 'H',
      display TYPE char1 VALUE 'A',
      change  TYPE char1 VALUE 'V',
    END OF c_mode .
  CONSTANTS:
    BEGIN OF c_message_type,
      error       TYPE char1 VALUE 'E',
      status      TYPE char1 VALUE 'S',
      information TYPE char1 VALUE 'I',
      abort       TYPE char1 VALUE 'A',
      warning     TYPE char1 VALUE 'W',
      exit        TYPE char1 VALUE 'X',
    END OF c_message_type .
  CONSTANTS:
    BEGIN OF c_case,
      camel  TYPE char1 VALUE 'C',
      pascal TYPE char1 VALUE 'P',
    END OF c_case .
  CONSTANTS:
    BEGIN OF c_action,
      check          TYPE char30 VALUE 'CHECK',
      create         TYPE char30 VALUE 'CREATE',
      delete         TYPE char30 VALUE 'DELETE',
      metadata       TYPE char30 VALUE 'METADATA',
      read           TYPE char30 VALUE 'READ',
      read_wl        TYPE char30 VALUE 'READ_WL',
      save           TYPE char30 VALUE 'SAVE',
      clear          TYPE char30 VALUE 'CLEAR',
      check_layout   TYPE char30 VALUE 'CHECK_LAYOUT',
      get_transports TYPE char30 VALUE 'GET_TRANSPORTS',
    END OF c_action .
  CONSTANTS:
    BEGIN OF c_param_name,
      mode           TYPE char30 VALUE 'MODE',
      changed        TYPE char30 VALUE 'CHANGED',
      error          TYPE char30 VALUE 'ERROR',
      no_data        TYPE char30 VALUE 'NO_DATA_EXISTS',
      action         TYPE char30 VALUE 'ACTION',
      transports_k   TYPE char30 VALUE 'TRANSPORTS_K',
      transports_w   TYPE char30 VALUE 'TRANSPORTS_W',
      layout         TYPE char30 VALUE 'LAYOUT',
      method_include TYPE char30 VALUE 'METHOD_INCLUDE',
    END OF c_param_name .
  CONSTANTS:
    BEGIN OF c_tr_type,
      workbench           TYPE trfunction VALUE 'K',
      customizing         TYPE trfunction VALUE 'W',
      transport_of_copies TYPE trfunction VALUE 'T',
      dev_or_correction   TYPE trfunction VALUE 'S',
      repair              TYPE trfunction VALUE 'R',
      unclassified_task   TYPE trfunction VALUE 'X',
      customizing_task    TYPE trfunction VALUE 'Q',
    END OF c_tr_type .
  CONSTANTS:
    BEGIN OF c_bo_type,
      approval_process    TYPE /gicom/bo_typ VALUE '/GICOM/BAF',
      template_definition TYPE /gicom/bo_typ VALUE '/GICOM/TMP',
      contract            TYPE /gicom/bo_typ VALUE '/GICOM/V02',
      negotiation_rounds  TYPE /gicom/bo_typ VALUE '/GICOM/V08',
      negotiations        TYPE /gicom/bo_typ VALUE '/GICOM/V09',
    END OF c_bo_type .
  CONSTANTS:
    BEGIN OF c_structure_group,
      key  TYPE ddgroup VALUE 'KEY',
      data TYPE ddgroup VALUE 'DATA',
    END OF c_structure_group.

  CONSTANTS:
    BEGIN OF c_document_type,
      main_document           TYPE /gicom/doctype VALUE '0A',
      attachment              TYPE /gicom/doctype VALUE '0B',
      description             TYPE /gicom/doctype VALUE '0C',
      certificate_of_approval TYPE /gicom/doctype VALUE '0D',
      contract_summary        TYPE /gicom/doctype VALUE '0E',
      ammendment              TYPE /gicom/doctype VALUE '0F',
      contract_template       TYPE /gicom/doctype VALUE '0G',
      guidelines              TYPE /gicom/doctype VALUE '0H',
    END OF c_document_type.

    CONSTANTS:
      BEGIN OF c_archive_type,
        sap_office   TYPE /gicom/archive_type VALUE '',
        archive_link TYPE /gicom/archive_type VALUE 'A',
      END OF c_archive_type.

    CONSTANTS:
      BEGIN OF c_encoding,
        base_64 TYPE /gicom/encoding VALUE '',
        binary  TYPE /gicom/encoding VALUE 'X',
      END OF c_encoding.

    CONSTANTS:
      BEGIN OF c_template_type,
        designer   TYPE char1 VALUE space,
        adobe_form TYPE char1 VALUE '1',
        smart_form TYPE char1 VALUE '2',
      END OF c_template_type.

ENDINTERFACE.
