data_train <- read.csv("train.csv")
data_test <-read.csv("test.csv")
summary(data_train)

library(recosystem)
set.seed(145)

r=Reco()
opts<-r$tune(data_memory(data_train$User,data_train$Movie, rating=data_train$Rating, index1=TRUE), opts=list(dim=c(5,10), lrate=c(0.05,0.1, 0.15),  niter=200, nfold=5, verbose=FALSE))

opts$min
$dim
[1] 10

$costp_l1
[1] 0

$costp_l2
[1] 0.1

$costq_l1
[1] 0

$costq_l2
[1] 0.01

$lrate
[1] 0.15

$loss_fun
[1] 0.3467603

r$train(data_memory(data_train$User, data_train$Movie, rating=data_train$Rating, index1=TRUE), opts=c(opts$min, nthread=1, niter=200))

res <- r$output(out_memory(), out_memory())

predMem=r$predict(data_memory(data_test$User,data_test$Movie, rating=NULL, index1=TRUE),out_memory())

rmse=sqrt(mean((predMem-data_test$Rating)^2))
rmse


