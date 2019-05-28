## TODO: normalize filepath? tilde (i.e. ~) expansion doesn't seem to work with the sys::exec calls.


#' @title List objects
#'
#' @examples
#' \dontrun{s3api_list_objects("bktname", prefix = "key/prefix/")}
s3api_list_objects <- function(bucket, ...) {
    x <- exec_aws_cli("s3api", "list-objects-v2", bucket = bucket, ...)
    if(jsonlite::validate(x$stdout)) {
        jsonlite::fromJSON(x$stdout)[[1]] %>% tibble::as_tibble()
    } else {
        x$stdout
    }
}

#' @title Put object
#' @param ... Additional AWS CLI s3api args, excluding `bucket`, `key`, and `body`.
s3api_put_object <- function(filepath, bucket, key, ...) {
    if(length(intersect(c("bucket", "key", "body"), names(list(...)))) != 0) {
        stop("bucket, key, and body are not allowed as optional named args")
    }
    exec_aws_cli("s3api", "put-object",
                 "bucket" = bucket,
                 "key" = key,
                 "body" = filepath,
                 ...)
}

#' @title Get object
s3api_get_object <- function(bucket, key, filepath, ...) {
    exec_aws_cli("s3api", "get-object",
                 "bucket" = bucket,
                 "key" = key,
                 ...,
                 filepath)
}

#' @title Delete object
s3api_delete_object <- function(bucket, key) {
    exec_aws_cli("s3api", "delete-object",
                 "bucket" = bucket,
                 "key" = key)
}

#' @title Get object description (i.e. HEAD)
s3api_head_object <- function(bucket, key) {
    x <- exec_aws_cli("s3api", "head-object",
                      "bucket" = bucket, "key" = key)
    if(jsonlite::validate(x$stdout)) {
        jsonlite::fromJSON(x$stdout)
    } else {
        x$stdout
    }
}
