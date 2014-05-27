\name{Chiapas}
\alias{Chiapas}
\docType{data}
\title{ Tree abundance in tropical montane forest plots }

\description{ Tree abundance in 224 0.1-ha plots in three montane cloud forest regions of Chiapas, Mexico. }

\usage{ data(Chiapas) }

\format{ The \code{Chiapas} data set contains data for 375 tree species (columns) from 224 0.1-ha plots (rows). The first column is a factor with three levels with the name of the region.
}

\details{
This data set characterizes tree communities from tropical montane cloud forests in three regions of the state of Chiapas, Mexico: El Triunfo Biosphere Reserve in Sierra Madre (100 plots), the Highlands (38 plots), and the Northern Mountains (86 plots). For these plots, incidence records were based on trees exceeding 5 cm in diameter at breast height. Data were obtained from the BIOTREE-NET website (www.biotreenet.com). Species names were standardized and typographical errors were corrected using The Plant List through the \pkg{Taxostand} package (Cayuela et al. 2012). Distance between regions ranged from ca. 50 kms (the Highlands and Northern Mountains) to ca. 250 kms (El Triunfo and Northern Mountains).
}

\source{ \url{http://portal.biotreenet.com} }

\references{
Cayuela, L., Golicher, D.J., Rey Benayas, J.M., Gonzalez-Espinosa, M. & Ramirez-Marcial, N. (2006). Fragmentation, disturbance and tree diversity conservation in tropical montane forests. \emph{Journal of Applied Ecology} 43: 1172-1181.
Cayuela, L., Granzow-de la Cerda, I., Albuquerque, F.S., & Golicher, J.D. (2012). Taxonstand: An R package for species names standardisation in vegetation databases. \emph{Methods in Ecology and Evolution} 3(6): 1078-1083.
Ramirez-Marcial, N., Gonzalez-Espinosa, M. & Williams-Linera, G. (2001). Anthropogenic disturbance and tree diversity in montane rain forests in Chiapas, Mexico. \emph{Forest Ecology and Management} 154(1): 311-326.
}

\examples{
   data(Chiapas)
   str(Chiapas)
}

\keyword{ datasets }
