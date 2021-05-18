#! /Library/Frameworks/R.framework/Resources/bin/Rscript
# mssmVines <- function(U) {
# -----------------------------mssmVines----------------------------
# Purpose: This function utilizes the CDVine package to fit a Vine 
# copula model to U, the d-dimensional copula data set in [0,1] space 
#
# Inputs:
#       - U: the uniform marginals     
#
# SEE ALSO: VineCopula Package, MultiHazard toolbox
#
# Record of revisions:
#       Date            Programmer          Description of Change
#       =========================================================
#       08/10/20        K. Anarde           original code
#
# ------------------------------user input------------------------------

# setwd("/Users/KatherineAnardeWheels/PyCharmProjects/Barrier3D/Tools/Multivariate_Sea_Storm_Model")

# load R packages
library(CDVine)
library(R.matlab)
#library(VineCopula)

# user inputs
U <- read.table("U_mssm.txt")   # N x d data matrix (with uniform margins)
nSimNum <- read.table("Inputs_mssm.txt")   # 10000

# ------------------------------model-------------------------------

# copula model parameters
type  <- "DVine";          # options are "CVine" or "DVine"

# returns pair-copula families composing the C- or D-vine copula ($family), its parameters ($par and $par2) 
Model <- CDVineCopSelect(U, familyset = NA, type = type, selectioncrit="AIC", indeptest=FALSE, level=0.05)

# generate new data Usim from the copula
uSim  <- CDVineSim(nSimNum, family=Model$family, par=Model$par, Model$par2, type=type)

# write outputs to a mat file
writeMat('Usim_mssm-Dvine.mat', uSim = uSim, fixNames=TRUE, matVersion="5", onWrite=NULL, verbose=FALSE)

# now do it again for the c-vine copula
type  <- "CVine";          # options are "CVine" or "DVine"
Model <- CDVineCopSelect(U, familyset = NA, type = type, selectioncrit="AIC", indeptest=FALSE, level=0.05)
uSim  <- CDVineSim(nSimNum, family=Model$family, par=Model$par, Model$par2, type=type)
writeMat('Usim_mssm-Cvine.mat', uSim = uSim, fixNames=TRUE, matVersion="5", onWrite=NULL, verbose=FALSE)