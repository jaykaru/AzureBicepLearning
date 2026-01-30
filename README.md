# AzureBicepLearning
# Section 1:
# Azure Resource Group Overview

## What is a Resource Group?
A **Resource Group** in Azure is used to group related resources together
Every resource created in Azure must belong to a resource group.
The resource group is created using a **Bicep template**
- **Scope**: Resource groups exist at the **subscription level**.
- **Region**: This resource group is created in the **France Central** region.
- **Naming Convention**:  `<Name>-<env>-<region>-<type>`

---
## App Service plan
An **App service plan** provides the computer resources for hosting Web Apps which is fully managed by Microsoft. Every Azure App Service must run inside an App Service Plan. Multiple app share the same plan.

---

## Azure App Service
An **Azure App Service** is a PaaS that lets to host web applications without managing infrastructure.
The App Service run on the created  **App Service Plan**. This will be used to host a .NET application.
App Service requires App service plan for alloaction computer resources.

---

## Application Insights
An **Application Insights** is used for realtime-monitoring Azure web Application. It is linked to App Service using APPINSIGHT_INSTRUMENTATIONKEY in app settings. It is deployed in the same region as App Service. App Insight Live Metricks will show real time telmetric data.

---

# Section 2:

# Hello World .NET Core App on Azure App Service with Application Insights

## Overview
This project demonstrates hosting a **Hello World ASP.NET Core application** on **Azure App Service** with an **App Service Plan** and enabling **Application Insights** for performance monitoring and telemetry.

---
## Architecture
- **App Service Plan**: Provides the hosting environment for the App Service.
- **App Service**: Runs the .NET Core application.
- **Application Insights**: Monitors application performance, tracks user flows, and sends alerts for failures or performance deviations.
- **App Settings**: Stores the **Instrumentation Key** to connect the App Service with Application Insights.

---
## Features
- **Application Performance Monitoring**:
  - Detects application failures.
  - Tracks user flows and usage patterns.
  - Monitors performance metrics (response times, dependencies).
  - Sends notifications when performance deviates from thresholds.
- **Live Metrics**:
  - View real-time telemetry in Application Insights.

---

## Configuration Steps
1. **Create App Service Plan**  
   Defines the compute resources for hosting the App Service.

2. **Create App Service**  
   Deploy the Hello World .NET Core application.

3. **Enable Application Insights**  
   - Create an Application Insights resource in Azure.
   - Copy the **Instrumentation Key** or **Connection String**.

4. **Connect App Service to Application Insights**  
   - Add the Instrumentation Key in **App Settings** of the App Service.
   - Enable Application Insights in the App Service configuration.
   - Select the application language (**.NET Core**).

5. **Verify Telemetry**  
   - Navigate to Application Insights in Azure Portal.
   - Check **Live Metrics**, **Failures**, and **Performance** dashboards.

---

## How It Works
- The App Service sends telemetry data (requests, exceptions, performance metrics) to Application Insights using the Instrumentation Key.
- Application Insights processes and visualizes the data, enabling proactive monitoring and alerting.

---

# Section 3:
**SqlServer** and **SqlDatabase** resource created using Bicep. **KeyVault** resource created in a separate common resource group using Azure portal and secret created to store database password.
Database access the password using **getSecret()**, which call the secret and reads the password to login to the database.
**SQLServer Firewall Rules** used to whitelist the IP address inorder to restrict unauthorised access to database SqlServer.

In order for ARM to read the secret from Key Vault, KeyVault Access Policy was used with Azure Resource Manager for template deployment. In this option ARM can read the secret from key vault. RBAC is failing to get secret eventhough Rolebase Access permission is given to Key Vault Admin role.

---
# Section 4:

**Module** Bicep created to call all child modules. Created module for each of the resource which calls the child module and deploy the resources in Azure.

---

# Section 5:

Parameters created using key word **param** to store the values and refer the name in the resources created.

In order to deploy **Multiple Environment**, Created Dev,Stage,Prod resourcegroups using Bicep template at france-central location at subscription level and have created dev,stage & prod parameters json files which contains parameter values for Appserviceplan, Appservice, AppInsight, SqlServerName, DatabaseName & AdminLogin.

---

# Section 6:

**Parameter Dectorators**
In order to restrict parameter values we use @allowed() key word
In order to show the available SKUType we can say @allowed(['B1','B2','S1','S2'])
Parameter  Decorators


---