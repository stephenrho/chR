#' Get measures that go into county health rankings
#'
#' Returns the measures from county health rankings data
#' that are used to create four 'health factors'. Also returns
#' the weights for each measure.
#'
#' @param year not currently used as only 2022 variables are returned. Future iterations
#' may allow for previous versions of the CHR to be calculated
#' @return a list of health factors. Each health factor is also a list containing
#' \item{variables} the names of the variables that go in to a particular factor
#' \item{names} the column names of the variables in the CHR data release
#' \item{weights} the weight given to each variable in the CHR model
#' @export
get_measures <- function(year=NULL){
  # to do: length + quality of life
  if (!is.null(year)) warning("year is currently ignored. Only the 2022 measures are supported for now")

  # https://www.countyhealthrankings.org/sites/default/files/media/document/2022%20Ranked%20and%20Additional%20Measures%2C%20Data%20Sources%20and%20Years_0.pdf
  measures = list(
    # note some are reverse coded (see -ve weights)
    health_behaviors = list(
      variables = c("Adult smoking",
                    "Adult obesity",
                    "Food environment index",
                    "Physical inactivity",
                    "Access to exercise opportunities",
                    "Excessive drinking",
                    "Alcohol-impaired driving deaths",
                    "Sexually transmitted infections",
                    "Teen births"
      ),
      names = c("v009_rawvalue", # Adult smoking
                "v011_rawvalue", # Adult obesity
                "v133_rawvalue", # Food environment index
                "v070_rawvalue", # Physical inactivity
                "v132_rawvalue", # Access to exercise opportunities
                "v049_rawvalue", # Excessive drinking
                "v134_rawvalue", # Alcohol-impaired driving deaths
                "v045_rawvalue", # Sexually transmitted infections
                "v014_rawvalue"  # Teen births
      ),
      weights = c(.1, .05, -.02, .02, -.01, .025, .025, .025, .025)
    ),
    clinical_care = list(
      variables = c("Uninsured",
                    "Primary care physicians",
                    "Dentists",
                    "Mental health providers",
                    "Preventable hospital stays",
                    "Mammography screening",
                    "Flu vaccinations"
      ),
      names = c("v003_rawvalue", # Uninsured
                "v004_rawvalue", # Primary care physicians
                "v088_rawvalue", # Dentists
                "v062_rawvalue", # Mental health providers
                "v005_rawvalue", # Preventable hospital stays
                "v050_rawvalue", # Mammography screening
                "v155_rawvalue" # Flu vaccinations
      ),
      weights = c(.05, -.03, -.01, -.01, .05, -.025, -.025)
    ),
    social_economic_factors = list(
      variables = c("High school graduation",
                    "Some college",
                    "Unemployment",
                    "Children in poverty",
                    "Income inequality",
                    "Children in single-parent households",
                    "Social associations",
                    "Violent crime",
                    "Injury Deaths"
      ),
      names = c("v021_rawvalue", # High school graduation
                "v069_rawvalue", # Some college
                "v023_rawvalue", # Unemployment
                "v024_rawvalue", # Children in poverty
                "v044_rawvalue", # Income inequality
                "v082_rawvalue", # Children in single-parent households
                "v140_rawvalue", # Social associations
                "v043_rawvalue", # Violent crime
                "v135_rawvalue"  # Injury Deaths
      ),
      weights = c(-.05, -.05, .1, .075, .025, .025, -.025, .025, .025)
    ),
    physical_environment = list(
      variables = c("Air pollution – particulate matter",
                    "Drinking water violations",
                    "Severe housing problems",
                    "Driving alone to work",
                    "Long commute – driving alone"
      ),
      names = c("v125_rawvalue", # Air pollution – particulate matter
                "v124_rawvalue", # Drinking water violations
                "v136_rawvalue", # Severe housing problems
                "v067_rawvalue", # Driving alone to work
                "v137_rawvalue"  # Long commute – driving alone
      ),
      weights = c(.025, .025, .02, .02, .01)
    )
  )

  return(measures)
}

