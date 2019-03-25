[![infra as code with Terraform](/docs/images/banner.png)](/README.md)

# Import Resources

Maybe sometimes resources are created outside terraform. In portal azure for example

## Step 1 - Add RG in portal Azure

```
Add Resource group lab-2-3
```

Now run:

```
terraform plan
```

Notice that resource group lab-2-3 should be created

Now run:

```
terraform import azurerm_resource_group.lab /subscriptions/xxx/resourceGroups/lab
```

# Next Step
[2.4 VMs](../2.4)
