resource "azapi_resource" "fleet" {
  type      = "Microsoft.ContainerService/fleets@2023-10-15"
  parent_id = azurerm_resource_group.test.id
  name      = "acctest3650"

  body = jsonencode({
    location = "westcentralus"
    identity = {
      type = "SystemAssigned"
    }
    properties = {
    }
    tags = {
      archv2 = ""
      tier   = "production"
    }
  })

  schema_validation_enabled = false
  ignore_missing_property   = false
}

resource "azapi_resource" "updateRun_withStrategy" {
  type      = "Microsoft.ContainerService/fleets/updateRuns@2023-10-15"
  parent_id = azapi_resource.fleet.id
  name      = "acctest7037"

  body = jsonencode({
    properties = {
      managedClusterUpdate = {
        nodeImageSelection = {
          type = "Latest"
        }
        upgrade = {
          kubernetesVersion = "1.27"
          type              = "Full"
        }
      }
      updateStrategyId = azapi_resource.updateStrategy.id
    }
  })

  schema_validation_enabled = false
  ignore_missing_property   = false
  depends_on = [ azapi_resource.member ]
}

resource "azapi_resource" "updateRun_noStrategy" {
  type      = "Microsoft.ContainerService/fleets/updateRuns@2023-10-15"
  parent_id = azapi_resource.fleet.id
  name      = "acctest7038"

  body = jsonencode({
    properties = {
      managedClusterUpdate = {
        nodeImageSelection = {
          type = "Consistent"
        }
        upgrade = {
          kubernetesVersion = "1.27"
          type              = "Full"
        }
      }
      strategy = {
        stages = [
          {
            afterStageWaitInSeconds = 3600
            groups = [
              {
                  name = "group-a"
              }
            ]
            name = "stage1"
          }
        ]
      }
    }
  })

  schema_validation_enabled = false
  ignore_missing_property   = false
  depends_on = [ azapi_resource.member ]
}

resource "azapi_resource" "updateStrategy" {
  type      = "Microsoft.ContainerService/fleets/updateStrategies@2023-10-15"
  parent_id = azapi_resource.fleet.id
  name      = "acctest6244"

  body = jsonencode({
    properties = {
      strategy = {
        stages = [
          {
            afterStageWaitInSeconds = 3600
            groups = [
              {
                name = "group-a"
              }
            ]
            name = "stage1"
          }
        ]
      }
    }
  })

  schema_validation_enabled = false
  ignore_missing_property   = false
}

resource "azapi_resource" "member" {
  type      = "Microsoft.ContainerService/fleets/members@2023-10-15"
  parent_id = azapi_resource.fleet.id
  name      = "acctest4092"

  body = jsonencode({
    properties = {
      group = "group-a"
      clusterResourceId = azurerm_kubernetes_cluster.test.id
    }
  })

  schema_validation_enabled = false
  ignore_missing_property   = false
}
