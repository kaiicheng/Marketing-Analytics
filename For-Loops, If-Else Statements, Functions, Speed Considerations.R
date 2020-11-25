# For loop.
for (i in 1:5){
  print(i)
}

# If-Else.
a <- 0.5

if (a > 1){
  print("hi")
} else if (a >0 ){
  print("hello")
} else {
  print("bye")
}

# Function.
custom_mean <- function(v){
  # taking mean over a vector
  temp <- 0
  for (i in v){
    temp <- temp + i
  }
  return(temp/length(v))
}

v <- runif(1000000)
v
custom_mean(v)
mean(v)

# Four-loops are generally slow.
s <- Sys.time()
custom_mean(v)
e <- Sys.time()
e-s

s <- Sys.time()
mean(v)
e <- Sys.time()
e-s

# Fast Fourier Transform.
?fft
fft
