# Loading and Cleaning Data
download.file("http://www1.nyc.gov/assets/finance/downloads/pdf/rolling_sales/rollingsales_manhattan.xls", destfile="manhattan_real_estate.xls")

data <- read.xls("manhattan_real_estate.xls", header=TRUE, pattern="BOROUGH")

data <- read.xls(xls = "manhattan_real_estate.xls")

class(data)

# data frame
class(data)

# size of data
dim(data)

# names of columns - could be overwritten if desired
colnames(data)

# see top 5 rows of the data
head(data, 5)

# what class?
class(data$SALE.PRICE)

class(data$YEAR.BUILT)

# transform factor into numeric
data$YEAR.BUILT <- as.numeric(as.character(data$YEAR.BUILT))

# transform factor into numeric, removing commas and dollar signs on the way
data$SALE.PRICE <- as.numeric(gsub("\\$ ","",gsub(",","",as.character(data$SALE.PRICE))))

# transform into factor to make it a categorical variable
data$TAX.CLASS.AT.TIME.OF.SALE <- as.factor(data$TAX.CLASS.AT.TIME.OF.SALE)

data <- data[!is.na(data$YEAR.BUILT),] # remove observations with a missing year of construction
data <- data[data$YEAR.BUILT>=1900,] # only keep observations after 1900
data <- data[data$SALE.PRICE>0,] # filter out zero prices (e.g., due to inheritance/gifts)

# check size of the data again
dim(data)

# we could now save the data, dropping row index
write.csv(data,file='clean_data.csv',row.names=FALSE)

# and here is how we could read it back in
head(read.csv(file = "clean_data.csv", head=TRUE))


