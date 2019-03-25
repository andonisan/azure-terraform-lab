# Function Basics

In this exercise we are simply going to create a resource group within Azure. While the steps we take to do this may seem like overkill they will lay the foundations for the rest of the lab environment we will create.

In this directory you will see a file named "main.tf".  Open "main.tf" as this will be where we add the providers and resources for this lab.

## Step 1 - Add variables

Add variables.tf

```
variable "rg_names" {
  description = "Create RGs with these names"
  type        = list(string)
  default     = ["Spain", "France", "Portugal"]
}
```


## Step 2 - Resource Group first

In main.tf 

```
resource "azurerm_resource_group" "main" {
  name     = "lab-2-5-${lower(var.rg_names[1])}-rg"
  location = "westeurope"
}

```

## Step 3 - Each count

```
resource "azurerm_resource_group" "main" {
  count    = length(var.rg_names)
  name     = "lab-2-5-${lower(var.rg_names[count.index])}-rg"
  location = "westeurope"
}
```


## Step 3 - for_each 

change in variables to 

```

variable "rg_names" {
  description = "Create RGs with these names"
  type        = map(string)
  default = {
    Spain    = "westeurope"
    France   = "northeurope"
    Portugal = "francecentral"
  }
}
```


```
resource "azurerm_resource_group" "main" {
  for_each = var.rg_names_set
  name     = "lab-2-5-${lower(each.key)}-rg"
  location = each.value
}

```
## Step 4 - if_else 

change in variables to 

```
variable "full_access" {
  description = "Full acces to resource groups"
  type        = bool
  default     = false
}

```
In main.tf we are going to create a resource group with 2 kinds of policy variable dependant


```
resource "azurerm_resource_group" "main" {
  name     = "lab-func-policy-rg"
  location = "westeurope"
}

resource "azurerm_management_lock" "can_not_delete" {
  count      = var.full_access ? 1 : 0
  name       = "CanNotDelete"
  scope      = azurerm_resource_group.main.id
  lock_level = "CanNotDelete"
}

resource "azurerm_management_lock" "read_only" {
  count      = var.full_access ? 0 : 1
  name       = "ReadOnly"
  scope      = azurerm_resource_group.main.id
  lock_level = "ReadOnly"
}
```

Using count and built-in functions to simulate if-else-statements is a bit of a hack, but it’s one that works fairly well, and as you can see from the code, it allows you to conceal lots of complexity from your users so that they get to work with a clean and simple API.
