require(lubridate)
require(devtools)
install_git("https://github.com/jmigueldelgado/hdi.git")
library(hdi)

df.hist <- data.frame(
    posix=seq(ISOdate(1950,1,1),ISOdate(1999,12,1),by="month"), #date as a posix object
    rs=rnorm(600), #synthetic reservoir volume
    sf=rep(0,600), #synthetic streamflow
    pr=rep(0,600)) #synthetic precipitation

df.i <- data.frame( #same as previously
    posix=seq(ISOdate(1950,1,1),ISOdate(1950,3,1),by="month"),
    rs=c(-1,0,1),
    sf=rep(1,3),
    pr=rep(10,3))

coeff <- data.frame(
    posix=seq(ISOdate(1950,1,1),ISOdate(1950,12,1),by="month"),
    a=rep(1,12), #coefficient for reservoir=1
    b=rep(0,12), #coefficient for streamflow=0
    c=rep(0,12)) #coefficient for precipitation=0
# coefficients for variables other than reservoirs are set to 0 in this example

swsi(df.hist,df.i,coeff)

