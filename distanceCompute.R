rm(list=ls())
if(!require(RSQLite)){
  install.packages("RSQLite")
  library(RSQLite)
}
if(!require(treemap)){
  install.packages("treemap")
  library(treemap)
}
if(!require(stats)){
  install.packages("stats")
  library(stats)
}

#import sqlite
dbname <- "ESDproject.sqlite"
conn <- dbConnect(SQLite(),dbname)

#query,need to change featureId and the last query name
query <- "SELECT SiteId,TourId,Types,Latitude,Longitude,lati,long from SiteTourJoin"
queryresult <- dbGetQuery(conn,query)
#num of columns
size2 = dim(queryresult)[2]+1
p <- pi/180;
for (i in 1:dim(queryresult)[1]){
  lat1 <- queryresult[i,4]*p
  lng1 <- queryresult[i,5]*p
  lat2 <- queryresult[i,6]*p
  lng2 <- queryresult[i,7]*p
  dlng = lng2 - lng1
  dlat = lat2 - lat1
  a = (sin(dlat/2))^2 + cos(lat1) * cos(lat2) * (sin(dlng/2))^2 
  c = 2 * atan2( sqrt(a), sqrt(1-a) )
  d = 6371 * c
  #write a new column distance, need to change column name in sqlite manually
  queryresult[i,size2] <- d
}
#write a new table in sqlite,change the table name
dbWriteTable(conn, "AtoTour", queryresult)
dbDisconnect(conn)
