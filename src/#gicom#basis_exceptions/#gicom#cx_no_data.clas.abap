  "! Request with wrong assumption. In case of a put request
  "! where intermediate a resource got changed by a third person.
CLASS /gicom/cx_no_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  INHERITING FROM /gicom/cx_root_ds.

  PUBLIC SECTION.

    METHODS
      constructor
        IMPORTING
          textid   LIKE textid OPTIONAL
          previous LIKE previous OPTIONAL.

  PRIVATE SECTION.

    CONSTANTS:
      co_code   TYPE /gicom/http_code VALUE '409',
      co_reason TYPE /gicom/http_reason VALUE 'No data'.

ENDCLASS.



CLASS /GICOM/CX_NO_DATA IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
        iv_code = /gicom/cx_no_data=>co_code
        iv_reason = /gicom/cx_no_data=>co_reason
        textid = textid
        previous = previous
    ).
  ENDMETHOD.
ENDCLASS.
