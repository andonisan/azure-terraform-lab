# Azure Virtual Machine Scale Set

## Needed

Previously we need this labs

4.0
4.1
5.0
5.1 

## Expected Outcome

In this challenge, you will create a kubernetes cluster, and deploy a service, in this case nginx.

The service to deploy is just an  example of how terraform can be used to manage kubernetes resources just like Azure resources.

The resources you will use in this challenge:

- Resource Group
- Virtual Network
- Subnet
- Azure Kubernetes Service (AKS)
- Load Balancer (auto generated)
- Public IP Address (auto generated)
- kubernetes_pod/kubernetes_service

## How to

### Create the base Terraform Configuration

Change directory into a folder specific to this challenge.

We will start with a few of the basic resources needed in infrastructure.

Create a `core.tf` file to hold our configuration.

Add the folowing to the file:

```hcl
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-vnet"
  address_space       = [var.address_space]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "main" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = var.address_prefix
}

```


### Create log analytics

Create `loganalytics.tf` and add the following configuration:

```

resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "loganalytics" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.main.name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "loganalytics" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.loganalytics.location
    resource_group_name   = azurerm_resource_group.main.name
    workspace_resource_id = azurerm_log_analytics_workspace.loganalytics.id
    workspace_name        = azurerm_log_analytics_workspace.loganalytics.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

```

### Create kubernetes cluster

Create `kubernetes.tf` and add the following configuration:

```

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  dns_prefix          = "${var.prefix}"

 default_node_pool {
    name       = "default"
    node_count = 1
    type       = "VirtualMachineScaleSets"
    vm_size    = "Standard_D2_v2"
    vnet_subnet_id = azurerm_subnet.main.id
  }

  service_principal {
      client_id     = var.client_id
      client_secret = var.client_secret
  }

  addon_profile {
      oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.loganalytics.id
      }
  }
}
```


### Create Variables

Create a file `variables.tf` and add the following configuration:

```
variable prefix {}
variable location {}
variable address_space {}
variable address_prefix {}
variable log_analytics_workspace_name {}
variable log_analytics_workspace_location {}
variable log_analytics_workspace_sku {}
variable agent_count {}

#######################
variable client_id {}
variable client_secret {}
```

### Supply values for variables

Create a file `terraform.tfvars` and fill in the values.  Kubernetes needs this to be able to provision load balancers and infrastructure on the clusters behalf:

```
prefix= "lab-8-0-aks"
location= "westeurope"
address_prefix= "10.1.0.0/24"
address_space= "10.1.0.0/16"
log_analytics_workspace_name =  "lab80aksLogAnalyticsWorkspaceName"
log_analytics_workspace_sku = "PerGB2018"

```

### Create point to site


### Run Terraform Workflow

Run `terraform init` since this is the first time we are running Terraform from this directory.

Run `terraform plan` and validate all resources are being created as desired.

Run `terraform apply` and type `yes` when prompted.

Inspect the infrastructure in the portal.

Change the node count to another number and replan, does it match your expectations?


### Run Terraform Workflow

Run `terraform init` since this is the first time we are running Terraform from this directory.

Run `terraform plan` and validate all resources are being created as desired.

Run `terraform apply` and type `yes` when prompted.

Inspect the infrastructure in the portal.

Access your nginx service with the IP provided.

### Clean up

When you are done, run `terraform destroy` to remove everything we created.
