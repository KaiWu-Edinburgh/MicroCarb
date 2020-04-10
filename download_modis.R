rm(list=ls()) # clears everything
cat("\014")

install.packages("MODISTools")
library(MODISTools)

# mt_products()

# mt_bands(product='MOD15A2H') #MODIS FPAR

mt_bands(product='MOD13Q1')  #MODIS Terra veg indices
# mt_bands(product='MYD13Q1')  #MODIS Aqua veg indices
# mt_bands(product='MOD09A1')  #MODIS Terra surface reflectance
# mt_bands(product='MYD09A1')  #MODIS Aqua surface reflectance
# #MOD13Q1, MYD13Q1, MOD09A1, MYD09A1
# mt_bands(product='MCD12Q2')  #phenology

# 1 Tower 01:  39.5805 -86.4207
# 2 Tower 02:  39.7978 -86.0183
# 3 Tower 07:  39.7739 -86.2724
# 4 Tower 09:  39.8627 -85.7448
# 5 Tower 14:  39.9971 -86.7396

# 6 Site C:    39.8273 -86.1790
# 7 Site G:    39.8706 -86.0024
# 8 Site F:    39.3232 -86.4131
# 9 Site E:    39.8645 -86.5005
# 10Site W:    39.8632 -86.5083
# 11site f09:  39.8167 -85.7005
# 12Site f14:  39.9468 -86.7880

site.lon = c(-86.4207, -86.0183, -86.2724, -85.7448, -86.7396, -86.1790, -86.0024, -86.4131, -86.5005, -86.5083, -85.7005, -86.7880)
site.lat = c(39.5805, 39.7978, 39.7739, 39.8627, 39.9971, 39.8273, 39.8706, 39.3232, 39.8645, 39.8632, 39.8167, 39.9468)

date.start='2017-08-01'  #doesn't go before 2000-01-01
date.end='2019-11-30'

###################################EVI###########################################
# tem = mt_subset(product='MOD13Q1',lat=site.lat[1],lon=site.lon[1],band='250m_16_days_EVI',start=date.start,end=date.end)
# 
# res = matrix(,nrow=52,ncol=length(site.lon)+3)
# res[,1] = as.numeric(substring(tem[,17], 1,4))
# res[,2] = as.numeric(substring(tem[,17], 6,7))
# res[,3] = as.numeric(substring(tem[,17], 9,10))
# 
# for (i in 1:length(site.lon)){
#    tem = mt_subset(product='MOD13Q1',lat=site.lat[i],lon=site.lon[i],band='250m_16_days_EVI',start=date.start,end=date.end)
#    res[,i+3] = tem[,21]
#    rm(tem)
# }
# 
# write.csv(res,file='P:/Research/Results/2019/bio_flux/1203/data/evi.csv')

##################################LSWI###########################################
# tem = mt_subset(product='MOD09A1',lat=site.lat[1],lon=site.lon[1],band='sur_refl_b02',start=date.start,end=date.end)
# 
# res = matrix(,nrow=106,ncol=length(site.lon)+3)
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
# write.csv(res,file='P:/Research/Results/2019/bio_flux/1203/data/lswi.csv')

####################################FPAR###########################################
tem = mt_subset(product='MOD15A2H',lat=site.lat[1],lon=site.lon[1],band='Fpar_500m',start=date.start,end=date.end)

res = matrix(,nrow=106,ncol=length(site.lon)+3)
res[,1] = as.numeric(substring(tem[,17], 1,4))
res[,2] = as.numeric(substring(tem[,17], 6,7))
res[,3] = as.numeric(substring(tem[,17], 9,10))

for (i in 1:length(site.lon)){
    tem = mt_subset(product='MOD15A2H',lat=site.lat[i],lon=site.lon[i],band='Fpar_500m',start=date.start,end=date.end)
    res[,i+3] = tem[,21]
    rm(tem)
}
write.csv(res,file='P:/Research/Results/2019/bio_flux/1203/data/fpar.csv')