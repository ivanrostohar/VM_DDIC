@AbapCatalog.sqlViewName: '/GICOM/VCNDTYPFD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Condition Type View'
define view /GICOM/P_COND_TYPE_FDN as select from /gicom/tcnd_typ as cnd_type 
  // titles
  left outer join /gicom/tcnd_typt as cnd_type_txt on
    cnd_type_txt.type    = cnd_type.type and
    cnd_type_txt.langu = $session.system_language
    
  left outer join /gicom/tcnd_typt as cnd_type_txt_eng on
    cnd_type_txt_eng.type    = cnd_type.type and
    cnd_type_txt_eng.langu = 'E'
{
  key cnd_type.type,
  cnd_type.valid_from,
  cnd_type.valid_to,
  cnd_type.class,
  cnd_type.calc_type,
  cnd_type.scale_type,
  cnd_type.scale_base,
  cnd_type.allow_scale,
  cnd_type.allow_prepay,
  cnd_type.allow_verbal,
  cnd_type.allow_internal_processing,
  cnd_type.created_by,
  cnd_type.created_on,
  cnd_type.last_changed_by,
  cnd_type.last_changed_on,
  cnd_type.value_min,
  cnd_type.value_max,
  cnd_type.ccs_contract_type,
  cnd_type.ccs_appl,
  cnd_type.ccs_condition_type,
  cnd_type.allow_accrual,
  cnd_type.ccs_accr_cnd_type,
  cnd_type.curr_type,
  cnd_type.scale_index_basis,
  cnd_type.scale_logic,
  cnd_type.grant_date,
  cnd_type.purpose,
  cnd_type.reference_base,
  cnd_type.distribution_type,
  cnd_type.value_simulation,
  cnd_type.x_surcharge,
  cnd_type.distribution_method,
  cnd_type.x_change_scale_base,
  cnd_type.x_change_scale_logic,
  cnd_type.x_change_scale_index_base,
  cnd_type.claim_base,
  cnd_type.x_retrieval,
  cnd_type.x_pmr_relevant,
  cnd_type.x_allow_service_type,
  coalesce( cnd_type_txt.title, cnd_type_txt_eng.title ) as title
}
