#' @title DynamoDB GetItem
#'
#' @param .fromJSON either a list of (named) arguments to be passed on to `jsonlite::fromJSON`, or `NULL` to not perform any JSON decoding of the returned value.
dynamodb_get_item <- function(tablename, key_json, ..., .fromJSON = NULL) {
  if(length(intersect(names(list(...)), c("table-name", "key"))) > 0) {
    stop("`table-name` and `key` are not allowed as optional named args")
  }
  if(!isTRUE(is.null(.fromJSON) || is.list(.fromJSON))) {
    stop("`.fromJSON` must be either a list or NULL")
  }
  awscli_retval <- exec_aws_cli(
    "dynamodb",
    "get-item",
    "table-name" = tablename,
    "key" = key_json,
    ...
  )
  if(isTRUE(is.list(.fromJSON) && jsonlite::validate(awscli_retval$stdout))) {
    do.call(jsonlite::fromJSON, c(awscli_retval$stdout, .fromJSON))
  } else {
    awscli_retval$stdout
  }
}
dynamodbGetItem <- dynamodb_get_item  ## support camelCase and snake_case
