INTERFACE /gicom/ix_http_exception
  PUBLIC.

  CONSTANTS:

    BEGIN OF cs_error_code,
      not_found                    TYPE /gicom/http_code VALUE '404',
      custom_error_with_auto_popup TYPE /gicom/http_code VALUE '499',
    END OF cs_error_code.

  METHODS get_http_code
    RETURNING
      VALUE(rv_error_code) TYPE /gicom/http_code.

  METHODS get_http_reason
    RETURNING
      VALUE(rv_code_reason) TYPE /gicom/http_reason.

ENDINTERFACE.
