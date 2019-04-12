format_tibble <- function(x) {
  tibble::tibble(
    col_name = names(x),
    unique_values = purrr::map_chr(x, ~paste(.x, collapse = ", ")),
    n_unique_values = purrr::map_int(x, ~length(unique(.x)))
  )
}
