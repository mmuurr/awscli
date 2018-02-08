default_args <- list(
    "output" = "json"
)

#' @title Execute AWS CLI command, sub-command, and args.
#'
#' @return A list with entries [int] \code{status}, [string] \code{stderr}, and [string] \code{stdout}.
exec_aws_cli <- function(cmd, subcmd, ...) {
    args <- c(cmd, subcmd, list2args(c(default_args, list(...))))
    flog.debug("executing system command: aws %s", paste0(args, collapse = " "))
    x <- sys::exec_internal("aws", args, error = FALSE)

    x$stdout <- rawToChar(x$stdout) %>% stringr::str_trim()
    x$stderr <- rawToChar(x$stderr) %>% stringr::str_trim()
    ##flog.debug("aws returned:\n%s", sstr(x))

    if(x$status != 0L) {
        stop(x$stderr)
    }

    return(x)
}
