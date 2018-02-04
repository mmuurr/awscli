## TODO: normalize filepath? tilde (i.e. ~) expansion doesn't seem to work with the sys::exec calls.

s3api_list_objects <- function(bucket, ...) {
    x <- exec_aws_cli("s3api", "list-objects-v2", "bucket" = bucket, ...)
    if(jsonlite::validate(x$stdout)) {
        jsonlite::fromJSON(x$stdout)[[1]] %>% tibble::as_tibble()
    } else {
        x$stdout
    }
}

s3api_put_object <- function(filepath, bucket, key) {
    exec_aws_cli("s3api", "put-object",
                 "bucket" = bucket,
                 "key" = key,
                 "body" = filepath)
}

s3api_get_object <- function(bucket, key, filepath) {
    exec_aws_cli("s3api", "get-object",
                 "bucket" = bucket,
                 "key" = key,
                 filepath)
}

s3api_delete_object <- function(bucket, key) {
    exec_aws_cli("s3api", "delete-object",
                 "bucket" = bucket,
                 "key" = key)
}

s3api_head_object <- function(bucket, key) {
    x <- exec_aws_cli("s3api", "head-object",
                      "bucket" = bucket, "key" = key)
    if(jsonlite::validate(x$stdout)) {
        jsonlite::fromJSON(x$stdout)
    } else {
        x$stdout
    }
}