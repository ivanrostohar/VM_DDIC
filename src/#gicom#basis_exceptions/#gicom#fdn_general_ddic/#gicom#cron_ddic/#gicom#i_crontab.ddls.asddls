@AbapCatalog.sqlViewName: '/GICOM/ICRONTAB'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View for Crontab'
define view /GICOM/I_CRONTAB as select from /gicom/crontab {
    application,
    application_type,
    application_key,
    minute_in_hour,
    hour_in_day,
    day_in_month,
    month_in_year,
    day_in_week,
    priority,
    data
}
