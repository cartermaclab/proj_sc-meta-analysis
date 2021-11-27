######################################################################
## Analysis script for the paper:                                   ##
## "Meta-analytic findings of the self-controlled motor learning    ##
## literature:Underpowered, biased, and lacking evidential value"   ##
## -- Mckay, Yantha, Hussien, Carter, and Ste-Marie                 ##
##                                                                  ##
## Created by Brad McKay (bradmckay8 [at] gmail [dot] com)          ##
######################################################################


# Required libraries (see lines 23-26 for information on having these
# packages automatically installed if you do not already have them on
# your machine)
library(tidyverse)
library(dmetar)
library(meta)
library(metafor)
library(RColorBrewer)
library(robvis)
library(weightr)
library(zcurve)


# The code below will check whether the required packages are already
# installed. If not installed, then it will install it and load it
# for you. To run the code, uncomment from lines 28-38 and lines 40-46.

# CRAN packages
# pkgs = c("devtools", "tidyverse", "metafor", "meta", "weightr", "robvis")
# pkgs_check <- lapply(
#   pkgs,
#   FUN = function(x) {
#     if (!require(x, character.only = TRUE)) {
#       install.packages(x, dependencies = TRUE)
#       library(x, character.only = TRUE)
#     }
#   }
# )

# Github packages
# if (!require(dmetar)) {
#   devtools::install_github("MathiasHarrer/dmetar")
#   library(dmetar)
# } else {
#     library(dmetar)
#   }

#--------------------------

# Import main dataset
data <- read_csv("data/data.csv")

# Exclude subgroups that have been collapsed into single effect sizes
dat <- data[-c(81,82),]


# Create columns with average n per group
dat$n1 <- dat$N/2
dat$n2 <- dat$N/2

# Turn effect size data into escal object
dat <- escalc(measure = "SMD", yi = ret_g, vi = ret_v, n1i = n1, n2i = n2,  data = dat)

# Calculate p-values for z-curve analysis
dat$pval <- summary(dat)$pval

# Screen for influential cases
res <- rma(ret_g, ret_v, data = dat)
inf <- influence(res)

# View plots of influence diagnostics and identify influential cases
plot(inf, dfb = TRUE)
print(inf)

# Remove influential cases
mydata <- dat[-c(50,56),]

# calculate total N from primary model

nprime <-
  mydata %>%
  filter_at(vars(starts_with("ret")), any_vars(!is.na(.)))

N = sum(nprime$N)


# Fit naive random effects model to retention data
rma(ret_g, ret_v, data = mydata)

# Test if moderators account for significant amount of heterogeneity
## Setting
rma(ret_g,ret_v, mods = ~factor(setting), data = mydata)
## Compensation
rma(ret_g,ret_v, mods = ~factor(comp), data = mydata)
## Subpopulation
rma(ret_g,ret_v, mods = ~factor(subpop), data = mydata)
## Retention interval
rma(ret_g,ret_v, mods = ~factor(interval), data = mydata)
## Publication status
rma(ret_g,ret_v, mods = ~factor(pub), data = mydata)
## To test choice-type moderator exclude collapsed effects from data
## and re-remove influential cases
mod <- data[-c(50,56,83),]
rma(ret_g,ret_v, mods = ~factor(choice), data = mod)

# Fit weight-function model
x <- mydata$ret_g
v <- mydata$ret_v
weightfunct(x,v)


# Sensitivity analyses
# Conduct z-curve analysis
set.seed(9293)
retp <- dplyr::filter(mydata, mydata$pval != "NA")
pp <- retp$pval
zed <- zcurve(p = pp)
summary(zed)

## Fit PEESE meta-regression
peese <- lm(x~v, weights = 1/v)
summary(peese)

## Estimate effect size with p-curve
## Remove studies with missing data
pce <- mydata[-c(5,13,14,15,16,17,18,19,26,27,31,36,39,42,43,44,46,49,55,
                 56,59,60,61,66,67,72,77,80),]
ret <- metagen(ret_g, ret_se, data = pce)
pcurve(ret, effect.estimation = TRUE, N = pce$N)
pcurve(ret, N = pce$N)

# Exploratory analysis of pre-registered experiments
# Import dataset
preregrma <- read_csv("data/preregrma.csv")

# Fit random effects model
rma(g, v, data = preregrma)


## Exploratory analysis of transfer tests
# Fit naive random effects model to transfer data
tran <- rma(tra_g, tra_v, data = dat)
tran # view results

# Fit weight function model to transfer data
tg <- dat$tra_g
tv <- dat$tra_v
weightfunct(tg, tv)

#--------------------------

# Figures
## Figure 1: Number of experiments that meet inclusion
source("scripts/fig1.R")
fig1_plot

## Figure 2: Risk of bias figure
data_rob1 <- read.csv("data/rob_dat.csv")

robvis::rob_summary(data = data_rob1, tool = "ROB1",
                    overall = FALSE, weighted = FALSE,
                    colour = c("#1B9E77","#D95F02","#666666"))

## Figure 3: Forest plot
## Run mixed-effects analysis with publication moderator
scm <- rma(ret_g, ret_v, mods = ~(pub), data = mydata, slab =
             paste(Author, Year, sep = ", "), measure = "SMD")
forest(scm, order = "fit", rows = c(-1:14, 20:83), addfit = FALSE, ylim = c(-7, 60), cex = .8)
par(font = 2) # Bold font
# Values for labels will depend on size of plots pane
text(5.75, 59, "Hedges' g [95%CI]", pos = 4) # Label column
text(-7.75, 59, "Author(s) and Year", pos = 4) # Label column
text(4.3, -7, "Favours Self-Control") # Label directions of x-axis
text(-2, -7, "Favours Yoked") # Label directions of x-axis
par(font = 4)# bold italic font
text(-7.75, c(56.75, 12), pos = 4, c("Published Experiments", "Unpublished Experiments")) # Title for unpublished studies

res.o <- rma(ret_g, ret_v, data = mydata)
res.u <- rma(ret_g, ret_v, subset = (pub == "n"), data = mydata)
res.p <- rma(ret_g, ret_v, subset = (pub == "y"), data = mydata)

addpoly(res.p, row = 14, cex = .8, mlab = "RE Model for Published Subgroup")
addpoly(res.u, row = -3, cex = .8, mlab = "RE Model for Unpublished Subgroup")
addpoly(res.o, row = -5, cex = .8, mlab = "RE Model for Overall Estimate")

## Figure 4: Funnel plot
retres <- rma(ret_g, ret_v, data = mydata)

funnel.rma(retres, refline = 0, level = c(90, 95, 99), shade = c("white", "gray55", 'gray75'), legend = TRUE)

## Figure 4_old: Funnel plot was generated using the online shiny app which
## can be accessed at: https://vevealab.shinyapps.io/WeightFunctionModel/
## or the shiny app can be run locally using weightr::shiny_weightr()
## The plot was generated using the ret_g and ret_v data.

## Create p-curve app function with code provided here:
## http://p-curve.com/app4/pcurve_app4.06.r
source("scripts/pcurve_app4.06.R")
pcurve_app("dataret.txt", "data/") ## Output will be saved to data folder

## Figure 5: P-curve plot of significant results
## P-curve plot can be found in the data folder or can be reproduced using
## the online p-curve app which can be accessed at: http://p-curve.com/app4/
## You will need to open dataret.txt and then copy the data into the box
