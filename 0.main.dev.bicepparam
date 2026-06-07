using './0.Main.bicep' 

var prefix = loadJsonContent('sharedvariables.json')

param pEnv = 'dev'
param pAppServicePlan = '${prefix.projectnameprefix}-${prefix.envprefix}-${prefix.regionprefix}-${prefix.appserviceplanprefix}1'
param pWebAppName = '${prefix.projectnameprefix}-${prefix.envprefix}-${prefix.regionprefix}-${prefix.appserviceprefix}2'
param pAppInsightsName = '${prefix.projectnameprefix}-${prefix.envprefix}-${prefix.regionprefix}-${prefix.appinsightprefix}'
param pSqlServerName = '${prefix.projectnameprefix}-${prefix.envprefix}-${prefix.regionprefix}-${prefix.sqlserverprefix}'
param pSqlDatabaseName = '${prefix.projectnameprefix}-${prefix.envprefix}-${prefix.regionprefix}-${prefix.sqldatabaseprefix}1'
param pAdminstratorLogin = 'sqladminuser'

