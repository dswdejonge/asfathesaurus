#' Aquatic Sciences and Fisheries Thesaurus
#'
#' This database is a digitized version of the ASFA thesaurus.
#' This thesaurus contains descriptors used in the
#' Aquatic Sciences and Fisheries Information System
#' and is published by the Food and Agriculture Organization
#' of the United Nations (FAO).
#' It contains synonyms of different terms used in ocean science,
#' and can be used as reference material for standardized use of terms.
#'
#' @format A data frame with three variables: \code{Descriptor}, \code{Relation},
#' and \code{Definition}:
#' \describe{
#'   \item{Descriptor}{A descriptor (term/tag) as used in the ASFA information system.}
#'   \item{Relation}{Indicator of relationship of the descriptor with the definition.
#'     \itemize{
#'     \item{\code{SN} is Scope Note, the definition is a small comment about the descriptor;}
#'     \item{\code{USE} means the term in the \code{Definition} column is preferred over the descriptor;}
#'     \item{\code{UF} is Use For and is the reciprocal of \code{USE}, the descriptor is preferred over the
#'     term in the \code{Definition} column;}
#'     \item{\code{BT} is Broader Term, the term in the \code{Definition} column is a broader valid descriptor;}
#'     \item{\code{NT} is Narrower Term, the term in the \code{Definition} column is a narrower valid descriptor;}
#'     \item{\code{RT} is Relation Term, the term in the \code{Definition} column is related to the descriptor.}
#'   }}
#'   \item{Definition}{Comment or related term as indicated by the \code{Relation} column.}
#' }
#' @section License:
#' CC BY-NC-SA 3.0 IGO (https://creativecommons.org/licenses/by-nc-sa/3.0/igo/legalcode). This rendition of the ASFA thesaurus was not created by the Food and Agriculture Organization of the United Nations (FAO).
#' FAO is not responsible for the content or accuracy of this translation. The original edition shall be the authoritative edition.
#' @details For rules and conventions please refer to the original ASFA thesaurus PDF publication.
#' @source FAO. 2019. Aquatic Sciences and Fisheries Information System: Aquatic Sciences and Fisheries Thesaurus − Descriptors used in the Aquatic Sciences and Fisheries Information System. ASFIS-6 (Rev. 4). Rome, FAO.
#' \link{http://www.fao.org/3/k5032e/k5032e00.htm}
"asfathesaurus"
