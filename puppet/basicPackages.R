
# A r-program to install useful packages not included in the standard library
# Execute as sudo

options("repos"="http://cran.nexr.com/", dep=TRUE) # set the cran mirror


# Update existing packages
update.packages(ask = FALSE)

# Data manipulation
install.packages("plyr", dep=TRUE) # data wrangling
install.packages("reshape2", dep=TRUE) # data wrangling
install.packages("rjson", dep=TRUE)
install.packages("lubridate", dep=TRUE) # date handling
install.packages("Hmisc", dep=TRUE)
install.packages("data.table", dep=TRUE)
install.packages("sqldf", dep=TRUE)

# Literate programming packages
install.packages("markdown", dep=TRUE)
install.packages("knitr", dep=TRUE)

# Graphics packages
install.packages("Cairo", dep=TRUE)
install.packages("ggplot2", dep=TRUE) # Grammar of graphics implementation
install.packages("scales", dep=TRUE)
install.packages("GGally", dep=TRUE)
install.packages("gridExtra", dep=TRUE)

# Packages for regression analysis
install.packages("biglm", dep=TRUE)
install.packages("car", dep=TRUE)
install.packages("lmtest", dep=TRUE)
install.packages("arm", dep=TRUE)
install.packages("gvlma", dep=TRUE)
install.packages("penalized", dep=TRUE)

# Packages for Bayesian analysis
install.packages("coda", dep=TRUE)
install.packages("boa", dep=TRUE)
install.packages("R2OpenBUGS", dep=TRUE)
install.packages("rbugs", dep=TRUE)
#install.packages("BRugs", dep=TRUE)
install.packages("rjags", dep=TRUE)
install.packages("R2jags", dep=TRUE)
install.packages("runjags", dep=TRUE)
install.packages("MCMCpack", dep=TRUE)

# Package management and development
install.packages("devtools", dep=TRUE)


# Packages for Hive
install.packages("rJava", dep=TRUE)
install.packages("Rserve", dep=TRUE)
install.packages("RHive", dep=TRUE)

# Working with data
install.packages("stringr", dep=TRUE) # string handling

# File/data input/output
install.packages("RCurl", dep=TRUE) # get files through http
install.packages("RJSONIO", dep=TRUE) # work with JSON data structures


