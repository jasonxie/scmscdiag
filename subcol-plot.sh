#!/bin/bash

for OUTTIMESTEP in $OUTTIMESTEPS
do
   TIMESTEP_STR=$(printf "%04d" $OUTTIMESTEP)
   PLOTDIR=$PLOT_ROOT/$TIMESTEP_STR
   if [ ! -d $PLOTDIR ]; then
      echo "$PLOTDIR does not exisit, creating..."
      mkdir -pv $PLOTDIR
   fi

   for VAR in $SLEVVARS
   do
      echo $VAR"..."
      ncl inputnc=\"$INPUTNC\" varname=\"$VAR\" plotdir=\"$PLOTDIR\" TIMESTEP=\"$OUTTIMESTEP\" $SCM_SC_DIAG/plot_slev.ncl
#     convert -density $IMGDENSITY -trim -trim -border 5 -bordercolor '#fff' +repage $PLOTDIR/$VAR.ps $PLOTDIR/$VAR.png
      convert -density $IMGDENSITY -trim -trim $PLOTDIR/$VAR.ps $PLOTDIR/$VAR.png
      rm -f $PLOTDIR/$VAR.ps
   done

   for VAR in $MLEVVARS
   do
      echo $VAR"..."
      ncl inputnc=\"$INPUTNC\" varname=\"$VAR\" plotdir=\"$PLOTDIR\" TIMESTEP=\"$OUTTIMESTEP\" $SCM_SC_DIAG/plot_mlev.ncl
#     convert -density $IMGDENSITY -trim -trim -border 5 -bordercolor '#fff' +repage $PLOTDIR/$VAR.ps $PLOTDIR/$VAR.png
      convert -density $IMGDENSITY -trim -trim $PLOTDIR/$VAR.ps $PLOTDIR/$VAR.png
      rm -f $PLOTDIR/$VAR.ps
   done

done

