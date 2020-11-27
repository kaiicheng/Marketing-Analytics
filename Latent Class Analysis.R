seg_data <- read.csv(file = "SegmentationData.csv",row.names=1)
head(seg_data)

std_seg_data <- scale(seg_data[,c("Trendy", "Styling", "Reliability", "Sportiness", "Performance", "Comfort")]) 
head(std_seg_data)

mclustBIC(std_seg_data[,1:5],verbose=F)

lca_clust <- Mclust(std_seg_data[,1:5],verbose = FALSE)
summary(lca_clust)

lca_clusters <- lca_clust$classification
lca_clust_summary <- aggregate(std_seg_data[,c("Trendy", "Styling", "Reliability", "Sportiness", "Performance", "Comfort")],by=list(lca_clusters),FUN=mean)
lca_clust_summary
lca_clusters<-factor(lca_clusters,levels = c(1,2),
                     labels = c("Reliability LCA", "Comfort LCA"))

CrossTable(seg_data$MBA,lca_clusters,prop.chisq = FALSE, prop.r = T, prop.c = T,
           prop.t = F,chisq = T)
