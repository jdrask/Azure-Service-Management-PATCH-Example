$subscriptionId = "<subscription id>"
$resourceGroupName = "<resource group name>"
$uri = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$($resourceGroupName)?api-version=2014-04-01"
$bodyPayload = @{}
$bodyPayload.tags = @{}
$bodyPayload.tags.tag1 = "this is tag 1"
$bodyPayload.tags.tag2 = "this is tag2"
$body = $bodyPayload | ConvertTo-Json

Login-AzureRmAccount
$context = Get-AzureRmContext
$cache = $context.TokenCache
$cacheItems = $cache.ReadItems()
$token = $cacheItems | ?{$_.Resource -eq "https://management.core.windows.net/"} | select -ExpandProperty AccessToken
Invoke-WebRequest -Headers @{"Authorization" = "Bearer $token"} -Method PATCH -Uri $uri -Body $body -ContentType "application/json"
