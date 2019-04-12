#' Find n unique values within a data frame.
#'
#' @param .data a table of data
#' @param n_unique a numeric vector of length 1 or greater.
#' @param return_tibble boolean, if TRUE, a data frame is returned; if false, a list is returned.
#'
#' @return a data frame with column names, unique values, and number of unique values
#' @export
#'
#' @examples
#' find_n_unique_vals(mtcars, 2:3)
find_n_unique_vals <- function(.data, n_unique, return_tibble = TRUE) {

  x <- lapply(.data, function(x) unique(x))
  if (return_tibble) {
    tx <- subset(format_tibble(x), n_unique_values %in% n_unique)
    if (nrow(tx) == 0) stop(sprintf("No columns found with %s unique values.", paste(n_unique, collapse = ", ")), call. = FALSE)
    return(tx)
  }
  x <- purrr::keep(x, function(x) length(x) %in% n_unique)
  if (length(x) == 0) stop(sprintf("No columns found with %s unique values.", paste(n_unique, collapse = ", ")), call. = FALSE)
  x
}
