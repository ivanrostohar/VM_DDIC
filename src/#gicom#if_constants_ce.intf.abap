interface /GICOM/IF_CONSTANTS_CE
  public .


  constants:
    BEGIN OF gc_calc_mode,
      sender   TYPE /gicom/ce_mode VALUE 'S',   " Sender
      receiver TYPE /gicom/ce_mode VALUE 'R',   " receiver
      both     TYPE /gicom/ce_mode VALUE ' ',   " Both
    END OF gc_calc_mode .
  constants:
    BEGIN OF gc_currency_base,
      local    TYPE char1 VALUE 'H',  " local currency
      document TYPE char1 VALUE 'U',  " document currency
      fixed    TYPE char1 VALUE 'F',  " fixed currency
    END OF gc_currency_base .
  constants:
    BEGIN OF gc_rate_unit,
      percent TYPE waers VALUE '%',
    END OF gc_rate_unit .
  constants:
    BEGIN OF gc_priority,
      additive TYPE /gicom/hier_prio VALUE '99998',
      external TYPE /gicom/hier_prio VALUE '99999',
    END OF gc_priority .
  constants:
    BEGIN OF gc_calc_type,
      percent             TYPE /gicom/calc_type VALUE 'A',
      fixed               TYPE /gicom/calc_type VALUE 'B',
      quantity            TYPE /gicom/calc_type VALUE 'C',
      amount_per_document TYPE /gicom/calc_type VALUE 'X',
    END OF gc_calc_type .
  constants:
    BEGIN OF gc_cond_class,
      discount  TYPE /gicom/cond_class VALUE 'A',
      price     TYPE /gicom/cond_class VALUE 'B',
      expense   TYPE /gicom/cond_class VALUE 'C',
      tax       TYPE /gicom/cond_class VALUE 'D',
      extra_pay TYPE /gicom/cond_class VALUE 'E',
    END OF gc_cond_class .
  constants GC_APLOBJ type BALOBJ_D value '/GICOM/CE' ##NO_TEXT.
  constants GC_SUBOBJ type BALSUBOBJ value '/GICOM/CALCULATION' ##NO_TEXT.
  constants GC_MSG_CLASS type ARBGB value '/GICOM/ZK_PRICING' ##NO_TEXT.
  constants:
    BEGIN OF  gc_scope ,
      historical TYPE /gicom/calcscope VALUE '01',
      simulation TYPE /gicom/calcscope VALUE '02',

    END OF  gc_scope .
endinterface.
