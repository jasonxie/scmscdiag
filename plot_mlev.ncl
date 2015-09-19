
load "$SCM_SC_DIAG/load.ncl"

begin

;varname = "pra"

timestep = stringtoint(TIMESTEP)

infile = addfile(inputnc, "r")
data = infile->$varname$(timestep,:,:)
data!1 = "subcol"
nsubcol = dimsizes( data(0,:) )
data&subcol = ispan(1, nsubcol, 1)

;if ( varname .eq. "cldliq" ) then
;  data = data*1000.
;  data@units = "g/kg"
;end if


;generate sub-column.

wks = gsn_open_wks( "oldps", plotdir+"/"+varname)
;wks = gsn_open_wks( "x11", varname)
gsn_define_colormap(wks,"hotcold_18lev")

res_ct = True

;set contour range for all variabels
if ( ( varname .eq. "PRA" ) .or. \
     ( varname .eq. "PRC" ) .or. \
     ( varname .eq. "PRACS" ) .or. \
     ( varname .eq. "PRE" ) .or. \
     ( varname .eq. "QRTEND" ) .or. \
     ( varname .eq. "MNUCCR" ) \
   ) then
  res_ct@cnLevelSelectionMode = "ManualLevels"
  res_ct@cnLevelSpacingF =  1e-7
  res_ct@cnMinLevelValF  = -9e-7
  res_ct@cnMaxLevelValF  =  9e-7
end if

if ( ( varname .eq. "QC" ) ) then
  gsn_define_colormap(wks,"precip3_16lev")
  res_ct@cnLevelSelectionMode = "ManualLevels"
  res_ct@cnLevelSpacingF = 0.5e-3
  res_ct@cnMinLevelValF  = 0.0
  res_ct@cnMaxLevelValF  = 5.0e-3
end if


;set resources for graphics
res_ct@cnFillOn   = True
res_ct@cnLinesOn  = False
res_ct@cnFillMode = "RasterFill"
;res_ct@cnFillMode = "CellFill"

res_ct@gsnSpreadColors = True

;res_ct@vpWidthF  = 0.2    ;default 0.6
res_ct@vpHeightF = 0.3 ;default 0.6

res_ct@trYReverse = True

res_ct@tiMainString = varname
res_ct@gsnLeftString = "timestep:"+timestep

easyfonts( res_ct, 0.02)

plot_random         = gsn_csm_contour( wks, data(:,:), res_ct)

end


