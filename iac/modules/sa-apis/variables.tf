variable "sa-apis" {
  type = object({
    apis_policies = list(string)
  })
}