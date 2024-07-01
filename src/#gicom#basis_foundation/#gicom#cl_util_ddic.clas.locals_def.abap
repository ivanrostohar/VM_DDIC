*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section

TYPES: BEGIN OF domain_details_s,
         type_name       TYPE sobj_name,
         domain_detail_s TYPE x030l,
       END OF domain_details_s.

TYPES: domain_details_tt TYPE HASHED TABLE OF domain_details_s WITH UNIQUE KEY type_name.
