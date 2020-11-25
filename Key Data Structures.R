# matrix.
matrix(0,2,4)

# Repeat.
rep(0,5)

matrix(0,5,1)

as.matrix(rep(0,5))
as.vector(matrix(0,5,1))

# Variables.
set.seed(999)
runif(5)

rnorm(5)

# vector -> matrix.
v <- rnorm(12)
matrix(v,4,3)

m <- matrix(v,4,3,byrow=TRUE)
m

# Transpose.
t(m)

# Dot product.
m %*% t(m)

m*m

10*m

# Dimension.
dim(m)
dim(m)[1]

# Mean.
mean(m)

# apply -> mean
apply(m,1,mean)  # 1 => row
apply(m,2,mean)  # 2 => column

# Get element.
m[1,]
m[,2]
m[1,2]

# solve function to get inverse.
solve(m[1:3,1:3])


# List.
l1 <- list(5,"b",c(12,13))
l1

l1[[1]]
l1[1]

# To get vector from list.
unlist(l1)

l2 <- list(a1 = 5, a2 = c(29,10), a3 = c(3,19))
l2

# Index.       
l2$a1

lapply(l2, function(x) x^2)


# Dataframe.
b1 <- c(NA, 22, 50)
b2 <- c("john", "rose", "john")
b3 <- c(TRUE, FALSE, TRUE)
df <- data.frame(b1, b2, b3)
df

df$b2

df <- data.frame(b1, b2, b3, stringsAsFactors = FALSE)
df

colnames(df)
df$b1
colnames(df) <- c("age", "name", "indicator")
colnames(df)

df$indicator[2]
df[2, "indicator"]
df[1:2, c("age", "indicator")]
df[2, 3]
df$name==""
df[df$name==""]

df[df$name == "john",]

df[!is.na(df$age)]

rbind(df, df)
cbind(df, df)
