#!/bin/bash

export SCM_SC_DIAG="/R2/xxie/xxgit/jasonxie_scmscdiag"
export INPUTNC="/R2/xxie/modelrun/scam_cam5_subcloud/run1_0_4/exe/sc.nc"
export PLOT_ROOT="/R2/xxie/modelrun/scam_cam5_subcloud/subcol-plots"

export SLEVVARS="PRECTWFALL"
#SLEVVARS="PRECTWFALL PRECTWOFALL"
export MLEVVARS="QC PRC PRA PRE PRACS MNUCCR QRTEND"
#MLEVVARS="qc prc pra pre pracs mnuccr qrtend"

export NOWDIR=$(pwd)

export IMGDENSITY=220

export OUTTIMESTEPS=$(seq 50 50)

$SCM_SC_DIAG/subcol-plot.sh


