#' Calculate health factors from the 2022 county health rankings model
#'
#' Given the columns and weights specified in measures, calculate health factors used in
#' county health rankings. Currently get_data and get_measures only support 2022
#' data. The results of get_measures can be modified to alter the variables and weights
#' used in calculating the scores. Note the scores themselves, not the rankings, are returned.
#' To use the scores to create state level rankings, set z_state to TRUE.
#'
#' @param chr a county health rankings analytic data release (coerced to data.table if not one already)
#' @param measures a list of the measures
#' @param z_state if TRUE then the measures are scaled (z-scored) at the state level (used for ranking counties within a state)
#' if FALSE (default) measures are scaled relative to national mean and SD
#' @returns `chr` as a data.table with additional columns reflecting the factors specified in measures (see names(measures) for names of health factors)
#' @import data.table
#' @export
calc_factors = function(chr, measures, z_state = F){

  if (!data.table::is.data.table(chr)){
    chr = data.table::as.data.table(chr)
  }

  chr = subset(chr, state != "US")

  vars = unlist(lapply(measures, \(x) x$names))

  # replace missing vals with state means
  m = chr[, lapply(.SD, mean, na.rm=T), by=state, .SDcols=vars]
  m = merge(chr[,"state"], m)

  for (v in vars){
    set(chr, i = which(is.na(chr[[v]])), j = v, value = m[which(is.na(chr[[v]])), ..v])
  }

  if (z_state){
    # state means and SDs
    s = chr[, lapply(.SD, sd, na.rm=T), by=state, .SDcols=vars]
    s = merge(chr[,"state"], s)

    X = (chr[, ..vars] - m[, ..vars])/s[, ..vars]

    chr[, (paste0(vars, "_z")) := X]
  } else{
    # z-score w/o considering state
    chr[, (paste0(vars, "_z")) := lapply(.SD, scale), .SDcols=vars]
  }

  # truncate smaller counties
  #v051_rawvalue = population
  for (v in paste0(vars, "_z")){
    set(chr, i = which(chr$v051_rawvalue <= 20000 & chr[[v]] < -3), j = v, value = -3)
    set(chr, i = which(chr$v051_rawvalue <= 20000 & chr[[v]] > 3), j = v, value = 3)
  }

  # calculate scores
  # loop over measures...
  for (m in names(measures)){
    mvars = paste0(measures[[m]]$names, "_z")
    chr[, (m) := as.matrix(chr[, mget(mvars)]) %*% measures[[m]]$weights ]
  }

  return(chr)
}
