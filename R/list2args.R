#' Create the command line args for the aws system call.
#'
#' @param ... A list of arguments.
#' Any entries that are named will be mapped to the "--<name> <val>" pattern.
#' Unnamed entries will simply be inserted in the system call as "<val>".
#' Named entries with \code{NULL} values will be inserted in the system call as "--<name>" only.
list2args <- function(...) {
    l <- list(...)

    ## if l is unnamed, set all names to "" (to prevent map2 problems downstream):
    if(is.null(names(l))) names(l) <- rep("", length(l))
    
    ## in l: replace any names with "--<name>":
    names(l) <- stringr::str_replace(names(l), "(.+)", "--\\1")

    purrr::map2(names(l), l, c) %>%  ## c() each named pair
        unlist() %>%  ## collapse into a character vector
        stringr::str_trim() %>%  ## cleanup any unprotected surrounding whitespace
        purrr::discard(stringr::str_length(.) == 0)  ## remove any remining empty args
}
