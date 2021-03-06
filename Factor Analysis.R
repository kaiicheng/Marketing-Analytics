library(psych)
library(nFactors)

test_scores = read.csv(file = "testscoresdata.xls")
test_scores

library(corrplot)
corrplot(cor(test_scores[,2:7]), order = "hclust")

eigenval=eigen(cor(test_scores[,2:7]))
eigenval$values

# The scree plot.
plot(eigenval$values, main="Scree Plot", type="l")

library(nFactors)
nScree(test_scores[, 2:7], cor=TRUE) #This function help you determine the number of factors

library(psych)
fit <- principal(test_scores[, 2:7],nfactors=2, rotate="varimax")

fit$values #print the eigen values of the correlation matrix

fit$loadings # print the factor loading results

# Factor weights.
colnames(fit$weights) = c("Verbal", "Math") # renaming RC1 as "Verbal" factor and RC2 as "Math" factor
fit$weights # print the factor weights

# Factor Scores.
colnames(fit$scores) = c("Verbal", "Math") # renaming RC1 as "Verbal" factor and RC2 as "Math" factor
fit$scores #print the factor scores

colnames(fit$scores) = c("Verbal", "Math") # renaming RC1 as "Verbal" factor and RC2 as "Math" factor
biplot(fit$scores, fit$loadings, xlabs=test_scores[,1], main = "Perceptual Map\n\n") # Perceptual map
abline(h=0) #add a horizontal line in the graph

abline(v=0) #add a vertical line in the graph

# Varimax Rotated Principal Components
# retaining 2 factors 
library(psych)
fit <- principal(test_scores[, 2:7],nfactors=2, rotate="varimax")
#extracting scores and loadings info from "fit" object, and binding them together in order to plot together
ty = rbind(as.data.frame(unclass(fit$scores)),
           (as.data.frame(unclass(fit$loadings))*3)) #multiplied by scalar for plot 
colnames(ty) = c("Verbal", "Math")
#Credit for the plotting function goes to Ben Levine, Ph.D student at Columbia Business School
library(ggplot2) #library for creating visualizations

# Perceptual Map.
#PCA plot!
#ggplot takes at least two arguments: what dataframe it is referencing (ty),
#and the aesthetic mappings of the plot it will produce, i.e. the names of the columns it will use for the x and y axes.
#the default x and y axes titles are the variable names (in this case, RC1 and RC2). if you want to change them just uncomment the below:
# colnames(ty) = c("yournew_x_name", "yournew_y_name") 
library(ggplot2)
library(ggrepel)
ggplot(ty, aes(Verbal, Math)) +
  #first, the scores  
  
  #for the students, we will restrict the referenced data to only the first 10 rows of ty (the last 6 are classes).
  #rather than plotting points ('geom_point()'), we are plotting the text, hence the use of the geom_text function
  geom_text(data = ty[1:10,],
            aes(x = ty[1:10,1],
                y = ty[1:10,2],
                label = rownames(ty[1:10,]))) + #assigning the row names as the text labels, but could be any list of 10 character elements 
  #the 'sec.axis' arguments below create a second x and y axis to mimic the BI plot above,
  #the creators of R and the ggplot package intentionally try to discourage plots with more than 2 axes on the same plane
  #so we must make the "second" axes linear transformations of the first. here, i divide by 3 to mimic the BI plot above
  #i had to multiply the loadings data by 3 when i joined it to the scores data,
  #because plotting the raw loadings data on the 'scores' scale made the arrows too small. again, this is made intentionally difficult
  #we can change the second axes titles by changing what's given to the 'name' argument
  scale_y_continuous(limits = c(-3,3),
                     sec.axis = sec_axis(~./3, name = "Math")) +
  scale_x_continuous(limits = c(-3,3),
                     sec.axis = sec_axis(~./3, name = "Verbal")) +
  #the below is purely to make the plot look better, setting colors, typeface, etc.
  theme_classic() +
  theme(axis.text.x.top = element_text(color = "red"),
        axis.text.y.right =  element_text(color = "red"),
        plot.title = element_text(face = "bold",hjust = 0.5)) +
  geom_hline(yintercept = 0, linetype = "dotted", alpha = .4) +
  geom_vline(xintercept = 0, linetype = "dotted", alpha = .4) +
  
  #now we do loadings! referencing a subset of row vectors that correspond to the loadings data
  
  #plotting 'segments' as the line one can draw between the origin and the point
  geom_segment(data=ty[11:16,],
               aes(x = ty[11:16,1],
                   y =ty[11:16,2]),
               xend=0,
               yend=0,
               arrow = arrow(length = unit(0.03, "npc"),
                             ends = "first"),
               color = "red") + 
  #'smart labels' that won't overlap with each other
  geom_label_repel(data=ty[11:16,],
                   aes(x = ty[11:16,1],
                       y = ty[11:16,2],
                       label = rownames(ty[11:16,])),
                   label = rownames(ty[11:16,]),
                   segment.alpha = .25,
                   box.padding = unit(0.35, "lines"),
                   segment.color = "grey50") +
  #setting a title
  ggtitle("Perceptual Map\n")
#and, finally, saving to your working directory
ggsave("pca_plot_example.png", height = 8, width = 8)
