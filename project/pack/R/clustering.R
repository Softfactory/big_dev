matrix <-read.table('')

head(iris)
plot(iris[,c(3,4)], main="Iris by Petal", col=factor(iris$Species))
plot(iris[,c(1,2)], main="Iris by Sepal", col=factor(iris$Species))

#### 주성분 분석 (PCA) ####
#어떤 변수가 그룹을 잘 분리하게 될지 판단하기 위해 PCA 수행
irispca <- princomp(iris[,1:4], cor=TRUE, scores=TRUE)
summary(irispca)
irispca$loadings
irispca$scores

##주성분을 도표화
screeplot (irispca)
#Comp.1 이 주성분임.
plot(irispca,type="lines")
biplot(irispca)


#### Hierarchy Clustering ####
# Ward Hierarchical Clustering
d <- dist(irispca$scores[,1:4], method = "euclidean") # distance matrix
fit.stat <- hclust(d, method="ward")
plot(fit.stat) # display dendogram
groups <- cutree(fit.stat, k=5) # cut tree into 5 clusters
# draw dendogram with red borders around the 5 clusters
rect.hclust(fit.stat, k=5, border="red")

# install.packages('amap')
library(amap)
#help(hcluster)
fit.amp<-hclusterpar (irispca$scores[,1:4], method="euclidean", link="ward")
plot(fit.amp)
summary(fit.amp)

# install.packages('pvclust')
library(pvclust)
fit.pv <- pvclust(irispca$scores[,1:4], method.hclust="ward",
               method.dist="euclidean")
plot(fit.pv) # dendogram with p values
# add rectangles around groups highly supported by the data
pvrect(fit.pv, alpha=.95)



#### K-Means Cluster Analysis ####
cldata <-iris[,1:4]
fit.kmeans <- kmeans(cldata, 5) # 5 cluster solution
# get cluster means
aggregate(cldata,by=list(fit.kmeans$cluster),FUN=mean)
# append cluster assignment
cldata <- data.frame(cldata, fit.kmeans$cluster)

names(fit.kmeans)

plot(cldata[,3:4], main="Iris by Petal", col=cldata$fit.kmeans.cluster)
plot(cldata[,1:2], main="Iris by Petal", col=cldata$fit.kmeans.cluster)


#### Model Based Clustering ####
# install.packages('mclust')
cldata <-iris[,1:4]
library(mclust)
fit.mclust <- Mclust(cldata)
plot(fit.mclust ) # plot results
summary(fit.mclust ) # display the best model

# Cluster Plot against 1st 2 principal components
# vary parameters for most readable graph
library(cluster)
clusplot(iris[,1:2], fit.kmeans$cluster, color=TRUE, shade=TRUE,
         labels=2, lines=0)


# Centroid Plot against 1st 2 discriminant functions
install.packages('fpc')
library(fpc)
plotcluster(iris[,1:4], fit.kmeans$cluster)


#### Fuzzy clustering ####
library(cluster)
#the default 2 gives complete fuzziness and fails here, and lower values give crisper class.
fit.fuzzy <- fanny(iris[,1:4], 5, memb.exp=1.7)
names(fit.fuzzy)




#그래프화 하기 곤란하다.
#This uses stars function (with many optional parameters) to show the probability
# and draws a convex hull of the crisp classification.
# The size of the sector shows the probability of the class membership, and in clear cases,
# one of the segments is dominant
ordiplot(iris[,1:4], dis="si")
ordiplot(ord, dis="si", type="n")
stars(cfuz$membership, locatio=ord, draw.segm=TRUE, add=TRUE, scale=FALSE, len=0.1)
ordihull(ord, cfuz$clustering, col="blue")
# comparing 2 cluster solutions
??ordiplot





library(fpc)
cluster.stats(d, fit1$cluster, fit2$cluster)







(y<-iris[,5])
(tr.idx<-sample(length(y), 75))
iris

n <- 100
k <- 7
religion <- sample(1:k, n, TRUE)
names(religion) <- outer(LETTERS, LETTERS, paste0)[1:n]
# Position of the groups
x <- runif(k)
y <- runif(k)
?system

# Plot
library(wordcloud)
textplot(
  x[religion], y[religion], names(religion),
  xlim=c(0,1), ylim=c(0,1), axes=FALSE, xlab="", ylab=""
)



library(igraph)
A <- outer( religion, religion, `==` )
g <- graph.adjacency(A)
plot(g)
plot(minimum.spanning.tree(g))


??rgl

library(rgl)
plot3d(irispca$scores[,1:3], col=factor(iris$Species))







# Prepare Data
mydata <- na.omit(mydata) # listwise deletion of missing
mydata <- scale(mydata) # standardize variables
# Determine number of clusters
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")

?na.omit
?scale
?apply






