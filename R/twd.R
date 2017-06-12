#' requires xts, lubridate, dplyr
#' read more about total water deficit 10.1029/WR016i002p00297
#' @param df.hist dataframe of historical monthly reservoir fill volume in % column name is "rs". First column must be of class POSIXct
#' @param df.x dataframe with same structure of df.hist with values for the months which we are calculating the index. Should have more than one row, ie more than one month
#' @export
twd <- function(df.hist,df.x)
{
    xts.obj <- xts(df.hist$rs,order.by=df.hist$posix)
    hist.mean <- apply.monthly(xts.obj,"mean")

    hist.mean <- data.frame(posix=time(hist.mean),rs=coredata(hist.mean))
    hist.mean$month <- month(hist.mean$posix)
    df.x$month <- month(df.x$posix)
    df.climatology <- left_join(df.x$month,hist.mean$month,by=month)
    df.climatology <- df.climatology[,c("posix.x","rs.y")]
    colnames(df.climatology) <- colnames(df.x)
    deficit0 <- df.x$rs-df.climatology$rs
    deficit0[deficit0>=0] <- NA
    duration0 <- deficit0-deficit0+1
    for(i in seq(2,nrow(df.x)))
    {
        if(is.na(deficit0[i])==FALSE)
        {
            if(is.na(deficit0[i-1]))
            {
                deficit0[i] <- deficit0[i]
                duration0[i] <- duration0[i]
            } else
            {
                deficit0[i] <- deficit0[i-1]+deficit0[i]
                duration0[i] <- duration0[i-1]+duration0[i]
            }
        }
    }
    twd <- data.frame(posix=df.x$posix,climatology=df.climatology$rs,twd=deficit0*duration0)
    return(twd)
}
