seg_data <- read.csv(file = "SegmentationData.csv",row.names=1)
head(seg_data)

std_seg_data <- scale(seg_data[,c("Trendy", "Styling", "Reliability", "Sportiness", "Performance", "Comfort")]) 

set.seed(1990)
car_Cluster3 <-kmeans(std_seg_data, 3, iter.max=100,nstart=100)
car_Cluster3

Kmean_Cluster<-factor(car_Cluster3$cluster,levels = c(1,2,3),
                      labels = c("Perf. KM", "Comfort KM", "Appearance KM"))
Kmean_Cluster

set.seed(1990)
NbClust(data=std_seg_data[,1:5], min.nc=3, max.nc=15, index="all", method="kmeans")


