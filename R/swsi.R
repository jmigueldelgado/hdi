#' requires lubridate
#' read more in http://climate.colostate.edu/pdfs/climo_rpt_91-3.pdf
#' @param df.hist dataframe of historical monthly reservoir volume, streamflow and precipitation of columns rs, sf, pr respectively. First column must be POSIXct
#' @param df.i dataframe with same structure of df.hist with values for the month for which we are calculating the index. Can have more than one row
#' @param coeff is a dataframe of time (posix) and coefficients a, b and c for each month January to December (coefficients may vary along the seasons). 
#' @export
swsi <- function(df.hist,df.i,coeff)
{
    df.i$month <- month(df.i$posix)
    coeff$month <- month(coeff$posix)
    coeff <- coeff[,colnames(coeff)!="posix"]
    df.i <- left_join(df.i,coeff)
    
    ecdf.rs <- ecdf(df.hist$rs)
    ecdf.sf <- ecdf(df.hist$sf)
    ecdf.pr <- ecdf(df.hist$pr)
    swsi <- data.frame(posix=df.i$posix,swsi=100*(df.i$a*ecdf.rs(df.i$rs)+df.i$b*ecdf.sf(df.i$sf)+df.i$c*ecdf.pr(df.i$pr)-0.5)/12)
    return(swsi)
}
