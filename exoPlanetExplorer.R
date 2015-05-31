
getStarData<-function(maxD=6000){
  dataColQuery<-c(
    "pl_hostname",
    "st_dist",
    "st_glon", # longitude l angle between this and galatic center
    "st_glat", # latitute b angle out of the plane
    "st_mass",
    "ra",
    "dec ",
    "hd_name",
    "hip_name",
    "pl_name",
    "pl_eqt",
    "pl_msinie",
    "pl_rade",
    "pl_status",
    "st_spstr",
    "st_lum",
    "swasp_id",
    "st_umbj"  
  )
  
  url<-c(
    "http://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?", #base url
    "&table=exoplanets", #data table
    "&select=",
    paste(dataColQuery, collapse=","),
    "&order=", "st_dist",
    "&format=csv"
  )
  
  url<-paste(url, collapse="")
  
  download.file(
    url=url,
    destfile="stars_hosting_exoplanets.csv",
    method= "wget"
  )  
  stars.df<-read.csv("./stars_hosting_exoplanets.csv")
  pstars.df<-subset(stars.df, !is.na(stars.df$st_dist) & stars.df$st_dist < maxD 
                    #    & stars.df$pl_rade<10
  )
  st_glat<-stars.df$st_glat
  st_glon<-stars.df$st_glon

  with(data=pstars.df,{
    r<-st_dist*cos(st_glat)
    z<<-st_dist*sin(st_glat)
    y<<-r*sin(st_glon)
    x<<-r*cos(st_glon)
  })
  #cbind(x,y,z)
  pstars.df$x<-x
  pstars.df$y<-y
  pstars.df$z<-z
  pstars.df
}
