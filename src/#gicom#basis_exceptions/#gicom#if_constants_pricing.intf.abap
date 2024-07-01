INTERFACE /gicom/if_constants_pricing
  PUBLIC .


  CONSTANTS:
    BEGIN OF c_mode,
      sender   TYPE char1 VALUE 'L',   " Sender
      receiver TYPE char1 VALUE 'K',   " reciver
      all      TYPE char1 VALUE 'A',   " All
      operator TYPE char1 VALUE 'B',   " Operator
    END OF c_mode .
  CONSTANTS:
    BEGIN OF c_currency_base,
      local    TYPE char1 VALUE 'H',  " local currency
      document TYPE char1 VALUE 'U',  " document currency
      fixed    TYPE char1 VALUE 'F',  " fixed currency
    END OF c_currency_base .
  CONSTANTS:
    BEGIN OF c_pricing_mode,
      complete TYPE char1 VALUE 'C',   " complete pricing
      light    TYPE char1 VALUE 'L',   " light pricing
    END OF c_pricing_mode .
  CONSTANTS:
    BEGIN OF c_pricing_type,
      sender   TYPE char1 VALUE 'L',   " sender
      receiver TYPE char1 VALUE 'K', " receiver
    END OF c_pricing_type .
  CONSTANTS:
    BEGIN OF c_condition_type,
      gross_value TYPE char6 VALUE '0001',
    END OF c_condition_type .
  CONSTANTS:
    BEGIN OF c_rate_unit,
      percent TYPE waers VALUE '%',
    END OF c_rate_unit .
  CONSTANTS:
    BEGIN OF c_priority,
      additive TYPE /gicom/agr_priority VALUE '999',
    END OF c_priority .
  CONSTANTS:
    BEGIN OF c_calc_type,
      percent             TYPE /gicom/calc_type VALUE 'A',
      fixed               TYPE /gicom/calc_type VALUE 'B',
      quantity            TYPE /gicom/calc_type VALUE 'C',
      amount_per_document TYPE /gicom/calc_type VALUE 'X',
    END OF c_calc_type .
  CONSTANTS:
    BEGIN OF c_cond_class,
      discount  TYPE /gicom/cond_class VALUE 'A',
      price     TYPE /gicom/cond_class VALUE 'B',
      expense   TYPE /gicom/cond_class VALUE 'C',
      tax       TYPE /gicom/cond_class VALUE 'D',
      extra_pay TYPE /gicom/cond_class VALUE 'E',
    END OF c_cond_class .
  CONSTANTS:
    BEGIN OF c_int_proc_type,
      cond_share_sales TYPE /gicom/int_processing_type VALUE 'C',
    END OF c_int_proc_type .
  CONSTANTS gc_aplobj TYPE balobj_d VALUE '/GICOM/BASIS' ##NO_TEXT.
  CONSTANTS gc_subobj TYPE balsubobj VALUE '/GICOM/BASIS_PRICING' ##NO_TEXT.
  CONSTANTS gc_msg_class TYPE arbgb VALUE '/GICOM/ZK_PRICING' ##NO_TEXT.
ENDINTERFACE.
