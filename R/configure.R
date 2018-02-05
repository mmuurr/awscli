#' @title Get a config setting
configure_get <- function(varname) {
    exec_aws_cli("configure", "get", varname) %>%
        .$stdout
}

#' @title List all configs
#' @description See all current configs in a table **for display only** (i.e. not parsed into an R object).
configure_list <- function() {
    exec_aws_cli("configure", "list")
}
