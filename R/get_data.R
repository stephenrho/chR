#' Retrieve the 2022 county health rankings analytic dataset
#'
#' Gets the 2022 release from https://www.countyhealthrankings.org/ and returns as a data.table
#'
#' @param year not currently used as only 2022 variables are returned. Future iterations
#' may allow for previous versions of the CHR to be calculated
#' @returns a data.table containing the CHR data
#' @import data.table
#' @export
get_data <- function(year=NULL){
  if (!is.null(year)) warning("year is currently ignored. Only the 2022 data are supported for now")

  chr = data.table::fread("https://www.countyhealthrankings.org/sites/default/files/media/document/analytic_data2022.csv", skip = 1)
  return(chr)
}
