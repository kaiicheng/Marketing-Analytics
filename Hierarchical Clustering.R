library(NbClust)
library(mclust)
library(gmodels)

seg_data <- read.csv(file="SegmentationData.csv", row.names=1)
head(seg_data)

std_seg_data <- scale(seg_data[,c("Trendy", "Styling", "Reliability", "Sportiness", "Performance", "Comfort")]) 
dist <- dist(std_seg_data, method = "euclidean")
as.matrix(dist)[1:5,1:5]

clust <- hclust(dist, method = "ward.D2")
plot(clust)

h_cluster <- cutree(clust, 4)
rect.hclust(clust, k=4, border="red")

table(h_cluster)

hclust_summary <- aggregate(std_seg_data[,c("Trendy", "Styling", "Reliability", "Sportiness", "Performance", "Comfort")],by=list(h_cluster),FUN=mean)
hclust_summary

plot(clust)
h_cluster <- cutree(clust, 3)
rect.hclust(clust, k=3, border="red")
table(h_cluster)

hclust_summary <- aggregate(std_seg_data[,c("Trendy", "Styling", "Reliability", "Sportiness", "Performance", "Comfort")],by=list(h_cluster),FUN=mean)
hclust_summary

h_cluster <- factor(h_cluster,levels = c(1,2,3),
                    labels = c("Perf.", "Comfort", "Appearance"))

plot(cut(as.dendrogram(clust), h=9)$lower[[3]])

NbClust(data=std_seg_data[,1:5], min.nc=3, max.nc=15, index="all", method="ward.D2")

CrossTable(seg_data$MBA,h_cluster,prop.chisq = FALSE, prop.r = T, prop.c = T,
           prop.t = F,chisq = T)

CrossTable(h_cluster,seg_data$Choice,prop.chisq = FALSE, prop.r = T, prop.c = T,
           prop.t = F,chisq = T)
