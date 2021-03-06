#' Output to gt (table) format
#'
#' @inheritParams stw_to_roxygen
#'
#' @return A gt table
#' @export
#'
#' @examples
#' stw_to_table(diamonds_meta)
#'
stw_to_table <- function(meta, ...) {
  UseMethod("stw_to_table")
}

#' @rdname stw_to_table
#' @export
#'
stw_to_table.default <- function(meta, ...) {
  stop(error_message_method("stw_to_table()", class(meta)))
}

#' @rdname stw_to_table
#' @export
#'
stw_to_table.stw_meta <- function(meta, ...) {

  # make the title uppercase
  name <- toupper(meta[["name"]])

  # title
  title <- meta[["title"]] %|0|% NULL

  dict <- meta[["dict"]]
  # convert NULL values to `""`
  dict[["levels"]] <- lapply(dict[["levels"]], `%|0|%`, "")
  # capitalize the variable-names in the dictionary, e.g. "name", "type", ...
  names(dict) <- stringr::str_to_title(names(dict))

  # TODO: consider removing `Levels` column if completely empty

  table <-
    dict %>%
    gt::gt() %>%
    gt::tab_header(
      title = name,
      subtitle = title
    ) %>%
    gt::tab_style(
      style = gt::cells_styles(text_style = "italic"),
      locations = gt::cells_data("Name")
    ) %>%
    gt::cols_align("right", columns = "Name") %>%
    gt::cols_align("left", columns = c("Type", "Description", "Levels"))

  # add sources, if they exist
  sources <- meta[["sources"]]
  if (!rlang::is_empty(sources)) {

    str_sources <- lapply(sources, function(x) do.call(source_to_markdown, x))
    str_sources <- glue::glue_collapse(str_sources, sep = ", ")
    str_source <- glue::glue("Sources: {str_sources}")

    table <- gt::tab_source_note(table, source_note = gt::md(str_source))
  }

  table
}
