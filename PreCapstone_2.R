
library(tidyverse)
library(rvest)
library(chron)
library(lubridate)
library(stringr)
# File 3 ----
# Description ----
# This file includes mainly:
 # Adding the environmental features which are:
  # 1- Temeprature in celicus 
  # 2- Relative Humidity
  # 3- In addition, it is used to add the lagged attendance of one home match earlier

# Loop Logic ----
  # The logic of the loop:
  # i represents the games
  # j represents the observations in the rresource data
  # We want to find an observation that match with the date & the location of the venue 

# Resources ----
# https://www.kaggle.com/esraamadi/saudi-arabia-weather-history
# https://datasource.kapsarc.org/explore/dataset/saudi-hourly-weather-data/table/?disjunctive.station_name&disjunctive.wind_direction_quality&disjunctive.wind_type&disjunctive.wind_speed_quality&disjunctive.sky_ceiling_quality&disjunctive.visibility_distance_quality&disjunctive.visibility_variability_quality&disjunctive.air_temperature_quality&disjunctive.air_temperature_dew_point_quality&disjunctive.atmospheric_sea_level_pressure_quality
# I've splitted thr second one into 9 parts due to its large size ( >9 million)
# The rest observations were filled up manually via weather websites

# Import the data ----
# This is file that we've saved at the end of "PreCapstoneFeatures" file
SPL_Features <- read_csv("SPL/SPL_V1.csv")

# Add empty columns for the features
SPL_Features <- SPL_Features %>%
  add_column(TemperatureC = 0, DewPoint = 0)

# I've noticed a msitake in one of the venues 
try <-SPL_Features
str_replace_all(try$Longitude, "42.49007", "39.543668") -> try$Longitude
str_replace_all(try$Latitude, "18.22304", "24.46251") -> try$Latitude

# 1st part of the 2nd resource ----

SH_0 <- read_csv("SH_0.csv")
SH_0 %>% 
  select(STATION_NAME, OBSERVATION_DATE, LATITUDE, LONGITUDE, AIR_TEMPERATURE, AIR_TEMPERATURE_DEW_POINT, LAST_LOAD_DATE) ->SH_01

# Check what are the existing stations
unique(SH_01$STATION_NAME)

SH_01 %>% 
  filter(STATION_NAME == "ABHA" |STATION_NAME == "AL AHSA"| STATION_NAME == "AL KHARJ" ) -> SH_01

SH_01 %>% 
  separate(OBSERVATION_DATE, c("date", "time"), sep = " ") ->SH_01

###
SH_01 %>% 
  filter(STATION_NAME == "AL AHSA", time=="19:00:00", date >= '2010-08-14' ) -> SH_01
  

# AlAhas ---- 


j=1
while (j<=3002){
i=1
  
while(i<=1861) {
  if (try$Venue[i] == "Prince Abdullah Bin Jalawi Sport City Stadium" & (try$Date[i] == SH_01$date[j]) )
    {
    try$TemperatureC[i] <- SH_01$AIR_TEMPERATURE[j]
    try$DewPoint[i] <- SH_01$AIR_TEMPERATURE_DEW_POINT[j]
    j=j+1 }
  i=i+1}
j=j+1}

# Abha ---- 

SH_01 %>% 
  filter(STATION_NAME == "ABHA", time=="19:00:00", date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=3001){
  i=1
  
  while(i<=1861) {
    if (try$Venue[i] == "Prince Sultan bin Abdul Aziz Stadium" & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$AIR_TEMPERATURE[j]
      try$DewPoint[i] <- SH_01$AIR_TEMPERATURE_DEW_POINT[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Dammam $ Khobar ---- 

remove(SH_0)

SH_0 <- read_csv("SH_1.csv")

SH_1 %>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01
unique(SH_01$V3)

SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01

SH_01 %>% 
  filter(V3 == "DAMMAM (KING FAHD INT. AIRPORT)", time=="19:00:00", date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=2987){
  i=1
  
  while(i<=1861) {
    if ((try$Venue[i] == "Prince Mohamed bin Fahd Stadium" | try$Venue[i] =="Prince Saud Bin Jalawi Sport City Stadium") & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}


# Makkah ---- 
remove(SH_0)
remove(SH_3)
#Import SH_4 without Header 

SH_4 %>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01

unique(SH_01$V3)

SH_01 %>% 
  filter(V3 == "MAKKAH") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01

SH_01 %>% 
  filter(V3 == "MAKKAH", time=="19:00:00", date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=2838){
  i=1
  
  while(i<=1861) {
    if (try$Venue[i] == "King Abdul Aziz Sport City Stadium"  & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Najran ---- 
remove(SH_4)
#Import SH_5 without Header 
SH_5 %>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01

unique(SH_01$V3)

SH_01 %>% 
  filter(V3 == "NEJRAN") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "NEJRAN", time=="19:00:00", date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=2838){
  i=1
  
  while(i<=1861) {
    if (try$Venue[i] == "Al-Ukhdood Stadium"  & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Riyadh ---- 
remove(SH_5)
#Import SH_6 without Header 
SH_6 %>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01

unique(SH_01$V3)

SH_01 %>% 
  filter(V3 == "RIYADH AB") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "RIYADH AB", time=="19:00:00", date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=610){
  i=1
  
  while(i<=1861) {
    if ((try$Venue[i] == "King Saud University Stadium" | try$Venue[i] =="Prince Faysal Bin Fahad stadium" | try$Venue[i] == "King Fahad International Stadium" |  try$Venue[i] == "Prince Khalid bin Sultan Stadium" |  try$Venue[i] == "Al-Shoalah Club Stadium") & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Qassim ---- 
remove(SH_08)
#Import SH_9 without Header 
SH_9 %>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01

unique(SH_01$V3)

SH_01 %>% 
  filter(V3 == "GASSIM") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "GASSIM", time=="19:00:00", date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=140){
  i=1
  
  while(i<=1861) {
    if ((try$Venue[i] == "Al-Hazm Club Stadium" | try$Venue[i] =="King Abdullah Sport City Stadium" ) & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Riyadh2 ---- 
remove(SH_9)
#Import SH_0 without Header 
SH_0%>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01


unique(SH_01$V3)

SH_01 %>% 
  filter(V3 == "AL KHARJ") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "AL KHARJ", time=="19:00:00", date >= '2010-08-14' ) -> SH_01
i=1
j=1
while (j<=748){
  i=1
  
  while(i<=1861) {
    if ( (try$Venue[i] == "King Saud University Stadium" | try$Venue[i] =="Prince Faysal Bin Fahad stadium" | try$Venue[i] == "King Fahad International Stadium" |  try$Venue[i] == "Prince Khalid bin Sultan Stadium" |  try$Venue[i] == "Al-Shoalah Club Stadium") & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Jouf ---- 
SH_0%>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01


unique(SH_01$V3)

SH_01 %>% 
  filter(V3 == "AL JOUF") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "AL JOUF", time=="19:00:00", date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=2995){
  i=1
  
  while(i<=1861) {
    if (  try$Venue[i] == "Al Orubah Club Stadium" & try$Date[i] == SH_01$date[j]) 
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}





# Jeddah ---- 
remove(SH_2)
#Import SH_3 without Header

SH_3%>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01


unique(SH_01$V3)

SH_01 %>% 
  filter(V3 == "KING ABDULAZIZ INTL") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "KING ABDULAZIZ INTL", time=="18:00:00", date >= '2010-08-14' ) -> SH_01


i=1
j=1
while (j<=5034){
  i=1
  
  while(i<=1861) {
    if ((try$Venue[i] == "King Abdullah International Reserve Stadium" | try$Venue[i] =="King Abdullah International Stadium" | try$Venue[i] =="Prince Mohammed Alabdullah Stadium"  | try$Venue[i] =="Prince Abdullah Al-Faisal Stadium") & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}




# Bstin ---- 
remove(SH_5)
#Import SH_6 without Header


SH_6%>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01
unique(SH_01$V3)
SH_01 %>% 
  filter(V3 == "QAISUMAH") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "QAISUMAH", time=="18:00:00", date >= '2010-08-14' ) -> SH_01
i=1
j=1
while (j<=4997){
  i=1
  
  while(i<=1861) {
    if (try$Venue[i] == "Al-Batin Club Stadium"  & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Riyadh3 ---- 
SH_6%>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01
unique(SH_01$V3)
SH_01 %>% 
  filter(V3 == "RIYADH AB") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "RIYADH AB",  time=="18:00:00" |time=="19:00:00" | time=="21:00:00"  , date >= '2010-08-14' ) -> SH_01


i=1
j=1
while (j<=1794){
  i=1
  
  while(i<=1861) {
    if ( (try$Venue[i] == "King Saud University Stadium" | try$Venue[i] =="Prince Faysal Bin Fahad stadium" | try$Venue[i] == "King Fahad International Stadium" |  try$Venue[i] == "Prince Khalid bin Sultan Stadium" ) & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Madina ---- 
remove(SH_8)
#Import SH_9 without Header
SH_9%>% 
  select(V3, V5, V7, V8, V27, V30, V36) ->SH_01
unique(SH_01$V3)
SH_01 %>% 
  filter(V3 == "PRINCE MOHAMMAD BIN ABDULAZIZ") ->SH_01
SH_01 %>% 
  separate(V5, c("date", "time"), sep = " ") ->SH_01
SH_01 %>% 
  filter(V3 == "PRINCE MOHAMMAD BIN ABDULAZIZ",  time=="18:00:00"   , date >= '2010-08-14' ) -> SH_01

i=1
j=1
while (j<=278){
  i=1
  
  while(i<=1861) {
    if ( (try$Venue[i] == "Prince Mohammed bin Abdul Aziz Stadium" | try$Venue[i] == "Al-Ansar Club Stadium" ) & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$V27[j]
      try$DewPoint[i] <- SH_01$V30[j]
      j=j+1 }
    i=i+1}
  j=j+1}

##import the other dataset (weather17_19)
remove(SH_9)


# Qassim2 ---- 



Weather17_19 %>% 
  filter(city == "Qassim", time=="18:00")-> SH_01


i=1
j=1
while (j<=811){
  i=1
  
  while(i<=1861) {
    if ((try$Venue[i] == "Al-Hazm Club Stadium" | try$Venue[i] =="King Abdullah Sport City Stadium" ) & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$temp[j]
      try$DewPoint[i] <- SH_01$humidity[j]
      j=j+1 }
    i=i+1}
  j=j+1}



unique(Weather17_19$city)
## Maddina2 ---- 



Weather17_19 %>% 
  filter(city == "Madina", time=="18:00")-> SH_01

i=1
j=1
while (j<=835){
  i=1
  
  while(i<=1861) {
    if ((try$Venue[i] == "Prince Mohammed bin Abdul Aziz Stadium" | try$Venue[i] =="Al-Ansar Club Stadium" ) & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$temp[j]
      try$DewPoint[i] <- SH_01$humidity[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Riyadh4 ---- 

unique(Weather17_19$city)
Weather17_19 %>% 
  filter(city == "Riyadh", time=="18:00")-> SH_01

i=1
j=1
while (j<=679){
  i=1
  
  while(i<=1861) {
    if ( (try$Venue[i] == "King Saud University Stadium" | try$Venue[i] =="Prince Faysal Bin Fahad stadium" | try$Venue[i] == "King Fahad International Stadium" |  try$Venue[i] == "Prince Khalid bin Sultan Stadium" | try$Venue[i] =="Al-Shoalah Club Stadium") & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$temp[j]
      try$DewPoint[i] <- SH_01$humidity[j]
      j=j+1 }
    i=i+1}
  j=j+1}



# Makkah2 ---- 
unique(Weather17_19$city)
Weather17_19 %>% 
  filter(city == "Mecca", time=="18:00")-> SH_01

i=1
j=1
while (j<=843){
  i=1
  
  while(i<=1861) {
    if (try$Venue[i] == "King Abdul Aziz Sport City Stadium"  & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$temp[j]
      try$DewPoint[i] <- SH_01$humidity[j]
      j=j+1 }
    i=i+1}
  j=j+1}

# Tabook ---- 

unique(Weather17_19$city)
Weather17_19 %>% 
  filter(city == "Tabuk", time=="18:00")-> SH_01
i=1
j=1
while (j<=830){
  i=1
  
  while(i<=1861) {
    if (try$Venue[i] == "Prince Sultan bin Abdul Aziz Stadium" & (try$Date[i] == SH_01$date[j]) )
    {
      try$TemperatureC[i] <- SH_01$temp[j]
      try$DewPoint[i] <- SH_01$humidity[j]
      j=j+1 }
    i=i+1}
  j=j+1}


###
unique(Weather17_19$city)
#Tabuk



try -> SPL_Final


# 
# Season<-rep(c("s10","s11","s12","s13","s14","s15","s16","s17"),each=182)
# append(Season, rep(c("s18"),each=240)) -> Season  #This season has two extra teams
# append(Season, rep(c("s19"),each=165)) -> Season  #Just to COVID 19
# 
# try %>% 
#   mutate(Season) ->try
# 
# try-> SPL
remove(try)
# write_csv(SPL_Final, "SPL_Final.csv")




# Then The rest were filled up manually

SPL_F <- read_csv("FinalAfterWeather.csv")

#Let's reordser the columns
SPL_F <- SPL_F[,c(1,24,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,20,21,17,18,19,22,23)]

#Let's change some columns' names
names(SPL_F)[names(SPL_F) == "PosA"] <- "Rank_A"
names(SPL_F)[names(SPL_F) == "PosH"] <- "Rank_H"
names(SPL_F)[names(SPL_F) == "PosH"] <- "Rank_H"

SPL_F %>% 
  mutate(Season = case_when(
    Season == "s10" ~ 2010,
    Season == "s11" ~ 2011,
    Season == "s12" ~ 2012,
    Season == "s13" ~ 2013,
    Season == "s14" ~ 2014,
    Season == "s15" ~ 2015,
    Season == "s16" ~ 2016,
    Season == "s17" ~ 2017,
    Season == "s18" ~ 2018,
    Season == "s19" ~ 2019,
    
  )) -> SPL_F


#These mistake are from the foreign resource that I scraped for the later years):
SPL_F$DewPoint[955] <- 8
SPL_F$TemperatureC[972] <- 21
SPL_F$TemperatureC[1219] <- 21
SPL_F$DewPoint[1219] <- 20
SPL_F$DewPoint[850] <- -13
SPL_F$TemperatureC[850] <- 25


# DP -> T ----
#Let's convert Dew Temperature into relative Hunidity% using the August-Roche-Magnus approximation.
# RH: =100*(EXP((17.625*TD)/(243.04+TD))/EXP((17.625*T)/(243.04+T)))

A<-17.625*SPL_F$DewPoint
B<-243.04+SPL_F$DewPoint
C<-17.625*SPL_F$TemperatureC
D<- 243.04+SPL_F$TemperatureC
E <- round(100*exp(A/B)/exp(C/D), digits = 2)

SPL_F %>% 
  mutate("RH" = E) -> SPL_F


# Final adjustment ----
# Before save it I've found some mistakes'
#Ive noticed a mistake
SPL_F$Venue[90] <-"King Abdullah Sport City Stadium"
SPL_F$Capacity[90] <-25000
SPL_F$Longitude[90] <-43.94780
SPL_F$Latitude[90] <-26.37890


SPL_F$Attendance[790] <- 305
SPL_F$Attendance[735] <- 12620
SPL_F$Attendance[790] <- 305
SPL_F$Attendance[868] <- 28502
SPL_F$Attendance[870] <- 48763

#These mistake are from the foreign resource that I scraped for the later years):


#Let's save it 
#write_csv(SPL_F, "SPL_F.csv")

#Let's add the lagged attendance ----

SPL_F <- readr::read_csv("SPL_F.csv")




#Add an empty column
SPL_F %>% 
  add_column(LaggedAttendance = NA) ->SPL_F

#Split the dataframes into lists according to unique value of Home team
TRY <- split(SPL_F, SPL_F$Home)




# The loop to insert the lagged attendance
j=1
while(j <= length(TRY) ) {
  i=2
  while(i <= nrow( TRY[[j]]) ) {
    if( (TRY[[j]]$Week[i] > TRY[[j]]$Week[i-1]) | TRY[[j]]$Week[i]>4 ) {
      TRY[[j]]$LaggedAttendance[i] <-  TRY[[j]]$Attendance[i-1]
      i=i+1
    }
    else {
      TRY[[j]]$LaggedAttendance[i] <-  NA
      i=i+1 }
  }
  j=j+1
}

# To check
i=1
while (i<=26) {
  print(data.frame(TRY[[i]]$Week, TRY[[i]][["LaggedAttendance"]]))
  i=i+1
}

# Irregular value since they played their 1st home game in the 6th week !
TRY[["Al-Batin"]][["LaggedAttendance"]][27] <- NA

# To bind them again and order them according to the index as it was
bind_rows(TRY, .id = "Home") -> SPL_F
SPL_F <- SPL_F[order(SPL_F$Index),]


# Rank Difference----
# Let's add the difference of ranks 
SPL_F %>% 
  mutate(RankDiff = abs(Rank_H-Rank_A)) -> SPL_F
# It you noticed that  there are some matched are not supposed to have Difference Rank = 0
# because they are not in the 1st week, don't worry because these games were postponed

# Game Importance ----
# Let's add game importance as categorical feature based on the following criteria:
# Game importance:
  # Normal matches [1]
  # Cham_Oppo_2nd  [2]
  # Cham_Oppo_1st  &/or Home Celebration [3]

SPL_F %>% 
  mutate(GameImp = 1) -> SPL_F
#Now add manually the values:
SPL_F$GameImp[162] <- 3
SPL_F$GameImp[361] <-3
SPL_F$GameImp[531] <-3
SPL_F$GameImp[716] <-3
SPL_F$GameImp[902] <-3
SPL_F$GameImp[1083] <-3
SPL_F$GameImp[1263] <-3
SPL_F$GameImp[1455] <-3
SPL_F$GameImp[1694] <-3
SPL_F$GameImp[178] <- 3
SPL_F$GameImp[723] <-3
SPL_F$GameImp[908] <-3
SPL_F$GameImp[1087] <-3
SPL_F$GameImp[1271] <-3
SPL_F$GameImp[1456] <-2
SPL_F$GameImp[1690] <-2


#Save the dataframe

#write_csv(SPL_F, "SPL_F1.csv")
