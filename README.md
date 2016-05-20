
# Coursera: Exploratory Data Analysis

JHU  

## [Assignment #1: Plots](assignment1/)
## [Assignment #2: More Plots](assignment2/)


## Tufte's Principles of Analytic Graphics

1. Show Comparisons
    * for context,
    * easier to understand
2. Show Causality / Explanation / Systematic Mechanism
3. Show Multivariate data (3 or 4 vars)
4. Integrate the Evidence.  Information rich graphics
    * words, numbers, images, diagrams, into a single graphic/display
5. Describe and document the evidence with appropriate labels, scales.
    * a single graphic should tell a full credible story
6. Content is king



## Simple Summaries of Data

### 1 Dimension

* 5-Number Summary
* Boxplots
* Histogram
* Density plot
* Barplot

### 2 Dimension

* Multiple / overlaid 1-D plots (lattice / ggplot2)
* Scatterplots
* Smooth scatterplots

### 2+ Dimensions

* Multiple / overlaid 2-D plots; coplots
* Use color / size / shape to add dimensions
* Spinning plots
* 3-D plots (not as useful)



## Hierarchical clustering / k-means clustering

* define "distance" (i.e how "close" are two measurements):
    * euclidean - continuous 
    * corrleation similary - continuous 
    * manhattan distance - binary
* algo:
    * take closest two points
    * merge into cluster
        * merging approaches: 
            * "average" (use "center of gravity") 
            * "complete" (compare the two furthest points from each cluster)
    * cluster has its own point value (avg of the merged)
    * repeat


R Example:

    # gives pair-wise distances between all points
    dist(data.frame)

    # produces dendrogram
    hclust(dist)

    heatmap(matrix)



### k-means clustering


* initial guess where the cluster "centroids" are
* cluster points based on centroids
* recalculate centroids
* repeat

R Example: 

    df <- data.frame(x, y)
    kmeansObj <- kmeans(df, centers=3)
    par(mar=repo(0.2,4))
    plot(x,y, col=kmeansObj$cluster, pch=19, cex=2)
    points(kmeansObj$centers, col=1:3, pch=3, cex=3, lwd=3)


## Principal Component Analysis and Singular Value Decomposition

* Given multivariate variables X1, X2, ... Xn...
* some variables will be correlated with each other (e.g. height and weight would be correlated)

1. Find a new set (subset?) of multivariate variables 
    * that are uncorrelated
    * and "explain" as much variance "as possible"
    * this is a statistical problem, solved with **principal compnent analysis**
2. Find the best lower-rank matrix that "explains" the original data
    * this is a data compression problem, solved with **singular value decomposition**
    * SVD = "matrix decomposition" 
    * X = UDVt
    * X is a matrix with each variable in a column and each observation in a row
    * U: columns are orthogonal (left singular vectors)
    * V: columns are orthogonal (right singular vectors)
    * D: diagonal matrix (singular values)
    * the PCA principal components are equal to the right singular values (V) 
    * must first z-scale the variables


R Example:

    svd(scale(dataMatrixOrdered))
    prcomp(dataMatrixOrdered, scale=TRUE)
    # basically same thing as svd


Related:

* Factor analysis
* Independent components analysis
* Latent semantic analysis
