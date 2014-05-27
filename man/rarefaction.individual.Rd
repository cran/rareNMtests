\name{rarefaction.individual}
\alias{rarefaction.individual}
\alias{rarefaction.sample}

\title{ Rarefied species richness with Hill numbers }

\description{ Individual-based (abundance data), sample-based (incidence data), and coveraged-based (based on both abundance and incidence data) rarefaction with Hill numbers. }

\usage{
rarefaction.individual(x, method = "sample-size", q = 0, powerfun = 1, 
log.scale = FALSE, inds = NULL)
rarefaction.sample(x, method = "sample-size", q = 0)
}

\arguments{
  \item{x}{ Community data, a vector (for individual-based rarefaction) or a matrix-like object (for sample-based rarefaction). }
  \item{method}{ Either \code{"sample-size"} (default) or \code{"coverage"}. \code{"sample-size"} uses either abundance data (in individual-based rarefaction) or incidence data (in sample-based rarefaction), whereas \code{"coverage"} uses the estimated coverage (see Details) of either abundance or number of samples as the x-axis in the sampling curve. } 
  \item{q}{ First three Hill numbers, namely species richness (\code{q = 0}), the exponential Shannon index (\code{q = 1}), and the inverse Simpson index (\code{q = 2}). }
  \item{powerfun}{ By default rarefied richness is estimated for all subsample sizes, from 1 to \emph{n}, where \emph{n} is the total number of individuals in the sample. If \code{powerfun} is less than 1, it decreases the total number of subsamples as a power function of \emph{n}. }
  \item{log.scale}{ If \code{FALSE} (default), subsample sizes for rarefying community are spaced apart at regular intervals. Otherwise (\code{log.scale = TRUE}), subsample sizes are spaced apart on a log-scale. }
  \item{inds}{ Subsample size for rarefying community, either a single value or a vector. If not specified (default), rarefaction is calculated for all subsample sizes. }
}

\details{
Consider a complete assemblage for which all species and their relative abundance are known. In this complete assemblage, there are \emph{i}=1 to \emph{S} species and \code{N*} total individuals, with \code{Ni} individuals of species \code{i}. For individual-based (abundance) data, the reference sample consists of \code{n} individuals drawn at random from \code{N*}, with \code{Sobs} species present, each represented by \code{Xi} individuals. Individual-based data is represented as a single vector of length \code{Sobs}, the elements of which are the observed abundances \code{Xi}. For sample-based (incidence) data, the reference sample consists of a set of \code{R} standardized sampling units, such as traps, plots, transect lines, etc. Within each of these sampling units, the presence (1) or absence (0) of each species are the required data, even though abundance data may have been collected. Sample-based incidence data can be represented as a single matrix, with \code{i}=1 to \code{R} rows and \code{j}=1 to \code{Sobs} columns, and entries \code{Wij}=1 or \code{Wij}=0 to indicate the presence or absence of species \code{j} in sampling unit \code{i}. 

In the past, rarefaction curves have been estimated by repeated subsampling, but it is no longer necessary. Analytic estimators for individual-based, sample-based, and coverage-based rarefaction on Hill numbers were derived by Chao et al. (2014). In standard rarefaction curves the x-axis is either the abundance (individual-based) or number of samples (sample-based). Additionally, the x-axis can also be the estimated coverage of either abundance or number of samples. Coverage is defined as the proportion of total individuals or samples from the complete assemblage that is represented by the species present in the sample or subset of samples (Chao and Jost 2012).

Functions \code{rarefaction.individual} and \code{rarefaction.sample} rarefies a series of diversity indices known as Hill numbers (Hill 1973), which can be algebraically transformed into more familiar diversity indices. The order \code{q}  of the Hill number determines the weighting given to more common species, with species richness defined by \code{q}=0. Other Hill numbers are the exponential Shannon index (\code{q}=1), and the inverse Simpson index (\code{q}=2).

By default, rarefaction is estimated for all subsample sizes, from 1 to \code{n} in individual-based rarefaction, or from 1 to \code{R} in sample-based rarefaction, where \code{n} is the total number of individuals in the sample, and \code{R} is the total number of sampling units, respectively. In individual-based rarefaction, computation of Hill numbers for different subsample sizes can be very time consuming when total number of individuals, \code{n}, is high (e.g. > 1000) to extremely high (e.g. > 10000). To reduce computation time, one can select a given number of subsample sizes by setting \code{powerfun} below 1. This decreases the total number of subsamples as a power function of \code{n}. Subsample sizes can be spaced apart at regular intervals if \code{log.scale=FALSE}, or at log-intervals if \code{log.scale=TRUE}. This allows getting the entire rarefaction curve profile at faster speed. It is not advisable to set the value of \code{powerfun} below 0.5, and recommended values are between 0.6 and 0.8.
}

\value{ A data frame with entries for sample-size (this refers either to number of individuals in individual-based rarefaction, or to number of sampling units in sample-based rarefaction) or coverage (in coverage-based rarefaction), and the corresponding Hill number. }

\references{
Chao, A., Gotelli, N.J., Hsieh, T.C., Sander, E.L., Ma, K.H., Colwell, R.K. & Ellison, A.M. (2014). Rarefaction and extrapolation with Hill numbers: a framework for sampling and estimation in species diversity studies. emph{Ecological Monographs} 84: 45-67.

Chao, A. & Jost, J. (2012). Coverage-based rarefaction and extrapolation: standardizing samples by completeness rather than size. emph{Ecology} 93: 2533-2547.

Hill, M.O. (1973). Diversity and evenness: a unifying notation and its consequences. emph{Ecology} 54: 427-432.
}

\author{ Luis Cayuela and Nicholas J. Gotelli }

\seealso{ \code{\link[vegan]{rarecurve}} }

\examples{
  \dontrun{
   ## Individual-based and coverage-based rarefaction
   # Simulate a community with number of species (sr) and evenness randomly selected
   spn <- rlnorm(runif(1, 10, 200))
   evenness <- runif(1, log(1.1), log(33))
   com <- round(rlnorm(spn, 3, evenness))
   # Sample the community (with sample size n = 500 individuals)
   sample1 <- sample(paste("sp",1:length(com)), 500, replace=TRUE, prob=com)
   sample1 <- table(sample1)

   # Get the individual-based and coverage-based rarefaction curves for different Hill numbers
   ibr.q0 <- rarefaction.individual(sample1)
   ibr.q1 <- rarefaction.individual(sample1, q=1)
   ibr.q2 <- rarefaction.individual(sample1, q=2)
   ibr.q0.cov <- rarefaction.individual(sample1, method="coverage")
   ibr.q1.cov <- rarefaction.individual(sample1, q=1, method="coverage")
   ibr.q2.cov <- rarefaction.individual(sample1, q=2, method="coverage")

   # Plot the results
   par(mfcol=c(1,2))
   plot(ibr.q0[,1], ibr.q0[,2], lwd=2, xlab="Number of individuals", ylab="Hill numbers",
   type="l", main="Individual-based rarefaction")
   lines(ibr.q1[,1], ibr.q1[,2], lwd=2, lty=2)
   lines(ibr.q2[,1], ibr.q2[,2], lwd=2, lty=3)
   legend("bottomright", lty=c(1,2,3), lwd=2, legend=c("q = 0", "q = 1", "q = 2"), cex=1.2)
   plot(ibr.q0.cov[,1], ibr.q0.cov[,2], lwd=2, xlab="Coverage", ylab="Hill numbers",
   type="l", main="Coverage-based rarefaction")
   lines(ibr.q1.cov[,1], ibr.q1.cov[,2], lwd=2, lty=2)
   lines(ibr.q2.cov[,1], ibr.q2.cov[,2], lwd=2, lty=3)
   legend("topleft", lty=c(1,2,3), lwd=2, legend=c("q = 0", "q = 1", "q = 2"), cex=1.2)

   ## Sample-based and coverage-based rarefaction
   # Load the data
   data(Chiapas)
   Chiapas <- subset(Chiapas, Region=="El Triunfo")
   str(Chiapas)

   # Get sample-based and coverage-based rarefaction curves for different Hill numbers
   sbr.q0 <- rarefaction.sample(Chiapas[,-1])
   sbr.q1 <- rarefaction.sample(Chiapas[,-1], q=1)
   sbr.q2 <- rarefaction.sample(Chiapas[,-1], q=2)
   sbr.q0.cov <- rarefaction.sample(Chiapas[,-1], method="coverage")
   sbr.q1.cov <- rarefaction.sample(Chiapas[,-1], q=1, method="coverage")
   sbr.q2.cov <- rarefaction.sample(Chiapas[,-1], q=2, method="coverage")

   # Plot the results
   par(mfcol=c(1,2))
   plot(sbr.q0[,1], sbr.q0[,2], lwd=2, xlab="Sampling units", ylab="Hill numbers",
   type="l", main="Sample-based rarefaction")
   lines(sbr.q1[,1], sbr.q1[,2], lwd=2, lty=2)
   lines(sbr.q2[,1], sbr.q2[,2], lwd=2, lty=3)
   legend("bottomright", lty=c(1,2,3), lwd=2, legend=c("q = 0", "q = 1", "q = 2"), cex=1.2)
   plot(sbr.q0.cov[,1], sbr.q0.cov[,2], lwd=2, xlab="Coverage", ylab="Hill numbers",
   type="l", main="Coverage-based rarefaction")
   lines(sbr.q1.cov[,1], sbr.q1.cov[,2], lwd=2, lty=2)
   lines(sbr.q2.cov[,1], sbr.q2.cov[,2], lwd=2, lty=3)
   legend("topleft", lty=c(1,2,3), lwd=2, legend=c("q = 0", "q = 1", "q = 2"), cex=1.2)
  }
}

\keyword{ diversity }
