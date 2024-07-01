INTERFACE /gicom/if_dso_distr_channel
  PUBLIC .


  INTERFACES if_badi_interface .

  METHODS select_distr_channel
    EXPORTING
      !et_distr_chanl     TYPE /gicom/cdistr_channel_a_stt
      !et_distr_chanl_txt TYPE /gicom/cdist_channel_txt_a_stt .

  METHODS insert_distribution_channels
    IMPORTING
      it_distribution_channels_txt TYPE /gicom/_dis_ch_t_a_tt
      it_distribution_channels     TYPE /gicom/_dis_ch_a_tt
      iv_commit                    TYPE /gicom/abap_bool
    RAISING
      /gicom/cx_internal_error.

  METHODS delete_distribution_channels
    IMPORTING
      iv_commit TYPE /gicom/abap_bool.

  METHODS read_distribution_channels
    IMPORTING
      it_selopt                       TYPE ddshselops
    RETURNING
      VALUE(rt_distribution_channels) TYPE /gicom/_dis_ch_t_a_tt
    RAISING
      /gicom/cx_internal_error
      /gicom/cx_not_found.

ENDINTERFACE.
