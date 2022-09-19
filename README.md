
# chR - County Health Rankings data in R

Functions for retrieving 2022 county health rankings data and calculating the health factors used in rankings.

Future iterations will support previous iterations of the [county health rankings model](https://www.countyhealthrankings.org/explore-health-rankings/measures-data-sources/county-health-rankings-model) as well as [previous data releases](https://www.countyhealthrankings.org/explore-health-rankings/rankings-data-documentation/national-data-documentation-2010-2019).

## Usage

```
devtools::install_github("https://github.com/stephenrho/chR/")

library(chR)

# get the 2022 data release from 
# https://www.countyhealthrankings.org/sites/default/files/media/document/analytic_data2022.csv
chr = get_data()

measures = get_measures() # get the column names and weights

chr = calc_factors(chr = chr, measures = measures, z_state = F) 
# z_state = T standardizes variables within state prior to calculating health factors

```
