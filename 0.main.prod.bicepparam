using './0.Main.bicep'

var prefix = loadJsonContent('sharedvariables.json')

param pEnv = 'prod'
param pAppServicePlan = '${prefix.projectnameprefix}-${pEnv}-${prefix.regionprefix}-${prefix.appserviceplanprefix}1'
param pWebAppName = '${prefix.projectnameprefix}-${pEnv}-${prefix.regionprefix}-${prefix.appserviceprefix}2'
param pAppInsightsName = '${prefix.projectnameprefix}-${pEnv}-${prefix.regionprefix}-${prefix.appinsightprefix}'
param pSqlServerName = '${prefix.projectnameprefix}-${pEnv}-${prefix.regionprefix}-${prefix.sqlserverprefix}'
param pSqlDatabaseName = '${prefix.projectnameprefix}-${pEnv}-${prefix.regionprefix}-${prefix.sqldatabaseprefix}1'
param pAdminstratorLogin = 'sqladminuser'

