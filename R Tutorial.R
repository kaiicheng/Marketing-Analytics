# Sequence.
v <- c(1, 5, 6)

class(v)

length(v)
length(1)

as.character(v)

vc <- c(1, "s", 5, "4")
vc

v <- as.numeric(vc)
v
is.na(v)

v <- c(1, 5, 6)

# class function.
class(TRUE)
v[1]
v[2]
length(v)
v[length(v)]

1:10
seq(1,10)
seq(1,10,2)

# Repeat 2 times.
rep(v,2)

# Repeat character 2 times.
rep(v, each=2)

# Unique function.
unique(rep(v, each=2))

# Functions.
sum(v)
prod(v)
mean(v)
sd(v)

max(v)
which.max(v)

v^2
log10(v)
exp(v)

# sapply function.
sapply(v, function(x) x^2)

# Repeat c 100 times.
rep(c("1990", "2000", "2010"), 100)

v <- rep(c("1990", "2000", "2010"), 100)
v <- factor(v)
v

levels(v)

# Change class.
as.character(v)
as.numeric(as.character(v))
