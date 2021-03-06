\name{prcomp.resamples}
\alias{prcomp.resamples}
\alias{cluster.resamples}
\alias{cluster}
\alias{plot.prcomp.resamples}
\title{
Principal Components Analysis of Resampling Results
}
\description{
Performs a principal components analysis on an object of class \code{\link{resamples}} and returns the results as an object with classes \code{prcomp.resamples} and \code{prcomp}.

}
\usage{
\method{prcomp}{resamples}(x, metric = x$metrics[1], ...)

cluster(x, ...)
\method{cluster}{resamples}(x, metric = x$metrics[1], ...)

\method{plot}{prcomp.resamples}(x, what = "scree", dims = max(2, ncol(x$rotation)), ...)

}
\arguments{
  \item{x}{
For \code{prcomp}, an object of class \code{\link{resamples}} and for \code{plot.prcomp.resamples}, an object of class  \code{plot.prcomp.resamples}
}
  \item{metric}{
a performance metric that was estimated for every resample
}
  \item{what}{
the type of plot: \code{"scree"} produces a bar chart of standard deviations, \code{"cumulative"} produces a bar chart of the cumulative percent of variance, \code{"loadings"} produces a scatterplot matrix of the loading values and \code{"components"} produces a scatterplot matrix of the PCA components
}
  \item{dims}{
The number of dimensions to plot when \code{what = "loadings"} or \code{what = "components"} 
}

  \item{\dots}{
For \code{prcomp.resamples}, options to pass to \code{\link[stats]{prcomp}}, for \code{plot.prcomp.resamples}, options to pass to Lattice objects (see Details below) and, for \code{cluster.resamples}, options to pass to \code{hclust}.
}
}
\details{
The principal components analysis treats the models as variables and the resamples are realizations of the variables. In this way, we can use PCA to "cluster" the assays and look for similarities. Most of the methods for \code{\link[stats]{prcomp}} can be used, although custom \code{print} and \code{plot} methods are used.

The plot method uses lattice graphics. When \code{what = "scree"} or \code{what = "cumulative"}, \code{\link[lattice:xyplot]{barchart}} is used.
When \code{what = "loadings"} or \code{what = "components"}, either \code{\link[lattice:xyplot]{xyplot}} or \code{\link[lattice:splom]{splom}} are used (the latter when \code{dims} > 2). Options can be passed to these methods using \code{...}.

When  \code{what = "loadings"} or \code{what = "components"}, the plots are put on a common scale so that later components are less likely to be over-interpreted. See Geladi et al. (2003) for examples of why this can be important.

For clustering, \code{\link[stats]{hclust}} is used to determine clusters of models based on the resampled performance values. 
}

\value{
For \code{prcomp.resamples}, an object with classes \code{prcomp.resamples} and \code{prcomp}. This object is the same as the object produced by \code{prcomp}, but with additional elements:
 \item{metric }{the value for the \code{metric} argument}
 \item{call }{the call}


For \code{plot.prcomp.resamples}, a Lattice object (see Details above)
}
\references{Geladi, P.; Manley, M.; and Lestander, T. (2003), "Scatter  plotting in multivariate data analysis," J. Chemometrics, 17: 503-511}

\author{
Max Kuhn}

\seealso{
\code{\link{resamples}}, \code{\link[lattice:xyplot]{barchart}}, \code{\link[lattice:xyplot]{xyplot}}, \code{\link[lattice:splom]{splom}}, \code{\link[stats]{hclust}}}

\examples{
\dontrun{
#load(url("http://topepo.github.io/caret/exampleModels.RData"))

resamps <- resamples(list(CART = rpartFit,
                          CondInfTree = ctreeFit,
                          MARS = earthFit))
resampPCA <- prcomp(resamps)

resampPCA

plot(resampPCA, what = "scree")

plot(resampPCA, what = "components")

plot(resampPCA, what = "components", dims = 2, auto.key = list(columns = 3))

clustered <- cluster(resamps)
plot(clustered)

}
}


\keyword{hplot}
