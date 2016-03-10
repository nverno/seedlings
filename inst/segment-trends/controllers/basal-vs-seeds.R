### basal-vs-seeds.R --- 
## Filename: basal-vs-seeds.R
## Description: Basal area estimates (prims) vs. seedling counts
## Author: Noah Peart
## Created: Wed Mar  9 16:22:22 2016 (-0500)
## Last-Updated: Wed Mar  9 23:27:43 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: "ba"

## Looking at 1999 only at first
## Total basal area, basal area by species for plots
## prismSpec, prismTotal, seedSpec
baDat <- reactive({
  yr <- as.integer(input$baYear)
  ba <- prismSpec[YEAR == yr]
  ss <- seedSpec[YEAR == yr][ba, on=c(pid, consts, "SPEC", "YEAR")][!is.na(COUNT)]
  ss[, ELEVCL := factor(ELEVCL, levels=c("L", "M", "H"), ordered=TRUE)]
  ss[, BATOT := sum(BA), by=pid]
  ss[, CTOT := sum(COUNT, na.rm=TRUE), by=pid]
  ss[, ELEVCL := factor(ELEVCL, levels=c("L","M","H"), ordered=TRUE)]
})

output$baTotal <- renderPlot({
  ## xyplot(COUNT ~ BA | ELEVCL + ASPCL, data=ss[!is.na(COUNT)], type=c("p", "smooth"),
  ##   outer=TRUE)
  coplot(COUNT ~ BA | ELEVCL + ASPCL, data=baDat()[!is.na(COUNT)], panel=panel.smooth, 
    bar.bg=c(fac="light green"))
  ## main="Seedling (<100) Counts by Basal Area(prisms)\nConditioned on Elev. and Asp. Class")
})

coplot(COUNT ~ BA | ELEVCL + ASPCL, data=sstot[!is.na(COUNT)], panel=panel.smooth, 
  bar.bg=c(fac="light green"))

ggplot(sstot[!is.na(COUNT)], aes(BA, COUNT, color=SPEC)) +
  geom_point() +
  geom_smooth(se=FALSE, method="lm") +
  facet_grid(ELEVCL ~ ASPCL) +
  scale_color_viridis(discrete=TRUE)

## Species seedling count vs total basal area
ggplot(sstot[SPEC=="BECO"], aes(BA, COUNT)) +
  geom_point() + theme_bw() +
  geom_smooth(method="lm", se=FALSE) +
  facet_grid(ASPCL ~ ELEVCL) 

  ggtitle(sprintf("% Seedling Count vs Total Basal Area (%g)", input$baSpec, input$baYear))

## Species seedling count vs basal area of species adults
dat <- melt(ss, measure.vars=c("BA", "BATOT"), variable.name="BATYPE",
  value.name="BA")

ggplot(dat[SPEC=="BECO" & !is.na(COUNT)], aes(COUNT, BA, color=BATYPE)) +
  geom_point() + theme_bw() +
  geom_smooth(method="lm", se=FALSE) +
  facet_grid(ASPCL ~ ELEVCL) +
  scale_color_viridis("Basal Area", label=c("Species BA", "Total BA"), 
    discrete=TRUE) +
  xlab("Seedling Count") + ylab("Basal Area (prisms)")
  ## ggtitle(sprintf("% Seedling Count vs Total Basal Area (%g)", input$baSpec, input$baYear))

## Species %BA vs. Species %seedling
ggplot(ss[SPEC == "BECO"], aes(COUNT/CTOT, BA/BATOT)) +
  geom_point() + theme_bw() +
  geom_smooth(se=FALSE, method="lm") +
  ylab(sprintf("%s BA / Total BA", "BECO")) +
  xlab(sprintf("%s Seedlings / Total Seedlings", "BECO")) +
  facet_grid(ASPCL ~ ELEVCL)

## Look at the plots where BECO has highest percentage of seedling counts
dat <- ss[SPEC == "BECO"][order(COUNT/CTOT, decreasing=TRUE)]
avgcov <- copy(cover)
avgcov[YEAR==1999, (ground) := colMeans(.SD, na.rm=TRUE), by=pid, .SDcols=ground]

sdat <- cover[YEAR==1999][dat, on=intersect(names(dat), names(cover))][
  order(COUNT/CTOT, decreasing=TRUE)]


## CII by spec
ids <- seeds[!is.na(CII), ]
tst <- copy(seeds)
tst[, CII := mean(CII, na.rm=TRUE), by=ID]

dev.new()
ggplot(tst[YEAR==1999 & HT < 20, ], aes(SPEC, CII)) +
  geom_violin() + ylim(1, 4)

dev.new()
ggplot(data=tst[YEAR==1999 & HT > 20 & HT <=100, ]) +
  geom_violin(aes(SPEC, CII)) + ylim(1, 4)

dat <- seeds[, .(MCII=mean(CII, na.rm=TRUE)), by=c(pid, "YEAR", "SPEC")][!is.na(MCII)]
tst <- dat[CONTNAM=="HE1080" & STPACE==20, ]

gplot(dat, aes(paste0(CONTNAM, STPACE, sep="_"), MCII, color=SPEC, group=SPEC)) +
  geom_line() + xlab("Plot") +
  theme(axis.text.x = element_text(angle=90))

library(d3heatmap)

subs[YEAR == 1999, ]

ggplot(data=tst[YEAR==1999 & HT > 100, ]) +
  geom_violin(aes(SPEC, CII)) + ylim(1, 4) +
  facet_grid(~ ELEVCL)
