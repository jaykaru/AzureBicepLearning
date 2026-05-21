param pLocation string = resourceGroup().location
param pAppServicePlanName string = 'az-bicep-dev-fc-appserviceplan'
param pLogicAppName string = 'az-bicep-dev-fc-logicapp-standard'
param pAppInsightsName string = 'az-bicep-dev-fc-appinsights'
param pStorangeAccountName string = 'azbicepdevfcstorage'
param pFileShare string = 'logicappfileshare'
// param pWorkspaceName string = 'az-bicep-dev-fc-logicapp-standard-law'

module storageAccount_module '5.StorageAccount.bicep' = {
  name: 'storageAccount_module'
  params: {
    pStorageAccountName: pStorangeAccountName // You can customize the storage account name as needed.
    pLocation: pLocation
    pFileShareName: pFileShare // You can customize the file share name as needed.
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: pStorangeAccountName
}
resource LogicApp_Standard 'Microsoft.Web/sites@2021-02-01' = {
  name: pLogicAppName
  location: pLocation
  kind: 'functionapp,linux,workflowapp' // The 'functionapp' kind is required for Logic Apps Standard, and 'workflowapp' is used to indicate that this is a Logic App.
  properties: {
    serverFarmId: AppServicePlan_module.outputs.appServicePlanId // The App Service Plan must have the same name as the Logic App for Logic Apps Standard.
    siteConfig: {
      netFrameworkVersion: 'v4.0' // Logic Apps Standard requires .NET Framework 4.0 or higher.
      functionsRuntimeScaleMonitoringEnabled: false // Disable scale monitoring for Logic Apps Standard.
    }
  }
  dependsOn: [
    appinsights_module
    storageAccount_module
  ]
}

resource loganalytics_workspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: '${pLogicAppName}-law'
  location: pLocation
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource logicapps_diagsettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${pLogicAppName}-diagsettings'
  scope: LogicApp_Standard // resource symbolic name of the Logic App Standard resource
  properties: {
    // workspaceId: resourceId('Microsoft.OperationalInsights/workspaces/', pWorkspaceName) // Connect the diagnostic settings to the Log Analytics workspace created in this Bicep file.
    workspaceId: loganalytics_workspace.id // Connect the diagnostic settings to the Log Analytics workspace created in this Bicep file.
    logs: [
    {
      categoryGroup: 'allLogs'
      enabled: true
    }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
  
}


module AppServicePlan_module 'AppServicePlan-Linux.bicep' = {
  name: 'AppServicePlan'
  params: {
    pAppservicePlanName: pAppServicePlanName // The App Service Plan must have the same name as the Logic App for Logic Apps Standard.
    pLocation: pLocation
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
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING: 'DefaultEndpointsProtocol=https;AccountName=${pStorangeAccountName};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=core.windows.net' // This app setting is used to connect your Logic App Standard to the storage account created in the storageAccount_module. 
    WEBSITE_CONTENTSHARE: pFileShare // This app setting is used to specify the name of the file share that will be used by your Logic App Standard to store its content. You can customize the name as needed.
  }
}
