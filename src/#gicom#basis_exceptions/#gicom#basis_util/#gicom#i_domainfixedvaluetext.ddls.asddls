@AbapCatalog.sqlViewName: '/GICOM/IDOMVTXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Texts for Domain Fixed Values'
define view /GICOM/I_DOMAINFIXEDVALUETEXT
  as select from
  dd07t
{
  key domname    as SAPDataDictionaryDomain,
  key domvalue_l as DomainValue,
      @Semantics.language: true
  key ddlanguage as Language,

      @Semantics.text: true
      ddtext     as DomainText
}
where
  as4local = 'A' and
  as4vers = '0000';
