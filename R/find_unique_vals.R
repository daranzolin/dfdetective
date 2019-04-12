#' Find unique values in a data frame
#'
#' @param .data a table of data
#' @param pattern Pattern to look for
#' @param return_tibble boolean, if TRUE, a data frame is returned; if false, a list is returned.
#'
#' @return a data frame with column names, unique values, and number of unique values
#' @export
#'
#' @examples
#' \dontrun{
#' library(gapminder)
#' find_unique_vals(gapminder, "Kuwait")
#' }
find_unique_vals <- function(.data, pattern = NULL, return_tibble = TRUE) {

  x <- lapply(.data, function(x) unique(x))
  if (is.null(pattern)) {
    if (return_tibble) {
      return(format_tibble(x))
    }
    return(x)
  }

  x <- purrr::keep(x, function(x) {
    b <- grepl(pattern, x, ignore.case = TRUE)
    b <- ifelse(is.na(b), FALSE, b)
    any(b)
  })

  if (return_tibble) {
    x <- format_tibble(x)
    if (nrow(x) == 0) {
      cn <- grep(pattern, names(.data), value = TRUE, ignore.case = TRUE)
      if (length(cn) == 0) {
        stop("No examples found.", call. = FALSE)
      } else {
        m <- sprintf("Pattern '%s' found in header:\n", pattern)
        warning(m, sprintf("* %s\n", cn), call. = FALSE)
      }
    } else return(x)
  }
  x
}
