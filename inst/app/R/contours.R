### contours.R --- 
## Filename: contours.R
## Description: 
## Author: Noah Peart
## Created: Tue Feb  2 09:21:56 2016 (-0500)
## Last-Updated: Tue Feb  2 16:56:14 2016 (-0500)
##           By: Noah Peart
######################################################################
source('global.R')
library(DT)
datatable(csub, options=list(scrollX=TRUE))
datatable(cseed, options=list(scrollX=TRUE))

## Contour keys:
ckeys <- c('CONTNAM', 'STPACE')

## Convert TAG to character
cseed[, TAG := as.character(TAG)]

## Tags not uniqud by ckeys, with max of 5, or if species is included, max of 2.
ntags <- cseed[!(YRTAG %in% c(1988, 1989)), max(table(TAG)), by=ckeys]
res <- ntags[which(ntags$V1 > 1L), ]

ntags <- cseed[!(YRTAG %in% c(1988, 1989)) & is.na(ALONG), ]

dupes <- cseed[res, .(CONTNAM, STPACE, SPEC, TAG), on=ckeys]

dupes[duplicated(dupes$TAG), dupe := TRUE

## Extension growth columns:
patts <- c(
  '^EX[0-9]+',       # extension growth
  '^PEX[0-9]+',      # partial? extension
  '^MINAGE[0-9]+',   # minimum age
  '^ENOTE[0-9]+',    # notes
  '^EXCNT[0-9]+',    # ?
  '^AGE[0-9]+',      # ?
  '^D[0-9]RM[0-9]+', # distance remaining after last countable extension
  '^EXSUM[0-9]+',    # summed extension growth
  'YRREX'            # ?
)
patt <- paste(patts, collapse='|')
ecols <- grep(patt, names(cseed), value=TRUE)

## They need primary keys as well
cexgr <- cseed[, ecols, with=FALSE]
cseed[, ecols := NULL, with=FALSE]

cseed[is.na(ALONG) & is.na(PALONG), .N, by=ckeys]

hts <- '^HT[0-9]+'
cols <- grep(hts, names(cseed), value=TRUE)

