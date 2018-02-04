#' @title Convert a list to AWS CLI args
#'
#' @param ... A list of arguments that will be mapped to command-line args for a system call to the AWS CLI utility.
#'   Unnamed list entries are inserted into the system call as "<val>", i.e. with no argument-specifying hyphens.
#'   Named list entries are inserted into the system call with the "--<name> <val>" pattern.
#'   Any named list entries a \code{NULL} value will be inserted into the system call as "--<name>" only, i.e. as a named flag.
#'   Arguments are constructed from the list in the same order as provided in the list.
#'
#' @return A character vector of arguments suitable for a \code{sys::exec_internal} call.
#'
#' @examples
#' list2args("foo", bar = "baz", flag = NULL)
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
