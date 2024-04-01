secretsmanager_get_secret_value.extract_secret_string <- function(json) {
  json %>%
    jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyMatrix = FALSE) %>%
    .$SecretString
}

secretsmanager_get_secret_value.from_json <- function(json) {
  json %>%
    jsonlite::fromJSON(simplifyDataFrame = FALSE, simplifyMatrix = FALSE)
}

#' @title Secrets Manager get-secret-value
#'
secretsmanager_get_secret_value <- function(secret_id, ..., .convertor = secretsmanager_get_secret_value.extract_secret_string) {
  if(length(intersect(names(list(...)), c("secret-id"))) > 0) {
    stop("`secret-id` is not allowed as an optional named arg")
  }

  awscli_retval <- exec_aws_cli(
    "secretsmanager",
    "get-secret-value",
    "secret-id" = secret_id,
    ...
  )

  .convertor(awscli_retval$stdout)
}
