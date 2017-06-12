require(lubridate)
require(devtools)
install_git("https://github.com/jmigueldelgado/hdi.git")
require(hdi)
require(xts)
require(dplyr)
require(myrpack)

res <- read.table("~/SESAM/sesam_data/DFG_Erkenntnis_Transfer/Climate_Prediction/aggregation/Reservoir data/reservoir_volumes.txt")
head(res)

df <- data.frame(posix=as.POSIXct(res$Date),rs=res$id_1)

x <- twd(df,df)
