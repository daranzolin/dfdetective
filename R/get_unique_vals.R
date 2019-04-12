#' Get unique values by column
#'
#' @param .data a table of data.
#' @param ... One or more unquoted expressions separated by commas. Can pass helper functions, e.g. starts_with(), contains(), etc.
#'
#' @return a data frame with column names, unique values, and number of unique values
#' @export
#'
#' @examples
get_unique_vals <- function(.data, ...) {
  x <- subset(.data, select = c(
    tidyselect::vars_select(names(.data), !!!rlang::quos(...)))
  )
  x <- lapply(x, function(x) unique(x))
  format_tibble(x)
  # error, warn, message on no matches?
}
