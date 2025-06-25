output "app_gateway_id" {
  value = (
    length(azurerm_application_gateway.https) > 0
    ? azurerm_application_gateway.https[0].id
    : azurerm_application_gateway.http[0].id
  )
}
