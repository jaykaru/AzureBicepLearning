using './0.Main.bicep'

param pEnv = 'prod'
param pAppServicePlan = 'azbicep-prod-fc-asp1'
param pWebAppName = 'azbicep-prod-fc-webapp'
param pAppInsightsName = 'azbicep-prod-fc-webapp-ai'
param pSqlServerName = 'azbicep-prod-fc-sqlserver'
param pSqlDatabaseName = 'azbicep-prod-fc-database1'
param pAdminstratorLogin = 'sqladminuser'

