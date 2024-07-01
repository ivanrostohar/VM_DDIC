*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

    TYPES: BEGIN OF tt_gicom_divisiontext,
             results TYPE TABLE OF /gicom/a_divisiontext WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_divisiontext.

    TYPES: BEGIN OF ts_gicom_division.
        INCLUDE TYPE /gicom/a_division.
    TYPES: to_description TYPE tt_gicom_divisiontext, "ToDo : check field name to_description
           END OF ts_gicom_division.

    TYPES: tt_gicom_division TYPE STANDARD TABLE OF ts_gicom_division WITH NON-UNIQUE DEFAULT KEY.
