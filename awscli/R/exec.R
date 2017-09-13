default_args <- c("--output", "json")

exec_aws_cli <- function(cmd, subcmd, ...) {
    args <- c(cmd, subcmd, default_args, list2args(...))
    flog.debug("executing system command: aws %s", paste0(args, collapse = " "))
    x <- sys::exec_internal("aws", args, error = FALSE)

    x$stdout <- rawToChar(x$stdout) %>% stringr::str_trim()
    x$stderr <- rawToChar(x$stderr) %>% stringr::str_trim()
    flog.debug("aws returned:\n%s", sstr(x))

    if(x$status != 0L) {
        stop(x$stderr)
    }

    return(x)
}
