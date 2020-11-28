library(nFactors)

cardata = read.csv(file = "cardata.xls")
head(cardata)

# Determining the Number of Factors.
library(nFactors)
nScree(cardata[,4:9], cor=TRUE) #This function help you determine the number of factors

fit <- principal(cardata[,4:9], nfactors=5, rotate="none")
fit$loadings

fit <- principal(cardata[,4:9], nfactors=3, rotate="varimax")
fit$loadings

colnames(fit$weights) = c("Appearance", "Performance", "Comfort") # Naming the factors
fit$weights

colnames(fit$scores) = c("Appearance", "Performance", "Comfort") 
reduced_data = cbind(cardata[,1:3],fit$scores)
head(reduced_data)

attach(reduced_data)
brand.mean=aggregate(reduced_data[,c(4:6)], by=list(Brand), FUN=mean, na.rm=TRUE)
detach(reduced_data)
head(brand.mean)

# Three dimensional perceptual map.
attach(brand.mean)

# 3D Scatterplot
library(scatterplot3d)
s3d <- scatterplot3d(Appearance, Performance, Comfort,
                     scale.y = 1, type='h', asp = 1,
                     main="3D Perceptual Map")
text(s3d$xyz.convert(Appearance, Performance, Comfort + c(rep(0.05,5),0.1)),
     labels=(brand.mean[,1]), 
     col = 'red')

detach(brand.mean)

attach(reduced_data)

brand_by_edu=aggregate(reduced_data[,c(4:6)], by=list(Brand, Education), 
                       FUN=mean, na.rm=TRUE)
colnames(brand_by_edu) = c("Brand", "Edu", "Appearance", "Performance", "Comfort")
detach(reduced_data)
brand_by_edu # Print the average factor scores by brand and education

attach(brand_by_edu)

# 3D Scatterplot
library(scatterplot3d)
s3d1 <- scatterplot3d(brand_by_edu[,3], brand_by_edu[,4], 
                      brand_by_edu[,5], xlab = "Appearance", 
                      ylab = "Performance", zlab = "Comfort",
                      scale.y = 1, type='h', asp = 1,
                      main="3D Perceptual Map")
tmp <- brand_by_edu[which(brand_by_edu$Edu == 'MBA'),]
text(s3d1$xyz.convert(tmp$Appearance, tmp$Performance, 
                      tmp$Comfort + c(rep(0.05,5),0.1)),
     labels=(tmp$Brands), col = 'darkgreen')

tmp <- brand_by_edu[which(brand_by_edu$Edu=='Undergrad'),] 
text(s3d1$xyz.convert(tmp$Appearance, tmp$Performance, 
                      tmp$Comfort + c(rep(0.05,5),0.1)),
     labels=(tmp$Brands), col = 'red')
legend(-3, 8, 
       legend=c("MBA", "Undergrad"),
       col=c("red", "darkgreen"), lty=1, cex=0.8)

# Append preference data
red_data = cbind(cardata[,c(2,3,10)], fit$scores)
colnames(red_data) = c("Brand", "Edu", "Preference", "Appearance", "Performance", "Comfort")
head(red_data)

# Multiple Linear Regression 
regfit <- lm(Preference ~ Appearance + Performance + Comfort, data=red_data)
summary(regfit) # show results
