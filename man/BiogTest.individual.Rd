\name{BiogTest.individual}
\alias{BiogTest.individual}
\alias{BiogTest.sample}
\alias{plot.BiogTest}

\title{ Biogeographical null model tests }

\description{ Biogeographical null model tests for comparing rarefaction curves. }

\usage{
BiogTest.individual(x, MARGIN = 2, niter = 200, method = "sample-size", q = 0, 
trace = TRUE, powerfun = 1, log.scale = FALSE, distr = "lnorm")
BiogTest.sample(x, by = NULL, MARGIN = 2, niter = 200, method = "sample-size", 
q = 0, trace = TRUE, distr = "lnorm")
\method{plot}{BiogTest}(x, max.poly = 50, \dots)
}

\arguments{
  \item{x}{ Community data, a matrix-like object, with entries representing abundance for \code{EcoTest.individual}, or presence-absence for \code{EcoTest.sample}, or an \code{'EcoTest'} class object for \code{plot} function. }
  \item{MARGIN}{ If \code{MARGIN=1}, sampling units are rows and species are columns; if \code{MARGIN=2} (default), then species are rows and sampling units are columns. }
  \item{niter}{ Number of randomizations used for the null model hypothesis test. }
  \item{method}{ Either \code{"sample-size"} (default) or \code{"coverage"}. \code{"sample-size"} uses either abundance data (in individual-based rarefaction) or incidence data (in sample-based rarefaction), whereas \code{"coverage"} uses the estimated coverage (see Details) of either abundance or number of samples as the x-axis in the sampling curve. }
  \item{q}{ First three Hill numbers, namely species richness (\code{q = 0}), the exponential Shannon index (\code{q = 1}), and the inverse Simpson index (\code{q = 2}). }
  \item{trace}{ If trace=TRUE, information is printed during the randomization process. }
  \item{powerfun}{ By default rarefied richness is estimated for all subsample sizes, from 1 to \emph{n}, where \emph{n} is the total number of individuals in the sample. If \code{powerfun} is less than 1, it decreases the total number of subsamples as a power function of \{h{n}. }
  \item{log.scale}{ If \code{FALSE} (default), subsample sizes for rarefying community are spaced apart at regular intervals. Otherwise (\code{log.scale = TRUE}), subsample sizes are spaced apart on a log-scale. }
  \item{distr}{ Underlying species abundance distribution from which random assemblages are created by sampling to construct the null distribution. Available options include the log-normal (\code{lnorm}), geometric (\code{geom}), and broken-stick (\code{stick}) distributions. }
  \item{by}{ Factor for grouping sampling units in sample-based rarefaction. }
  \item{max.poly}{ Maximum number of polygons to draw in \code{plot} function. Each polygon represents the area between each unique pair of the \emph{K} sample rarefaction curves. }
  \item{\dots}{ Additional graphical parameters passed to plot (not used). }
}

\details{
\code{BiogTest.individual} and \code{BiogTest.sample} present randomization tests for the statistical comparison of two or more individual-based, sample-based, or coverage-based rarefaction curves. The biogeographical null hypothesis \emph{H0} is that  is that two (or more) reference samples, represented by either abundance or incidence data, were drawn randomly from different assemblages that, nonetheless, share similar species richness and species abundance distributions. 

To calculate the \code{BiogTest} statistic, \emph{Zobs}, we summed the area between all unique pairs of the \emph{K} sample rarefaction curves. If \emph{H0} is true, then \emph{Zobs} should be relatively small because all of the rarefaction curves should have similar profiles, regardless of their species composition. In the limit, if all of the rarefaction curves had an identical profile, \emph{Zobs} would equal 0. To construct the null distribution, the algorithm creates random assemblages by sampling from an underlying species abundance distribution. Of the many possible distributions which distribution should be used? The algorithm offers the possibility to choose among different underlying relative abundance distributions, including the log-normal, geometric and broken-stick distributions, although the former has some advantages, and thus its use is recommended.

The statistical parameters of the log-normal rank abundance distribution are the number of species in the assemblage and the variance of the distribution; the latter controls the differences in abundance between common and rare species. If these underlying parameters are known, then sample size effects can be estimated by random sampling of individuals from the specified distribution. However, it is very difficult to directly estimate these parameters from a sample or set of samples (O'Hara 2005). Instead, a suite of log-normal distributions is generated, that might act as a reasonable sampling universe for comparison with a set of reference samples to test the biogeographic null hypothesis. Our strategy was to specify a distribution for each of the two parameters in the log normal: species number and variance. As in a random effects model, each replicate of the null distribution reflects a single sample from a log-normal distribution in which the two model parameters were first determined by random assignment. 

For the lower boundary of species richness, the minimum possible value cannot be smaller than the maximum number of species observed in the richest single sample among a set of samples. For the upper boundary of species richness, we calculated the upper bound of the Chao1 95% confidence interval (Chao 1984) for asymptotic species richness of each sample (see \code{\link{chao1}}). The number of species in each null assemblage was then set as a random draw from a uniform distribution bounded at the low end by the maximum observed \emph{S} and bounded at the high end by the maximum upper bound of the Chao1 95% confidence interval.

For the standard deviation of the log-normal, we sampled a random uniform value between 1.1 and 33 (0.1 and 3.5 on a log scale). For empirical assemblages, standard deviations typically fall within this range (Limpert et al. 2001). Once the null assemblage was specified by selection of parameters for species richness and the standard deviation, we sampled (with replacement) the specified number of individuals for each sample in an individual-based data set. For incidence data, we sampled the observed number of species in each sampling unit, sampling species without replacement, with sample probabilities set proportional to relative abundances in the log-normal distribution. We then used the analytic formulas in Chao et al. (2014) to construct the rarefaction curves for each of the pseudosamples, simulated a distribution of \code{Zsim}, and compared it to \code{Zobs} to estimate \eqn{p(Z_{obs}|H_{0})}.

For the broken stick, the number of species in the meta-community must be known, and then a random partition is made to define the relative abundance of each species. For the geometric series, two parameters are needed: the number of species in the meta-community and a constant ratio \code{D} (\code{D}<1), which determines the abundance of the next species in the sequence. In the geometric series, \code{D} was obtained by sampling a random uniform value between 0.1 and 1. In all cases, the number of species (\code{S}), as in the log-normal distribution, was obtained by randomly drawing from a uniform distribution that was bounded at the low end by the maximum observed \code{S} and at the high end by the maximum upper bound of the 95% confidence interval for Chao1. 

To better mimic the sampling process, a negative binomial random error was added to the abundance counts every time a sample was randomly drawn from the simulated meta-community. The negative binomial distribution was used to generate realistic heterogeneity that often results from spatial clustering of individuals and other small-scale processes. The expectation \eqn{mu} of the negative binomial was represented by the abundance count of each species in the meta-community.

Analytic estimators for individual-based, sample-based, and coverage-based rarefaction on Hill numbers were derived by Chao et al. (2014), and are currently implemented in this package (see \code{link{rarefaction.individual}} and \code{link{rarefaction.sample}} functions).
}

\value{ \code{BiogTest.individual} and \code{BiogTest.sample} return an object of class \code{'BiogTest'}, basically a list with the following components:
\item{subclass}{ A character indicating the type of data used to build rarefaction curves, namely "Individual-based method" for individual-based rarefaction (abundance data), and "Sample-based method" for sample-based rarefaction (incidence data), respectively. }
\item{type}{ A character indicating the variable used for the x-axis in the sampling curve, either "Sample-size" for abundance data (in individual-based rarefaction) or incidence data (in sample-based rarefaction), or "Coverage measure" for the estimated coverage of either abundance or number of samples. }
\item{obs}{ A list of data frames, with as many components as individual samples. Each data frame contains two columns, one for either sample-size (this refers either to number of individuals in individual-based rarefaction, or to number of sampling units in sample-based rarefaction) or coverage (in coverage-based rarefaction), and another for the estimated Hill number in each observed sample. }
\item{sim}{ A list of data frames, with as many components as individual samples. Each data frame contains two columns, one for either sample-size (this refers either to number of individuals in individual-based rarefaction, or to number of sampling units in sample-based rarefaction) or coverage (in coverage-based rarefaction), and another for the estimated Hill number in each simulated sample from one artificial set of samples. }
\item{Zsim}{ A vector of length \code{niter} showing each of the cumulative areas between all unique pairs of the \code{K} simulated rarefaction curves. }
\item{Z}{ The cumulative area between all unique pairs of the \code{K} observed sample rarefaction curves. }
\item{pval}{ The probability of \code{Z} given the distribution of \code{Zsim}. Low \emph{p-values} imply that observed differences among samples in richness, and/or relative abundance are improbable if the samples were all drawn from similar assemblages regardless of differences in species composition. }
}

\references{
Cayuela, L. & Gotelli, N.J. Ecological and biogeographical null hypotheses for comparing rarefaction curves. In prep.

Chao, A. (1984). Nonparametric-estimation of the number of classes in a population. \emph{Scandinavian Journal of Statistics} 11: 265-270.

Chao, A., Gotelli, N.J., Hsieh, T.C., Sander, E.L., Ma, K.H., Colwell, R.K. & Ellison, A.M. (2014). Rarefaction and extrapolation with Hill numbers: a framework for sampling and estimation in species diversity studies. emph{Ecological Monographs} 84: 45-67.

Limpert, E., Stahel, W.A. & Abbt, M. (2001). Log-normal distributions across the sciences: keys and clues. emph{BioScience} 51: 341-352.

O'Hara, R.B. (2005). Species richness estimators: how many species can dance on the head of a pin? emph{Journal of Animal Ecology} 74: 375-386. 
}

\author{ Luis Cayuela and Nicholas J. Gotelli }

\seealso{ \code{\link{rarefaction.individual}}, \code{\link{rarefaction.sample}}, \code{\link[vegan]{rarecurve}}, \code{\link{chao1}} }

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

   # Biogeographical null model test using sample-based rarefaction curves
   # for species richness (q = 0)
   # The test should not reject the null hypothesis (p > 0.05)
   ibbiogq0 <- BiogTest.individual(df, MARGIN=2, powerfun=0.8, log.scale=TRUE)
   plot(ibbiogq0)

   # Biogeographical null model test using coverage-based rarefaction curves
   # for the exponential Shannon index (q = 1)
   ibbiogq1cov <- BiogTest.individual(df, MARGIN=2, method="coverage", q=1, 
   powerfun=0.8, log.scale=TRUE)
   plot(ibbiogq1cov)

   ## Sample-based and coverage-based rarefaction
   # Load the data
   data(Chiapas)
   Chiapas <- subset(Chiapas, Region!="El Triunfo")
   str(Chiapas)

   # Biogeographical null model test using sample-based rarefaction curves
   # for species richness (q = 0)
   sbbiogq0 <- BiogTest.sample(Chiapas[,-1], by=Chiapas[,1], MARGIN=1)
   plot(sbbiogq0)

   # Biogeographical null model test using coverage-based rarefaction curves
   # for the inverse Simpson index (q = 2)
   sbbioq2cov <- EcoTest.sample(Chiapas[,-1], by=Chiapas[,1], MARGIN=1, 
   method="coverage", q=2)
   plot(sbbioq2cov)
  }
}

\keyword{ diversity }

