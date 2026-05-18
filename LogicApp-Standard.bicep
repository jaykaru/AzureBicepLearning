param pLogicAppName string
param pLocation string
param pAppServicePlanId string
param pAppInsightsName string 
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

module appinsights_module '4.AppInsights.bicep' = {
  name: 'appinsights_module'
  params: {
   pAppInsightsName: pAppInsightsName
    pLocation: pLocation
 }
}

resource appsettings 'Microsoft.Web/sites/config@2021-02-01' = {
  name: 'appsettings'
  parent: LogicApp_Standard
  properties: {
    App_Kind: 'workflowapp' // This app setting is used to indicate that this is a Logic App Standard.
    APPINSIGHTS_INSTRUMENTATIONKEY: appinsights_module.outputs.oInstrumentationKey // You can add your Application Insights instrumentation key here if you want to enable monitoring for your Logic App Standard.
    FUNCTIONS_EXTENSION_VERSION: '~4' // Logic Apps Standard requires Azure Functions runtime version 3.x or higher.  
    FUNCTIONS_WORKER_RUNTIME: 'node' // You can specify the worker runtime for your Logic App Standard. In this example, we are using Node.js, but you can choose from other supported runtimes such as .NET, Python, etc.

  }
}
