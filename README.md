# A Multivariate Sea Storm Model

Following the methods of Wahl et al. (2016), we develop a copula-based multivariate sea-storm model (MSSM) with functionality for gaussian, t-student, and vine copulas. The notebook provided at https://github.com/UNC-CECL/Barrier3D describes the MSSM components and an example application of the MSSM for use with Barrier3D - an exploratory barrier island evolution model. We provide a sample call below and describe the model inputs herein.

`[stStorms, stSimStorms] = multivariateSeaStorm(sCopula, sWIS_filename, sWaterLevel_filename, fBeta, fBermEl, nSimStorm, bPlot, sOutput_filename)`

The MSSM model `multivariateSeaStorm.m` is written in Matlab in order to utilize the t-tide package, which allows for robust fitting of tidal constituents to water level time series. The MSSM model requires the following inputs: 

```
Inputs:  

      sCopula              - copula to be fitted to storm variables; options are "c-vine", "d-vine", "gaussian", or "t-student"
                            
      sWIS_filename        - .onlns file downloaded from a USACE Wave Information Studies (WIS) bouy; must   <br />
                             contain hourly records of wave height (m)  
                             
      sWaterLevel_filename - .txt file that contains hourly records of total water level in m NAVD88 as second column, first column is datetime; 
                              downloaded for each year from NOAA; must be either the same length or longer than WIS time record  
                              
      fBeta                - beach slope  
      
      nSimStorm            - number of simulated storms to create  
      
      fBermEl              - erosion threshold; Wahl used 5% of dune toe heights; we use the average berm elevation (m NAVD88)  
                             
      bPlot                - boolean for plotting  
      
      sOutputFilename      - string of prefix for csv output filename  
```

In the example provided in the notebook at https://github.com/UNC-CECL/Barrier3D, we utilize a 35 year record of hourly wave hindcast data – including wave height (Hs) and wave period (Tp) – from the USACE’s Wave Information Studies buoy offshore Hog Island in the Virginia Coast Reserve (Station 63183, 22 m water depth) and hourly records of water level from the nearest NOAA tide gauge (Station 8631044, Wachapreague, VA) to create a list of 20,000 synthetic storms. We specify a berm elevation of 1.9 m (the average along Hog Island) and beach slope of 0.04. The c-vine produced the highest tau values (Kendall's Corelation Coefficient) over the elliptical Gaussian and T-student copulas, as well as the d-vine copula.

`[stStorms, stSimStorms] = multivariateSeaStorm("c-vine", "ST63183_v03.onlns", "Tide-8631044-Combined.txt", 0.04, 1.9, 20000, true, "StormList_20k_VCR_Berm1pt9m_Slope0pt04.csv")`
