#' requires xts, lubridate, dplyr
#' read more about total water deficit 10.1029/WR016i002p00297
#' @param df.hist dataframe of historical monthly reservoir fill volume in % column name is "rs". First column must be of class POSIXct
#' @param df.i dataframe with same structure of df.hist with values for the month for which we are calculating the index. Can have more than one row, ie more than one month
#' @export
twd <- function(df.hist,df.i)
{
    xts.obj <- xts(df.hist$rs,order.by=df.hist$posix)
    hist.mean <- apply.monthly(xts.obj,"mean")
    return(twd)
}
