INTERFACE /gicom/if_constants_price_list
  PUBLIC .

  CONSTANTS:
    BEGIN OF c_excel_status,
      outdated VALUE '2',
      latest   VALUE '1',
    END OF c_excel_status.

ENDINTERFACE.
