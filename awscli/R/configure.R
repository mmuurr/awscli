configure_get <- function(varname) {
    exec_aws_cli("configure", "get", varname) %>%
        .$stdout
}

## Returns a _text_ table for display only.
configure_list <- function() {
    exec_aws_cli("configure", "list")
}
