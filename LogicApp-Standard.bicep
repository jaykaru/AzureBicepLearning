param pLogicAppName string
param pLocation string
param pAppServicePlanId string
resource LogicApp_Standard 'Microsoft.Web/sites@2021-02-01' = {
  name: pLogicAppName
  location: pLocation
  kind: 'functionapp,workflowapp' // The 'functionapp' kind is required for Logic Apps Standard, and 'workflowapp' is used to indicate that this is a Logic App.
  properties:{
    serverFarmId: pAppServicePlanId // The App Service Plan must have the same name as the Logic App for Logic Apps Standard.
    siteConfig: {
      netFrameworkVersion: 'v4.0' // Logic Apps Standard requires .NET Framework 4.0 or higher.
      functionsRuntimeScaleMonitoringEnabled: false // Disable scale monitoring for Logic Apps Standard.
    }
  }
}
