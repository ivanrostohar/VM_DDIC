INTERFACE /gicom/if_constants_condtype
  PUBLIC .


  CONSTANTS:
    BEGIN OF c_scale_type,
      blank TYPE /gicom/scale_type VALUE ' ',
      from  TYPE /gicom/scale_type VALUE 'A',
      until TYPE /gicom/scale_type VALUE 'B',
    END OF c_scale_type.

  CONSTANTS:
    BEGIN OF c_scale_base,
      value               TYPE /gicom/scale_base VALUE 'B',
      quantity            TYPE /gicom/scale_base VALUE 'C',
      document_value      TYPE /gicom/scale_base VALUE 'X',
      document_quantity   TYPE /gicom/scale_base VALUE 'Y',
      variable            TYPE /gicom/scale_base VALUE 'V',
      order_quantity_unit TYPE /gicom/scale_base VALUE 'F',
    END OF c_scale_base.

  CONSTANTS:
    BEGIN OF c_scale_logic,
      absolute      TYPE /gicom/scale_logic VALUE 'A',
      increasing    TYPE /gicom/scale_logic VALUE 'B',
      interpolation TYPE /gicom/scale_logic VALUE 'C',
    END OF c_scale_logic.

  CONSTANTS:
    BEGIN OF c_curr_type,
      document TYPE /gicom/type_curr VALUE 'U',
      fix      TYPE /gicom/type_curr VALUE 'F',
      local    TYPE /gicom/type_curr VALUE 'H',
    END OF c_curr_type.

  CONSTANTS:
    BEGIN OF c_purpose,
      undefined     TYPE /gicom/purpose VALUE '  ',
      budget        TYPE /gicom/purpose VALUE 'BU',
      hedge         TYPE /gicom/purpose VALUE 'HG',
      price_delta   TYPE /gicom/purpose VALUE 'PD',
      other_effects TYPE /gicom/purpose VALUE 'OE',
    END OF c_purpose.

  CONSTANTS:
    BEGIN OF  c_distribution_type,
      turnover_related      TYPE /gicom/distribution_type VALUE 'A',
      distribution_key      TYPE /gicom/distribution_type VALUE 'B',
      manual                TYPE /gicom/distribution_type VALUE 'C',
      allocation_for_payout TYPE /gicom/distribution_type VALUE 'D',
      no                    TYPE /gicom/distribution_type VALUE '',
    END OF  c_distribution_type .

  CONSTANTS:
    BEGIN OF       c_grant_date,
      cash_discount         TYPE /gicom/grant_date VALUE 'A',
      subsequent_settlement TYPE /gicom/grant_date VALUE 'B',
      immediate_settlement  TYPE /gicom/grant_date VALUE 'C',
      undefined             TYPE /gicom/grant_date VALUE ' ',
    END OF      c_grant_date.

  CONSTANTS:
    BEGIN OF c_calculation_type,
      percentage          TYPE /gicom/calc_type VALUE 'A',
      fixed_amount        TYPE /gicom/calc_type VALUE 'B',
      amount_per_quantity TYPE /gicom/calc_type VALUE 'C',
      amount_per_document TYPE /gicom/calc_type VALUE 'X',
    END OF c_calculation_type.

  CONSTANTS:
    BEGIN OF c_class,
      discount_or_surcharge      TYPE /gicom/cond_class VALUE 'A',
      order_price                TYPE /gicom/cond_class VALUE 'B', " Bestell/Order Price
      tax                        TYPE /gicom/cond_class VALUE 'D', " Dax
      extra_pay                  TYPE /gicom/cond_class VALUE 'E',
      own_margin                 TYPE /gicom/cond_class VALUE 'F', " Fown margin
      negotiation_partner_margin TYPE /gicom/cond_class VALUE 'G', " Gegotiation partner margin
      cost                       TYPE /gicom/cond_class VALUE 'H', " Host
      delta                      TYPE /gicom/cond_class VALUE 'I', " Delta
      price                      TYPE /gicom/cond_class VALUE 'P', " Generic Price
    END OF c_class.

  CONSTANTS:
    BEGIN OF c_claim_base,
      event_related_service TYPE /gicom/claim_base VALUE 'E', "Event-Related Service
      goods_business        TYPE /gicom/claim_base VALUE 'G', "Goods Business
      time_related_service  TYPE /gicom/claim_base VALUE 'T', "Time-Related Service
      undefined             TYPE /gicom/claim_base VALUE '',  "undefined
    END OF c_claim_base.

  CONSTANTS:
    BEGIN OF c_process_type,
      distribution_key TYPE /gicom/process_type VALUE 'K',
      cause_related    TYPE /gicom/process_type VALUE 'C',
      normal           TYPE /gicom/process_type VALUE '',
    END OF c_process_type.

  CONSTANTS:
    BEGIN OF c_allow_prepay,
      yes      TYPE /gicom/allow_prepay VALUE 'Y',
      no       TYPE /gicom/allow_prepay VALUE 'N',
      optional TYPE /gicom/allow_prepay VALUE '',
    END OF c_allow_prepay.

  CONSTANTS:
    BEGIN OF c_allow_verbal,
      yes      TYPE /gicom/allow_verbal VALUE 'Y',
      no       TYPE /gicom/allow_verbal VALUE 'N',
      optional TYPE /gicom/allow_verbal VALUE '',
    END OF c_allow_verbal.

  CONSTANTS:
    BEGIN OF c_prepayment_type,
      no_prepayments  TYPE /gicom/prepayment_type VALUE '',
      only_fixvalues  TYPE /gicom/prepayment_type VALUE 'A',
      only_percentage TYPE /gicom/prepayment_type VALUE 'B',
      both            TYPE /gicom/prepayment_type VALUE 'C',
    END OF c_prepayment_type.

  CONSTANTS:
    BEGIN OF c_allow_scale,
      yes      TYPE /gicom/allow_scale VALUE 'Y',
      no       TYPE /gicom/allow_scale VALUE 'N',
      optional TYPE /gicom/allow_scale VALUE '',
    END OF c_allow_scale.

  CONSTANTS:
    BEGIN OF c_allow_internal_processing,
      yes      TYPE /gicom/allow_int_processing VALUE 'Y',
      no       TYPE /gicom/allow_int_processing VALUE 'N',
      optional TYPE /gicom/allow_int_processing VALUE '',
    END OF c_allow_internal_processing.

ENDINTERFACE.
