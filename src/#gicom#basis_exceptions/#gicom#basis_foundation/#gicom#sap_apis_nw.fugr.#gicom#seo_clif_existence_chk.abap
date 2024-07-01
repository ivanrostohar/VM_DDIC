FUNCTION /gicom/seo_clif_existence_chk .
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CIFKEY) LIKE  SEOCLSKEY STRUCTURE  SEOCLSKEY
*"     VALUE(IV_BYPASSING_BUFFER) TYPE  SEOX_BOOLEAN
*"         DEFAULT SEOX_FALSE
*"  EXPORTING
*"     REFERENCE(EV_CLSTYPE) TYPE  SEOCLSTYPE
*"  EXCEPTIONS
*"      NOT_SPECIFIED
*"      NOT_EXISTING
*"--------------------------------------------------------------------

  CALL FUNCTION 'SEO_CLIF_EXISTENCE_CHECK'
    EXPORTING
      cifkey           = iv_cifkey
      bypassing_buffer = iv_bypassing_buffer
    IMPORTING
      clstype          = ev_clstype
    EXCEPTIONS
      not_specified    = 1
      not_existing     = 2
      OTHERS           = 3.

  IF sy-subrc <> 0.
* Implement suitable error handling here

    CASE sy-subrc.

      WHEN 1.
        RAISE not_specified.

      WHEN 2.
        RAISE not_existing.

    ENDCASE.

  ENDIF.

ENDFUNCTION.
