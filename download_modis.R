rm(list=ls()) # clears everything
cat("\014")

#install.packages("MODISTools") #%install package
library(MODISTools)             #load package

#mt_products()                  #%display product names and descriptions

mt_bands(product='MOD13Q1')    #MODIS Terra veg indices (NDVI/EVI)   EVI
# mt_bands(product='MYD13Q1')  #MODIS Aqua veg indices (NDVI/EVI)
# mt_bands(product='MOD09A1')  #MODIS Terra surface reflectance (SREF) LSWI
# mt_bands(product='MYD09A1')  #MODIS Aqua surface reflectance (SREF)
# MOD13Q1, MYD13Q1, MOD09A1, MYD09A1
# mt_bands(product='MCD12Q2')  #Land Cover Dynamics
# mt_bands(product='MOD15A2H') #MODIS LAI/FPAR                         FPAR

#################### LAT and LON#####################
# 1 Tower 01:  39.5805 -86.4207
# 2 Tower 02:  39.7978 -86.0183
# 3 Tower 07:  39.7739 -86.2724
# 4 Tower 09:  39.8627 -85.7448
# 5 Tower 14:  39.9971 -86.7396

# 6 Site C:    39.8273 -86.1790  #Crown Hill Cemetery
# 7 Site G:    39.8706 -86.0024  #The Fort Golf Resort  
# 8 Site F:    39.3232 -86.4131  #Morgan-Monroe State Forest
# 9 Site E:    39.8645 -86.5005  #Agricultural Site East near Pittsboro
# 10Site W:    39.8632 -86.5083  #Agricultural Site West near Pittsboro
# 11site f09:  39.8167 -85.7005
# 12Site f14:  39.9468 -86.7880

site.lon = c(-86.4207, -86.0183, -86.2724, -85.7448, -86.7396, -86.1790, -86.0024, -86.4131, -86.5005, -86.5083, -85.7005, -86.7880)
site.lat = c(39.5805, 39.7978, 39.7739, 39.8627, 39.9971, 39.8273, 39.8706, 39.3232, 39.8645, 39.8632, 39.8167, 39.9468)

date.start='2017-08-01' 
date.end='2019-11-01'

#################################EVI###########################################
tem = mt_subset(product='MOD13Q1',lat=site.lat[1],lon=site.lon[1],band='250m_16_days_EVI',start=date.start,end=date.end)  #download a file to get yy mm dd

res = matrix(data=NA,nrow=52,ncol=length(site.lon)+3)   #generate an empty matrix, nrow time dimension, ncol site dimension plus yy mm dd
res[,1] = as.numeric(substring(tem[,17], 1,4))          #yy
res[,2] = as.numeric(substring(tem[,17], 6,7))          #mm
res[,3] = as.numeric(substring(tem[,17], 9,10))         #dd

for (i in 1:length(site.lon)){
   tem = mt_subset(product='MOD13Q1',lat=site.lat[i],lon=site.lon[i],band='250m_16_days_EVI',start=date.start,end=date.end)  #download files
   res[,i+3] = tem[,21]   # extract EVI to the res matrix
   rm(tem)
}

write.csv(res,file='D:/Research/Results/2020/0420/dat/evi.csv')

# # ##################################LSWI###########################################
# tem = mt_subset(product='MOD09A1',lat=site.lat[1],lon=site.lon[1],band='sur_refl_b02',start=date.start,end=date.end)
# 
# res = matrix(data=NA,nrow=104,ncol=length(site.lon)+3)  #different time resolution with EVI
# res[,1] = as.numeric(substring(tem[,17], 1,4))
# res[,2] = as.numeric(substring(tem[,17], 6,7))
# res[,3] = as.numeric(substring(tem[,17], 9,10))
# 
# for (i in 1:length(site.lon)){
# #MODIS Terra Surface Reflectances, band 2 (NIR)
# test1 = mt_subset(product='MOD09A1',lat=site.lat[i],lon=site.lon[i],band='sur_refl_b02',start=date.start,end=date.end)
# rho_nir = test1$value
# rho_nir[rho_nir==-28672] = NA  #set fill value to NA
# 
# #MODIS Terra Surface Reflectances, band 6 (SWIR)
# test2 = mt_subset(product='MOD09A1',lat=site.lat[i],lon=site.lon[i],band='sur_refl_b06',start=date.start,end=date.end)
# rho_swir = test2$value
# rho_swir[rho_swir==-28672] = NA  #set fill value to NA
# 
# #calculate LSWI
# res[,i+3] <- (rho_nir - rho_swir) / (rho_nir + rho_swir)
# rm(test1,test2,rho_nir,rho_swir)
# }
# 
# write.csv(res,file='D:/Research/Results/2020/0420/dat/lswi.csv')

# ####################################FPAR###########################################
# tem = mt_subset(product='MOD15A2H',lat=site.lat[1],lon=site.lon[1],band='Fpar_500m',start=date.start,end=date.end)
# 
# res = matrix(data=NA,nrow=104,ncol=length(site.lon)+3)
# res[,1] = as.numeric(substring(tem[,17], 1,4))
# res[,2] = as.numeric(substring(tem[,17], 6,7))
# res[,3] = as.numeric(substring(tem[,17], 9,10))
# 
# for (i in 1:length(site.lon)){
#     tem = mt_subset(product='MOD15A2H',lat=site.lat[i],lon=site.lon[i],band='Fpar_500m',start=date.start,end=date.end)
#     res[,i+3] = tem[,21]
#     rm(tem)
# }
# 
# write.csv(res,file='D:/Research/Results/2020/0420/dat/fpar.csv')