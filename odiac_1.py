import numpy as np
import tifffile as tf
import matplotlib as mpl
import pylab as plt
from matplotlib import cm

mon = ['01','02','03','04','05','06','07','08','09','10','11','12']

t_lat = 48.8566   # target city latitude  P: 48.8566  L: 51.5074
t_lon =  2.3522   # target city longitude P: 2.3522  L: -0.1278
ext_lat = 0.5       # extended area P: 1 degree   L: 0.5 degree
ext_lon = 0.5

for k in range(0,1):
    
    filename = 'D:/Edin/0302/dat/odiac2019_1km/2018/odiac2019_1km_excl_intl_18'+mon[k]+'.tif'
    
    print(filename)
    
    tem = tf.imread(filename)
  
    # define lat and lon for ODIAC
    dx = dy = 0.008333333333333
    nrows = len(dat)
    ncols = len(dat[1])
    lon = np.arange(ncols)*dx + dx/2. - 180.
    lat = 90 - np.arange(nrows)*dy + dy/2. 
        
    # search index to locate the target area
    lc_lat = np.where((lat >= t_lat - ext_lat) & (lat <= t_lat + ext_lat))
    lc_lon = np.where((lon >= t_lon - ext_lon) & (lon <= t_lon + ext_lon))
    x, y = np.meshgrid(lon[lc_lon],lat[lc_lat])
    
    # unit conversion
    dat = tem*(10**6)/(12*30*24*3600)     # from tonne C km-2 month-1 to micromol CO2 m-2 s-1
    
    # extract data in the target area
    z = dat[np.transpose(lc_lat),lc_lon]

    # to deal with strong point emissions for plotting
    # method 1: limit the maximum emissions to 20 (Paris) or 10 (London) umol m-2 s-1 
    lc = np.where(z > 20)
    z[lc] = 20

#    # method 2: use the logarithmic scale, better to plot emissions globally/regionally
#    z = np.log10(z) 

## plot emissions    
#plt.figure(1)
#cflux = plt.contourf(x,y,z,cmap=cm.jet)
#plt.colorbar()
#mpl.rcParams.update({'font.size': 80})
#plt.show()

    
## estimate the indicator of XCO2    
# boundary layer height
BLH = 1500                           # m

# dry air molar density
air_con = 1275.4/29                  # mol m-3   
    
# estimate the indicator of XCO2
z = z*3600/(BLH*air_con)             # ppm h-1
   
plt.figure(2) 
cflux = plt.contourf(x,y,z,cmap=cm.jet)
plt.colorbar()
mpl.rcParams.update({'font.size': 80})
plt.show()    
