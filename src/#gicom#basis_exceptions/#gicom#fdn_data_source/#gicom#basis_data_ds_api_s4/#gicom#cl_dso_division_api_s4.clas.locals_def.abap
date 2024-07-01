*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

    TYPES: BEGIN OF tt_gicom_distchltxt,
             results TYPE TABLE OF /gicom/a_distributionchltxt WITH NON-UNIQUE DEFAULT KEY,
           END OF tt_gicom_distchltxt.

    TYPES: BEGIN OF ts_gicom_distchl.
        INCLUDE TYPE /gicom/a_distributionchannel.
    TYPES: to_description TYPE tt_gicom_distchltxt, "ToDo : check field name to_description
           END OF ts_gicom_distchl.

    TYPES: tt_gicom_distchl TYPE STANDARD TABLE OF ts_gicom_distchl WITH NON-UNIQUE DEFAULT KEY.
