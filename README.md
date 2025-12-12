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
