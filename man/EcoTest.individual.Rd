\name{EcoTest.individual}
\alias{EcoTest.individual}
\alias{EcoTest.sample}
\alias{plot.EcoTest}

\title{ Ecological null model tests }

\description{ Ecological null model tests for comparing rarefaction curves. }

\usage{
EcoTest.individual(x, MARGIN = 2, niter = 200, method = "sample-size", q = 0, 
trace = TRUE, powerfun = 1, log.scale = FALSE)
EcoTest.sample(x, by = NULL, MARGIN = 2, niter = 200, method = "sample-size", 
q = 0, trace = TRUE)
\method{plot}{EcoTest}(x, \dots)
}

\arguments{
  \item{x}{ Community data, a matrix-like object, with entries representing abundance for \code{EcoTest.individual}, or presence-absence for \code{EcoTest.sample}, or an \code{'EcoTest'} class object for \code{plot} function. }
  \item{MARGIN}{ If \code{MARGIN=1}, sampling units are rows and species are columns; if \code{MARGIN=2} (default), then species are rows and sampling units are columns. }
  \item{niter}{ Number of randomizations used for the null model hypothesis test. }
  \item{method}{ Either \code{"sample-size"} (default) or \code{"coverage"}. \code{"sample-size"} uses either abundance data (in individual-based rarefaction) or incidence data (in sample-based rarefaction), whereas \code{"coverage"} uses the estimated coverage (see Details) of either abundance or number of samples as the x-axis in the sampling curve. }
  \item{q}{ First three Hill numbers, namely species richness (\code{q = 0}), the exponential Shannon index (\code{q = 1}), and the inverse Simpson index (\code{q = 2}). }
  \item{trace}{ If \code{trace=TRUE}, information is printed during the randomization process. }
  \item{powerfun}{ By default rarefied richness is estimated for all subsample sizes, from 1 to \emph{n}, where \emph{n} is the total number of individuals in the sample. If \code{powerfun} is less than 1, it decreases the total number of subsamples as a power function of \emph{n}. }
  \item{log.scale}{ If FALSE (default), subsample sizes for rarefying community are spaced apart at regular intervals. Otherwise (\code{log.scale = TRUE}), subsample sizes are spaced apart on a log-scale. }
  \item{by}{ Factor for grouping sampling units in sample-based rarefaction. }
 \item{\dots}{ Additional graphical parameters passed to plot (not used). }
}

\details{ 
\code{EcoTest.individual} and \code{EcoTest.sample} present randomization tests for the statistical comparison of two or more individual-based, sample-based, or coverage-based rarefaction curves. The ecological null hypothesis \emph{H0} is that two (or more) reference samples, represented by either abundance or incidence data, were both drawn from the same assemblage of \emph{N*} individuals and \emph{S} species. Therefore, any differences among the samples in species composition, species richness, or relative abundance reflect only random variation, given the number of individuals (or sampling units) in each collection. The alternative hypothesis, in the event that \emph{H0} cannot be rejected, is that the sample data were drawn from different assemblages. If \emph{H0} is true, then pooling the samples should give a composite sample that is also a (larger) random subset of the complete assemblage. It is from this pooled composite sample that we make random draws for comparison with the actual data.

To construct the \code{EcoTest} metric, we begin by plotting the expected rarefaction curves for the individual samples and for the pooled composite sample \emph{C}. Next, for each individual sample \emph{i}, we calculate the cumulative area \emph{Ai} between the sample rarefaction curve and the pooled rarefaction curve. For a set of \emph{i}=1 to \emph{K} samples, we define the observed difference index:
\deqn{Z_{obs}=\sum_{i=1}^{K}A_{i}}
Note that two identically-shaped rarefaction curves may nevertheless differ from the pooled curve. This difference can arise because species identities in the individual samples are retained in the pooled composite sample \emph{C}, which affects the shape of the pooled rarefaction curve.

The data are next reshuffled by randomly re-assigning every individual to a sample (for abundance data) or every sampling unit to a sample (for incidence data), and preserving the original sample sizes (number of individuals for abundance data and number of samples for incidence data). From this randomization, we again construct rarefaction curves and calculate \emph{Zsim} as the cumulative area between the rarefaction curves of the randomized samples and the composite rarefaction curve. This procedure is repeated many times, leading to a distribution of \emph{Zsim} values and a 95% confidence interval. The position of \emph{Zobs} in the tail of this distribution is used as an estimate of \deqn{p(Z_{obs}|H_{0})}. Large values of \emph{Zobs} relative to the simulated distribution imply that observed differences among samples in species composition, richness, and/or relative abundance are improbable if the samples were all drawn from the same assemblage.

Analytic estimators for individual-based, sample-based, and coverage-based rarefaction on Hill numbers were derived by Chao et al. (2014), and are currently implemented in this package (see \code{link{rarefaction.individual}} and \code{link{rarefaction.sample}} functions).
}

\value{ \code{EcoTest.individual} and \code{EcoTest.sample} return an object of class \code{'EcoTest'}, basically a list with the following components:
\item{subclass}{ A character indicating the type of data used to build rarefaction curves, namely "Individual-based method" for individual-based rarefaction (abundance data), and "Sample-based method" for sample-based rarefaction (incidence data), respectively. }
\item{type}{ A character indicating the variable used for the x-axis in the sampling curve, either "Sample-size" for abundance data (in individual-based rarefaction) or incidence data (in sample-based rarefaction), or "Coverage measure" for the estimated coverage of either abundance or number of samples. }
\item{obs}{ A list of data frames, with as many components as individual samples. Each data frame contains two columns, one for either sample-size (this refers either to number of individuals in individual-based rarefaction, or to number of sampling units in sample-based rarefaction) or coverage (in coverage-based rarefaction), and another for the estimated Hill number in each observed sample. }
\item{sim}{ A list of data frames, with as many components as individual samples. Each data frame contains two columns, one for either sample-size (this refers either to number of individuals in individual-based rarefaction, or to number of sampling units in sample-based rarefaction) or coverage (in coverage-based rarefaction), and another for the estimated Hill number in each simulated sample from one randomized set of samples. }
\item{pooled}{ A data frame with entries for sample-size (this refers either to number of individuals in individual-based rarefaction, or to number of sampling units in sample-based rarefaction) or coverage (in coverage-based rarefaction), and the corresponding Hill number for the composite (i.e. pooled) rarefaction curve. }
\item{Zsim}{ A vector of length \code{niter} showing each of the cumulative areas between the rarefaction curves of one randomized sample data set and the composite rarefaction curve. }
\item{Z}{ The cumulative area between the observed sample rarefaction curves and the composite rarefaction curve. }
\item{pval}{ The probability of \emph{Z} given the distribution of \emph{Zsim}. Low \emph{p-values} imply that observed differences among samples in species composition, richness, and/or relative abundance are improbable if the samples were all drawn from the same assemblage. }
}

\references{
Cayuela, L., Gotelli, N.J. & Colwell, R.K. (2015). Ecological and biogeographical null hypotheses for comparing rarefaction curves. \emph{Ecological Monographs} 85: 437-455.

Chao, A., Gotelli, N.J., Hsieh, T.C., Sander, E.L., Ma, K.H., Colwell, R.K. & Ellison, A.M. (2014). Rarefaction and extrapolation with Hill numbers: a framework for sampling and estimation in species diversity studies. emph{Ecological Monographs} 84: 45-67.
}

\author{ Luis Cayuela and Nicholas J. Gotelli }

\seealso{ \code{\link{rarefaction.individual}}, \code{\link{rarefaction.sample}}, \code{\link[vegan]{rarecurve}} }

\examples{
  \dontrun{
   ## Individual-based and coverage-based rarefaction
   # Simulate a community with number of species (spn) and evenness randomly selected

   spn <- round(runif(1, 10, 200))
   evenness <- runif(1, log(1.1), log(33))
   com <- round(rlnorm(spn, 2, evenness))
   Ss <- round(runif(1, 50, 500))
   sample1 <- sample(paste("sp",1:length(com)), rpois(1, Ss), replace=TRUE, prob=com)
   sample1 <- data.frame(table(sample1))
   colnames(sample1) <- c("species", "sample1")
   sample2 <- sample(paste("sp",1:length(com)), rpois(1, Ss), replace=TRUE, prob=com)
   sample2 <- data.frame(table(sample2))
   colnames(sample2) <- c("species", "sample2")
   df <- merge(sample1, sample2, by="species", all=TRUE)
   rownames(df) <- df$species
   df[is.na(df)] <- 0
   df <- df[,2:3]

   # Ecological null model test using sample-based rarefaction curves
   # for species richness (q = 0)
   # The test should not reject the null hypothesis in most cases (p > 0.05)
   ibecoq0 <- EcoTest.individual(df, MARGIN=2, powerfun=0.8, log.scale=TRUE)
   plot(ibecoq0)

   # Ecological null model test using coverage-based rarefaction curves
   # for the exponential Shannon index (q = 1)
   ibecoq1cov <- EcoTest.individual(df, MARGIN=2, method="coverage", 
   q=1, powerfun=0.8, log.scale=TRUE)
   plot(ibecoq1cov)

   ## Sample-based and coverage-based rarefaction
   # Load the data
   data(Chiapas)
   Chiapas <- subset(Chiapas, Region!="El Triunfo")
   str(Chiapas)

   # Ecological null model test using sample-based rarefaction curves
   # for species richness (q = 0)
   sbecoq0 <- EcoTest.sample(Chiapas[,-1], by=Chiapas[,1], MARGIN=1)
   plot(sbecoq0)

   # Ecological null model test using coverage-based rarefaction curves
   # for the inverse Simpson index (q = 2)
   sbecoq2cov <- EcoTest.sample(Chiapas[,-1], by=Chiapas[,1], 
   MARGIN=1, method="coverage", q=2)
   plot(sbecoq2cov)
  }
}

\keyword{ diversity }
