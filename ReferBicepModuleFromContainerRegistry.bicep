param pAppServicePlan string = 'az-bicep-dev-fc-asp'
param pAppservice string = 'az-bicep-dev-fc-wapp'
param pSKUCapacity int = 1
param pSKUName string = 'S1'
param pEnv string = 'dev'
param pInstrumentationKey string = ''



module appServiceModule 'br:azurebicepmodulescr1.azurecr.io/2.appserviceplan:v1' = {
  params: {
    pAppServicePlan: pAppServicePlan
    pWebAppName: pAppservice
    pSKUCapacity: pSKUCapacity
    pSKUName: pSKUName
    pEnv: pEnv
    pInstrumentationKey: pInstrumentationKey
  }
}



