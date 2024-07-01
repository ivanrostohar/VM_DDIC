INTERFACE /gicom/if_dso_paymterm
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_data
    EXPORTING
      !et_paymterm     TYPE /gicom/paymterm_tt
      !et_paymterm_txt TYPE /gicom/paymterm_txt_tt
    RAISING
      /gicom/cx_internal_error .

  METHODS insert_payment_terms
    IMPORTING
      it_payment_terms TYPE  /gicom/_paytrm_a_tt
      it_payment_terms_text TYPE  /gicom/_paytrm_t_a_tt
      iv_commit TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_payment_terms
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_payment_terms
    IMPORTING
       it_selopt            TYPE ddshselops OPTIONAL
    EXPORTING
      et_payment_terms      TYPE  /gicom/_paytrm_a_tt
      et_payment_terms_text TYPE  /gicom/_paytrm_t_a_tt
   RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.


ENDINTERFACE.
