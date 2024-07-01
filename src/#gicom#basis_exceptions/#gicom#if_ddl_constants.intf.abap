interface /GICOM/IF_DDL_CONSTANTS
  public .


  constants:
    BEGIN OF gc_updkz,
      delete TYPE updkz_d VALUE 'D',
      insert TYPE updkz_d VALUE 'I',
      update TYPE updkz_d VALUE 'U',
    END OF gc_updkz .
  constants:
    BEGIN OF gc_mode,
      create  TYPE updkz_d VALUE 'H',
      change  TYPE updkz_d VALUE 'V',
      display TYPE updkz_d VALUE 'A',
    END OF gc_mode .
  constants:
    BEGIN OF gc_case,
      camel  TYPE char1 VALUE 'C',
      pascal TYPE char1 VALUE 'P',
    END OF gc_case .
  constants:
    BEGIN OF gc_msgty,
      abort   TYPE sy-msgty VALUE 'A',
      error   TYPE sy-msgty VALUE 'E',
      info    TYPE sy-msgty VALUE 'I',
      success TYPE sy-msgty VALUE 'S',
      warning TYPE sy-msgty VALUE 'W',
      stop    TYPE sy-msgty VALUE 'X',
    END OF gc_msgty .
  constants:
    BEGIN OF gc_action,
      check    TYPE char30 VALUE 'CHECK',
      create   TYPE char30 VALUE 'CREATE',
      delete   TYPE char30 VALUE 'DELETE',
      metadata TYPE char30 VALUE 'METADATA',
      read     TYPE char30 VALUE 'READ',
      read_wl  TYPE char30 VALUE 'READ_WL',
      save     TYPE char30 VALUE 'SAVE',
      clear    TYPE char30 VALUE 'CLEAR',
    END OF gc_action .
  constants:
    BEGIN OF gc_param_name,
      mode         TYPE char30 VALUE 'MODE',
      changed      TYPE char30 VALUE 'CHANGED',
      error        TYPE char30 VALUE 'ERROR',
      no_data      TYPE char30 VALUE 'NO_DATA_EXISTS',
      action       TYPE char30 VALUE 'ACTION',
      transports_k TYPE char30 VALUE 'TRANSPORTS_K',
      transports_w TYPE char30 VALUE 'TRANSPORTS_W',
    END OF gc_param_name .
  constants:
    BEGIN OF gc_tr_type,
      workbench           TYPE trfunction VALUE 'K',
      customizing         TYPE trfunction VALUE 'W',
      transport_of_copies TYPE trfunction VALUE 'T',
      dev_or_correction   TYPE trfunction VALUE 'S',
      repair              TYPE trfunction VALUE 'R',
      unclassified_task   TYPE trfunction VALUE 'X',
      customizing_task    TYPE trfunction VALUE 'Q',
    END OF gc_tr_type .
  constants:
    BEGIN OF gc_bo_type,
      approval_process    TYPE /gicom/bo_typ VALUE '/GICOM/BAF',
      template_definition TYPE /gicom/bo_typ VALUE '/GICOM/TMP',
      contract            TYPE /gicom/bo_typ VALUE '/GICOM/V02',
      agreement           TYPE /gicom/bo_typ VALUE '/GICOM/V06',
      negotiation_rounds  TYPE /gicom/bo_typ VALUE '/GICOM/V08',
      negotiations        TYPE /gicom/bo_typ VALUE '/GICOM/V09',
      designer            TYPE /gicom/bo_typ VALUE '/GICOM/DNR',
    END OF gc_bo_type .
  constants:
    BEGIN OF gc_package,
      local_object TYPE devclass VALUE '$TMP',
    END OF gc_package .
  constants:
    BEGIN OF gc_program_id,
      r3tr TYPE pgmid VALUE 'R3TR',
    END OF gc_program_id .
  constants CV_TR_OBJTYP_TABU type TROBJTYPE value 'TABU' ##NO_TEXT.
  constants CV_TR_OBJFUNC_K type CHAR1 value 'K' ##NO_TEXT.
endinterface.
