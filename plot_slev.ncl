
load "$SCM_SC_DIAG/load.ncl"

begin

;varname = "pra"

timestep = stringtoint(TIMESTEP)

infile = addfile(inputnc, "r")
data   = infile->$varname$(timestep, :)
data@long_name = "PRECT"

refdata = infile->NONSCPRECT(timestep, 0)
avgdata = dim_avg_Wrap(data)

print(refdata+"")
print(avgdata+"")

nx = dimsizes(data)
x  = ispan(1, nx, 1 )

easyunits(data)
easyunits(refdata)
easyunits(avgdata)

wks = gsn_open_wks( "oldps", plotdir+"/"+varname )

res_xy = True
res_xy@gsnDraw  = False
res_xy@gsnFrame = False

res_xy@gsnXYBarChart = True

res_xy@vpHeightF = 0.3 ;default 0.6

res_xy@tiMainString = varname
res_xy@gsnYRefLine  = 0.

res_xy@gsnLeftString = "timestep:"+timestep
res_xy@gsnRightString = data@units

res_xy@trYMinF = 0
res_xy@trYMaxF = 150

easyfonts(res_xy, 0.02)

res_line = True
plot = gsn_csm_xy( wks, x, data, res_xy )

xcor = (/ min(x), max(x) /)
ycor = (/ refdata, refdata/)
res_line@gsLineColor = "red"
plot1 = gsn_add_polyline( wks, plot, xcor, ycor, res_line)

xcor = (/ min(x), max(x) /)
ycor = (/ avgdata, avgdata/)
res_line@gsLineColor = "blue"


plot2 = gsn_add_polyline( wks, plot, xcor, ycor, res_line)


draw(wks)
frame(wks)

histwks = gsn_open_wks( "ps", plotdir+"/"+varname+"_hist" )

res_hist = True
res_hist@gsFillColor = "green3"
res_hist@tiMainString = varname+" Histogram"

easyfonts(res_hist, 0.02)

data = where( data .lt. 1e-5, 0., data)

plot = gsn_histogram(histwks, data, res_hist)


end


