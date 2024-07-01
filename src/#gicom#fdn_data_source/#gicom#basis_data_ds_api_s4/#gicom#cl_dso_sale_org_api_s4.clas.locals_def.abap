*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

    TYPES: BEGIN OF tt_gicom_salesorganizationtext,
             results TYPE TABLE OF /gicom/a_salesorganizationtext WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_salesorganizationtext.

    TYPES: BEGIN OF ts_gicom_salesorganization.
        INCLUDE TYPE /gicom/a_salesorganization.
    TYPES: to_description TYPE tt_gicom_salesorganizationtext, "ToDo : check field name to_description
           END OF ts_gicom_salesorganization.

    TYPES: tt_gicom_salesorganization TYPE STANDARD TABLE OF ts_gicom_salesorganization WITH NON-UNIQUE DEFAULT KEY.
