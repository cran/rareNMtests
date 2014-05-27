\name{chao1}
\alias{chao1}
\title{Computes the Chao 1 species richness estimator}
\description{
   Computes the Chao 1 richness estimator, its estimated variance, and the corresponding 95% confidence intervals. 
}
\usage{
   chao1(x)
}
\arguments{
  \item{x}{Vector of species abundances.}
}
\details{
   Different equations are used to compute the classic Chao1 richness estimator, its estimated variance, and the corresponding 95% confidence intervals, depending on the number of singletons and doubletons in abundance-based data.
}
\value{
   A data frame with five columns including the observed number of species (Sobs), the estimated number of species with the Chao 1 estimator (S.chao1), the estimated variance (var), and the upper and lower 95% confidence intervals (low95, upp95).
}
\references{
   Chao, A. (1987). Estimating the population size for capture-recapture data with unequal catchability. \emph{Biometrics} 43, 783-791. 
}
\author{
   Luis Cayuela
}
\seealso{
   \code{\link[vegan]{specpool}}
}
\examples{
   abund <- c(19, 12, 7, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
   print(chao1(abund))
}
\keyword{ biodiversity }
\keyword{ species richness }
