;********************************************************
; WRF: simple plane view of the pressure field
;      at a specific time and level. No map background.
;********************************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"   
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"   
begin
;********************************************************
; open file 
;********************************************************
  f = addfile ("met_em.d01.2016-07-16_09:00:00.nc", "r")

;********************************************************
; Read character variable Times 
; Convert to type string for plotting purposes
;********************************************************
  times   = chartostring(f->Times)     ; built-in function

;********************************************************
; Read Pressure at Time=12, level=0, convert to hPa 
;********************************************************
  p       = f->PRES(12,0,:,:)             ; import data + meta info
  p       = p*0.01                     ; demo: convert to hPa
  p@units = "hPa"                      ; update units attribute

;********************************************************
; create plots  
;********************************************************
  wks = gsn_open_wks("ps" ,"WRF_cn")          ; ps,pdf,x11,ncgm,eps
  gsn_define_colormap(wks,"BlAqGrYeOrReVi200"); select color map

  res                       = True            ; plot mods desired
;;res@gsnMaximize           = True            ; uncomment to maximize size
  res@tiMainString          = times(12)       ; main title
  plot                      = gsn_csm_contour(wks,p,res)

  res@cnFillOn              = True            ; turn on color
  res@cnLinesOn             = False           ; turn contour lines
  res@gsnSpreadColors       = True            ; use entire color map
  res@lbLabelAutoStride     = True            ; let NCL determine label spacing
  plot                      = gsn_csm_contour(wks,p,res)
end


