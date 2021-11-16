## File 1 ----
# Description
# This file includes mainly:
  # adding the attendance
  # Adding the venues
  # Merge all the seasons in one dataframe



## The base data----
# The resources of the base data are:
# Directly from: https://github.com/alioh/Saudi-Professional-League-Datasets
# &
# Scraping from: https://fbref.com/en/comps/70/749/schedule/2014-2015-Saudi-Professional-League-Scores-and-Fixtures


#Resources of the attendances ----
# 2010 https://web.archive.org/web/20160705031432/http:/slstat.com/spl2010-2011ar/attendance.php
# 2011 https://web.archive.org/web/20160323095921/http:/slstat.com/spl2011-2012ar/attendance.php
# 2012 https://web.archive.org/web/20160507090158/http:/slstat.com/spl2012-2013ar/attendance.php
# 2013 https://web.archive.org/web/20160815174610/http:/www.slstat.com/spl2013-2014ar/attendance.php
# 2014-2019 https://fbref.com/en/comps/70/749/schedule/2014-2015-Saudi-Professional-League-Scores-and-Fixtures

#In this file, we will merge them after adding all the values of the attendances and venues

# Load the libraries ----
#install.packages("eeptools")
#install.packages("chron")
library(tidyverse)
library(rvest)
library(chron)
library(lubridate)

# Import 1st resource  data ----
s10 <- read_csv("SPL/10/10.csv")
s11 <- read_csv("SPL/11/11.csv")
s12 <- read_csv("SPL/12/12.csv")
s13 <- read_csv("SPL/13/13.csv")

# Scrape 2nd reource data ----
## Scrape 2014 ----
link2014 <- "https://fbref.com/en/comps/70/749/schedule/2014-2015-Saudi-Professional-League-Scores-and-Fixtures"
page <- read_html(link2014)

Weak <- page %>% 
  html_nodes(".result_all+ tr th , .right.sort_show , tr:nth-child(1) th.right") %>% 
  html_text()

Day <- page %>% 
  html_nodes(".right.sort_show+ .left , .result_all+ tr th+ .left , tr:nth-child(1) th+ .left") %>% 
  html_text()

Date <- page %>% 
  html_nodes(".left:nth-child(3) a") %>% 
  html_text()

Time <- page %>% 
  html_nodes(".venuetime") %>% 
  html_text()

Home <- page %>% 
  html_nodes(".result_all+ tr .right+ .right , .sort_show~ .right+ .right , tr:nth-child(1) .right+ .right") %>% 
  html_text()

Away <- page %>% 
  html_nodes(".center+ .left a") %>% 
  html_text()

Score <- page %>% 
  html_nodes(".center a") %>% 
  html_text()


# I could not remove the spaces
Attendance <- page %>% 
  html_nodes(".center~ .right") %>% 
  html_text() 

df = as.data.frame(Attendance)
df %>% 
  filter(Attendance!= "") -> Attendance



Venue <- page %>% 
  html_nodes("td.right+ .left") %>% 
  html_text() 
df = as.data.frame(Venue)
df %>% 
  filter(Venue!= "") -> Venue
Venue <- as.vector(Venue)
Venue

# Gather the columns
S2014 <- tibble(Weak, Day,Date, Time, Home, Away, Score, Attendance, Venue )


## Scrape 2015 ----
link2015 <- "https://fbref.com/en/comps/70/1483/schedule/2015-2016-Saudi-Professional-League-Scores-and-Fixtures"
page <- read_html(link2015)

Weak <- page %>% 
  html_nodes(".result_all+ tr th , .right.sort_show , tr:nth-child(1) th.right") %>% 
  html_text()

Day <- page %>% 
  html_nodes(".right.sort_show+ .left , .result_all+ tr th+ .left , tr:nth-child(1) th+ .left") %>% 
  html_text()

Date <- page %>% 
  html_nodes(".left:nth-child(3) a") %>% 
  html_text()

Time <- page %>% 
  html_nodes(".venuetime") %>% 
  html_text()

Home <- page %>% 
  html_nodes(".result_all+ tr .right+ .right , .sort_show~ .right+ .right , tr:nth-child(1) .right+ .right") %>% 
  html_text()

Away <- page %>% 
  html_nodes(".center+ .left a") %>% 
  html_text()

Score <- page %>% 
  html_nodes(".center a") %>% 
  html_text()


# I could not remove the spaces
Attendance <- page %>% 
  html_nodes(".center~ .right") %>% 
  html_text() 

df = as.data.frame(Attendance)
df %>% 
  filter(Attendance!= "") -> Attendance



Venue <- page %>% 
  html_nodes("td.right+ .left") %>% 
  html_text() 
df = as.data.frame(Venue)
df %>% 
  filter(Venue!= "") -> Venue
Venue <- as.vector(Venue)
Venue

S2015 <- tibble(Weak, Day,Date, Time, Home, Away, Score, Attendance, Venue )



## Scrape 2016 ----

link2016 <- "https://fbref.com/en/comps/70/1542/schedule/2016-2017-Saudi-Professional-League-Scores-and-Fixtures"
page <- read_html(link2016)

Weak <- page %>% 
  html_nodes(".result_all+ tr th , .right.sort_show , tr:nth-child(1) th.right") %>% 
  html_text()

Day <- page %>% 
  html_nodes(".right.sort_show+ .left , .result_all+ tr th+ .left , tr:nth-child(1) th+ .left") %>% 
  html_text()

Date <- page %>% 
  html_nodes(".left:nth-child(3) a") %>% 
  html_text()

Time <- page %>% 
  html_nodes(".venuetime") %>% 
  html_text()

Home <- page %>% 
  html_nodes(".result_all+ tr .right+ .right , .sort_show~ .right+ .right , tr:nth-child(1) .right+ .right") %>% 
  html_text()

Away <- page %>% 
  html_nodes(".center+ .left a") %>% 
  html_text()

Score <- page %>% 
  html_nodes(".center a") %>% 
  html_text()


# I could not remove the spaces
Attendance <- page %>% 
  html_nodes(".center~ .right") %>% 
  html_text() 

df = as.data.frame(Attendance)
df %>% 
  filter(Attendance!= "") -> Attendance



Venue <- page %>% 
  html_nodes("td.right+ .left") %>% 
  html_text() 
df = as.data.frame(Venue)
df %>% 
  filter(Venue!= "") -> Venue
Venue <- as.vector(Venue)
Venue

S2016 <- tibble(Weak, Day,Date, Time, Home, Away, Score, Attendance, Venue )


## Scrape 2017 ----

link2017 <- "https://fbref.com/en/comps/70/1647/schedule/2017-2018-Saudi-Professional-League-Scores-and-Fixtures"
page <- read_html(link2017)

Weak <- page %>% 
  html_nodes(".result_all+ tr th , .right.sort_show , tr:nth-child(1) th.right") %>% 
  html_text()

Day <- page %>% 
  html_nodes(".right.sort_show+ .left , .result_all+ tr th+ .left , tr:nth-child(1) th+ .left") %>% 
  html_text()

Date <- page %>% 
  html_nodes(".left:nth-child(3) a") %>% 
  html_text()

Time <- page %>% 
  html_nodes(".venuetime") %>% 
  html_text()

Home <- page %>% 
  html_nodes(".result_all+ tr .right+ .right , .sort_show~ .right+ .right , tr:nth-child(1) .right+ .right") %>% 
  html_text()

Away <- page %>% 
  html_nodes(".center+ .left a") %>% 
  html_text()

Score <- page %>% 
  html_nodes(".center a") %>% 
  html_text()


# I could not remove the spaces
Attendance <- page %>% 
  html_nodes(".center~ .right") %>% 
  html_text() 

df = as.data.frame(Attendance)
df %>% 
  filter(Attendance!= "") -> Attendance



Venue <- page %>% 
  html_nodes("td.right+ .left") %>% 
  html_text() 
df = as.data.frame(Venue)
df %>% 
  filter(Venue!= "") -> Venue
Venue <- as.vector(Venue)
Venue

S2017 <- tibble(Weak, Day,Date, Time, Home, Away, Score, Attendance, Venue )



## Scrape 2018 ----


link2018 <- "https://fbref.com/en/comps/70/2432/schedule/2018-2019-Saudi-Professional-League-Scores-and-Fixtures"
page <- read_html(link2018)

Weak <- page %>% 
  html_nodes(".result_all+ tr th , .right.sort_show , tr:nth-child(1) th.right") %>% 
  html_text()

Day <- page %>% 
  html_nodes(".right.sort_show+ .left , .result_all+ tr th+ .left , tr:nth-child(1) th+ .left") %>% 
  html_text()

Date <- page %>% 
  html_nodes(".left:nth-child(3) a") %>% 
  html_text()

Time <- page %>% 
  html_nodes(".venuetime") %>% 
  html_text()

Home <- page %>% 
  html_nodes(".result_all+ tr .right+ .right , .sort_show~ .right+ .right , tr:nth-child(1) .right+ .right") %>% 
  html_text()

Away <- page %>% 
  html_nodes(".center+ .left a") %>% 
  html_text()

Score <- page %>% 
  html_nodes(".center a") %>% 
  html_text()


# I could not remove the spaces
Attendance <- page %>% 
  html_nodes(".center~ .right") %>% 
  html_text() 

df = as.data.frame(Attendance)
df %>% 
  filter(Attendance!= "") -> Attendance



Venue <- page %>% 
  html_nodes("td.right+ .left") %>% 
  html_text() 
df = as.data.frame(Venue)
df %>% 
  filter(Venue!= "") -> Venue
Venue <- as.vector(Venue)
Venue

S2018 <- tibble(Weak, Day,Date, Time, Home, Away, Score, Attendance, Venue )

## Scrape 2019 ----
# Could not scrape it so it has been filled up manually

S2019 <- read_csv("s20191.csv")

link2019 <- "https://fbref.com/en/comps/70/3266/schedule/2019-2020-Saudi-Professional-League-Scores-and-Fixtures"
page <- read_html(link2019)

Score <- page %>% 
  html_nodes(".center a") %>% 
  html_text()

  Score[1:165] -> Score1
  
  S2019 %>% 
    mutate(Score = Score1) -> S2019
  
#The problem is the order now is not the same


# 1st resource's files adjustment ----
  # Try to merge them then just do it once for all of them
  
## Merge 2010 - 2013 ----
  S10_13 <- bind_rows(s10, s11, s12, s13)
  
  S10_13  %>% 
  select(-matchNo) %>% 
  rename(Weak = Round, Home = Team1, Away =Team2, ScoreH = Score1, ScoreA = Score2 ) -> S10_13

  class(S10_13$Date)
  S10_13$Date = as.Date(S10_13$Date ,format='%d.%m.%Y')
  class(S10_13$Date)
  # Extract the da
  weekdays(S10_13$Date) -> Day
  S10_13 %>% 
    mutate(Day) ->S10_13 
  S10_13 <- S10_13[,c(1,8, 2,3,4,5,6,7) ]

# Uniform Date ----
# Try to merge them then just do it once




#2014
S2014$Date <- as.Date(S2014$Date)

#2015
S2015$Date <- as.Date(S2015$Date)

#2016
S2016$Date <- as.Date(S2016$Date)

#2017
S2017$Date <- as.Date(S2017$Date)

#2018
S2018$Date <- as.Date(S2018$Date)

#2019
S2019$Date = as.Date(S2019$Date ,format='%m/%d/%Y')





# Uniform Day naming ----
# Try to merge them then just do it once
S2014 %>% 
  mutate(Day = case_when(
    Day == "Fri" ~ "Friday",
    Day == "Wed" ~ "Wednesday",
    Day == "Sat" ~ "Saturday",
    Day == "Sun" ~ "Sunday",
    Day == "Tue" ~ "Tuesday",
    Day == "Mon" ~ "Monday",
    TRUE ~ "Thursday"
    )) -> S2014

S2015 %>% 
  mutate(Day = case_when(
    Day == "Fri" ~ "Friday",
    Day == "Wed" ~ "Wednesday",
    Day == "Sat" ~ "Saturday",
    Day == "Sun" ~ "Sunday",
    Day == "Tue" ~ "Tuesday",
    Day == "Mon" ~ "Monday",
    TRUE ~ "Thursday"
  )) -> S2015

S2016 %>% 
  mutate(Day = case_when(
    Day == "Fri" ~ "Friday",
    Day == "Wed" ~ "Wednesday",
    Day == "Sat" ~ "Saturday",
    Day == "Sun" ~ "Sunday",
    Day == "Tue" ~ "Tuesday",
    Day == "Mon" ~ "Monday",
    TRUE ~ "Thursday"
  )) -> S2016

S2017 %>% 
  mutate(Day = case_when(
    Day == "Fri" ~ "Friday",
    Day == "Wed" ~ "Wednesday",
    Day == "Sat" ~ "Saturday",
    Day == "Sun" ~ "Sunday",
    Day == "Tue" ~ "Tuesday",
    Day == "Mon" ~ "Monday",
    TRUE ~ "Thursday"
  )) -> S2017

S2018 %>% 
  mutate(Day = case_when(
    Day == "Fri" ~ "Friday",
    Day == "Wed" ~ "Wednesday",
    Day == "Sat" ~ "Saturday",
    Day == "Sun" ~ "Sunday",
    Day == "Tue" ~ "Tuesday",
    Day == "Mon" ~ "Monday",
    TRUE ~ "Thursday"
  )) -> S2018

S2019 %>% 
  mutate(Day = case_when(
    Day == "Fri" ~ "Friday",
    Day == "Wed" ~ "Wednesday",
    Day == "Sat" ~ "Saturday",
    Day == "Sun" ~ "Sunday",
    Day == "Tue" ~ "Tuesday",
    Day == "Mon" ~ "Monday",
    TRUE ~ "Thursday"
  )) -> S2019

# Merge 2014-2019 ----
### Merge dataframes 2014-2019 to separate the score column
S14_19 <- bind_rows(S2014, S2015, S2016, S2017,S2018,S2019)

glimpse(S2019)
#2019 has the Week and Attendance as double while the rest as characters
# and the time also is as time not character 

S14_18 <- bind_rows(S2014, S2015, S2016, S2017,S2018)
# Convert them into double

as.numeric( S14_18$Weak) -> S14_18$Weak
as.numeric( S14_18$Attendance)
as.numeric(S14_18$Time) -> Q
remove(Q)
# we need to remove "," first

eeptools::decomma( S14_18$Attendance) -> S14_18$Attendance
#Check now 
glimpse(S14_18)

#convert the time feature into time 
paste0(S14_18$Time,":00") ->S14_18$Time

chron::chron(times= S14_18$Time) ->S14_18$Time
#Check
class(S14_18$Time)
chron::chron(times= S2019$Time) ->S2019$Time

# Try now to merge them
S14_19 <- bind_rows(S14_18, S2019)

#Try to separate the score column into two columns
S14_19 %>%
  separate(Score, c("Score1", "Score2")) -> S14_19

# rename(): Use new_name = old_name
  rename(S14_19 ,ScoreH = Score1, ScoreA = Score2) -> S14_19

  
  
# Adding the Attendance & Venues ----
  # for 2010 - 2013
  
# To add attendance and venue for 2010-2013, season by season will be easier. 
  # Why?
  # because teams are changing each season, and it will be easier to adjust the irregulaties (When they play in a different match)
  
# Splitting 10-13 ----
  
  S2010 <- S10_13[1:182, ]                    
  S2011 <- S10_13[183:364, ]                    
  S2012 <- S10_13[365:546, ]                    
  S2013 <- S10_13[547:728, ]                    

  
# 2010 A&V ----
# 2010 already has the venues within  the base dataset itself
s10AV <- read_csv("SPL/10/10A.csv")

S2010 %>% 
  mutate(Attendance = s10AV$Attendance,
         Venue = s10AV$Venue) -> S2010

# 2011 A&V ----
#Attendance
S2011 %>% 
  mutate(Attendance = c(6860 , 181, 943,4225, 5550 , 505 ,8210,
                        483 , 2385 , 12276 ,8619,244 , 15492 ,9549,
                        725 , 164 , 2725 ,443,19658 , 13499 ,5567,
                        22996 , 1391 , 271 ,1846,181 , 3941 ,4503,
                        1879 , 599 , 241 ,3682,3223 , 4110 ,723,
                        247 , 6711 , 2058 ,5218,1330 , 1475 ,1831,
                        2059 , 1858 , 7708 ,9287,2630 , 4357 ,550,
                        2390 , 6482 , 3277 ,873,1121 , 870 ,1576,
                        18400 , 3174 , 17945 ,1036,1175 , 395 ,5344,
                        1828 , 333 , 1193 ,28,7630 , 16195 ,5680,
                        2734 , 469 , 4794 ,2694,9018 , 5247 ,559,
                        3006 , 820 , 321 ,273,18016 , 5860 ,10635,
                        4055 , 3304 , 323 ,1466,8190 , 14827 ,2429,
                        8771 , 1213 , 8420 ,485,9632 , 2649 ,8123,
                        2147 , 1049 , 239 ,345, 7450 , 1100 ,2620,
                        2330 , 4732 , 48 ,1670,3329 , 6600 ,1056,
                        1479 , 3839 , 18009 ,1059, 4163 , 1670 ,17150,
                        306 , 1417 , 998 ,1243,3743 , 8227 ,363,
                        2534 ,4649 , 1435 ,5243, 1050 , 9891 ,350,
                        489 , 125 , 7033 ,4532, 1089 , 15200 ,1221,
                        96 , 650 , 2431 ,3638, 7862 , 22523,8544,
                        1200 , 1893 , 1026 ,6204, 1751, 9767 ,144,
                        1753 , 6407 , 6664 ,12117,3366 , 4672 ,1558,
                        16924 , 836 , 967 ,121, 1050 , 33 ,1820,
                        1817 , 8736 , 6697 ,473,203 , 176 ,18624,
                        588 , 683 , 352 ,17200,6905 , 1000 ,33)) -> S2011
  

#Venue
S2011 %>% 
  mutate(Venue = case_when(
    Home == "Al-Shabab" ~ "Prince Faisal bin Fahad Stadium",
    Home == "Al Ahli SC" ~ "Prince Abdullah Al-Faisal Stadium",
    Home == "Al-Hilal" ~ "Prince Faisal bin Fahad Stadium",
    Home == "Al-Ettifaq" ~ "Prince Mohamed bin Fahd Stadium",
    Home == "Al-Ittihad FC" ~ "Prince Abdullah Al-Faisal Stadium",
    Home == "Al-Fateh" ~ "Prince Abdullah Bin Jalawi Sport City Stadium",
    Home == "Al-Nassr" ~ "Prince Faisal bin Fahad Stadium",
    Home == "Al-Faisaly" ~ "King Salman Bin Abdul Aziz Sport City Stadium",
    Home == "Najran" ~ "AlAkhdoud Club Stadium",
    Home == "Al-Raed" ~ "King Abdullah Sport City Stadium",
    Home == "Hajer" ~ "Prince Abdullah Bin Jalawi Sport City Stadium",
    Home == "Al-Taawon" ~ "King Abdullah Sport City Stadium",
    Home == "Al Qadisiya" ~ "Prince Saud Bin Jalawi Sport City Stadium",
    Home == "Al Ansar" ~ "Prince Mohammed bin Abdul Aziz Stadium"
)) -> S2011

#Do the adjustment where they did not play in the regular venue

S2011$Venue[5] = "King Fahad International Stadium"
S2011$Venue[10] = "King Fahad International Stadium"
S2011$Venue[12] = "Alansar Club Stadium"
S2011$Venue[15]  = "King Fahad International Stadium"
S2011$Venue[22] = "King Fahad International Stadium"
S2011$Venue[25] = "King Fahad International Stadium"
S2011$Venue[50] = "Prince Mohamed bin Fahd Stadium"
S2011$Venue[144] = "King Fahad International Stadium"
S2011$Venue[149] = "King Fahad International Stadium"
S2011$Venue[158] = "King Fahad International Stadium"
S2011$Venue[159] = "King Fahad International Stadium"
S2011$Venue[164] = "King Fahad International Stadium"
S2011$Venue[169] = "King Fahad International Stadium"
S2011$Venue[178] = "King Fahad International Stadium"





# 2012 A&V ----

#Attendance
ATT12 <- read_csv("ATT12_1.csv") #Edited by Excel from the resource to match the order of the base dataset

S2012 %>% 
  mutate(Attendance = ATT12$Attendance) -> S2012

#There is a mistake in the 1st feature, the teams were replaced in position, so let's fix it
S2012$Home[4] <- S2012$Away[4]
S2012$Away[4] <- "Al-Ittihad FC"

#Venue
# Use the previous sheet and replace the 2 teams that were kicked out to the lower(1st) division
S2012 %>% 
  mutate(Venue = case_when(
    Home == "Al-Fateh" ~ "Prince Abdullah Bin Jalawi Sport City Stadium",
    Home == "Al-Hilal" ~ "Prince Faisal bin Fahad Stadium",
    Home == "Al-Shabab" ~ "Prince Faisal bin Fahad Stadium",
    Home == "Al-Nassr" ~ "King Fahad International Stadium",
    Home == "Al Ahli SC" ~ "Prince Abdullah Al-Faisal Stadium",
    Home == "Al-Ettifaq" ~ "Prince Mohamed bin Fahd Stadium",
    Home == "Al-Ittihad FC" ~ "Prince Abdullah Al-Faisal Stadium",
    Home == "Al-Raed" ~ "King Abdullah Sport City Stadium",
    Home == "Al-Shoalah" ~ "Al-Shoalah Club Stadium",
    Home == "Najran" ~ "AlAkhdoud Club Stadium",
    Home == "Al-Faisaly" ~ "King Salman Bin Abdul Aziz Sport City Stadium",
    Home == "Al-Taawon" ~ "King Abdullah Sport City Stadium",
    Home == "Hajer" ~ "Prince Abdullah Bin Jalawi Sport City Stadium",
    Home == "Al Wehda" ~ "King Abdul Aziz Stadium"
  )) -> S2012
#Do the adjustment where they did not play in the regular venue

#Hilal
S2012$Venue[12] = "King Fahad International Stadium"
S2012$Venue[45] = "King Fahad International Stadium"
S2012$Venue[79] = "King Fahad International Stadium"
S2012$Venue[91] = "King Fahad International Stadium"
S2012$Venue[107] = "King Fahad International Stadium"
S2012$Venue[131] = "King Fahad International Stadium"
S2012$Venue[151] = "King Fahad International Stadium"
S2012$Venue[157] = "King Fahad International Stadium"
#Shabab
S2012$Venue[3] = "King Fahad International Stadium"
S2012$Venue[49] = "King Fahad International Stadium"
S2012$Venue[75] = "King Fahad International Stadium"
S2012$Venue[100] = "King Fahad International Stadium"
S2012$Venue[114] = "King Fahad International Stadium"
S2012$Venue[128] = "King Fahad International Stadium"
S2012$Venue[165] = "King Fahad International Stadium"
S2012$Venue[179] = "King Fahad International Stadium"
#Alnasr
S2012$Venue[67] = "Prince Faisal bin Fahad Stadium"
S2012$Venue[116] = "Prince Faisal bin Fahad Stadium"
#Ahli
S2012$Venue[86] = "King Abdul Aziz Stadium"
S2012$Venue[101] = "King Abdul Aziz Stadium"
S2012$Venue[106] = "King Abdul Aziz Stadium"
S2012$Venue[112] = "King Abdul Aziz Stadium"
S2012$Venue[132] = "King Abdul Aziz Stadium"
S2012$Venue[152] = "King Abdul Aziz Stadium"
S2012$Venue[154] = "King Abdul Aziz Stadium"
S2012$Venue[182] = "King Abdul Aziz Stadium"
#Itihad
S2012$Venue[88] = "King Abdul Aziz Stadium"
S2012$Venue[90] = "King Abdul Aziz Stadium"
S2012$Venue[96] = "King Abdul Aziz Stadium"
S2012$Venue[109] = "King Abdul Aziz Stadium"
S2012$Venue[123] = "King Abdul Aziz Stadium"
S2012$Venue[140] = "King Abdul Aziz Stadium"
S2012$Venue[153] = "King Abdul Aziz Stadium"
S2012$Venue[166] = "King Abdul Aziz Stadium"
S2012$Venue[173] = "King Abdul Aziz Stadium"
#Ettifaq
S2012$Venue[103] = "Prince Saud Bin Jalawi Sport City Stadium"
#Al-Shoalah
S2012$Venue[36] = "Prince Faisal bin Fahad Stadium"





# 2013 A&V ----
#Attendance
ATT13 <- read_csv("ATT13_1.csv") #Edited from the resource to match the order of the base dataset

S2013 %>% 
  mutate(Attendance = ATT13$Attendance) -> S2013

#There is a mistake in the 1st feature, the teams were replaced in position, so let's fix it
S2013$Home[4] <- S2013$Away[4]
"Al-Ettifaq" -> S2013$Away[4]

# 2013 Venue scraping ----
#Venue
specialLink2013 <- "https://web.archive.org/web/20140403095155/http://slstat.com/spl2013-2014ar/statdet.php?id=177"
pages2013 <- read_html(specialLink2013)

matchLink <- pages2013 %>%
  html_nodes("#table5 .fontbluea") %>% 
  html_attr("href") %>% 
  paste("https://web.archive.org/web/20140403140732/http://www.slstat.com/spl2013-2014ar/", ., sep = "")

# Create function to get: round, Venue, & Team 
getRound <- function(match_Link) {
  Match_page <- read_html(match_Link)
  Round <-   Match_page %>%
    html_nodes("tr+ tr .fontblue:nth-child(1) .fontblack") %>% 
    html_text()
  return(Round)
}

ROUND <- sapply(matchLink, FUN = getRound )




getVenue <- function(match_Link) {
  Match_page <- read_html(match_Link)
  venuee <-   Match_page %>%
    html_nodes(".fontblue+ .fontblue .fontblacka") %>% 
    html_text()
  return(venuee)
  
}


VENUEE <- sapply(matchLink, FUN = getVenue )



getHome <- function(match_Link) {
  Match_page <- read_html(match_Link)
  Team <-   Match_page %>%
    html_nodes(".fontblack .fontblack .fontblack .fontblack:nth-child(1) tr:nth-child(1) .fontblackt a:nth-child(1)") %>% 
    html_text()
  return(Team)
  
  
}
TEAM <- sapply(matchLink, FUN = getHome )



df_2013 <- data.frame(ROUND, VENUEE, TEAM)
# merge them in a  dataframe or use regex

# Use the previous sheet and replace the 2 teams that were kicked out to the lower(1st) division
S2013 %>% 
  mutate(Venue = case_when(
    Home == "Al Ahli SC" ~ "Prince Mohammed Alabdullah Stadium",
    Home == "Al-Ittihad FC" ~ "King Abdul Aziz Stadium",
    Home == "Al-Ettifaq" ~ "Prince Mohamed bin Fahd Stadium",
    Home == "Al-Taawon" ~ "King Abdullah Sport City Stadium",
    Home == "Al-Raed" ~ "King Abdullah Sport City Stadium",
    Home == "Al-Shabab" ~ "Prince Faisal bin Fahad Stadium",
    Home == "Al-Shoalah" ~ "Al-Shoalah Club Stadium",
    Home == "Al-Fateh" ~ "Prince Abdullah Bin Jalawi Sport City Stadium",
    Home == "Al-Faisaly" ~ "King Salman Bin Abdul Aziz Sport City Stadium",
    Home == "Al-Nassr" ~ "King Fahad International Stadium",
    Home == "Al-Hilal" ~ "King Fahad International Stadium",
    Home == "Najran" ~ "AlAkhdoud Club Stadium",
    Home == "Al Orubah" ~ "Al Orubah Club Stadium",
    Home == "Al-Nahda" ~ "Prince Mohamed bin Fahd Stadium"
  )) -> S2013

#Do the adjustment where they did not play in the regular venue

# AlAhli
S2013$Venue[14] = "King Abdul Aziz Stadium"
S2013$Venue[15] = "King Abdul Aziz Stadium"
S2013$Venue[35] = "King Abdul Aziz Stadium"
S2013$Venue[130] = "King Abdul Aziz Stadium"
S2013$Venue[168] = "King Abdul Aziz Stadium"
# AlTawoon
S2013$Venue[177] = "King Fahad International Stadium"
# Alshabab
S2013$Venue[16] = "King Fahad International Stadium"
S2013$Venue[27] = "King Fahad International Stadium"
S2013$Venue[44] = "King Fahad International Stadium"
S2013$Venue[124] = "King Fahad International Stadium"
S2013$Venue[127] = "King Fahad International Stadium"
S2013$Venue[141] = "King Fahad International Stadium"
S2013$Venue[170] = "King Fahad International Stadium"
# AlNasr
S2013$Venue[83] = "Prince Faisal bin Fahad Stadium"
S2013$Venue[85] = "Prince Faisal bin Fahad Stadium"
# AlHilal
S2013$Venue[89] = "Prince Faisal bin Fahad Stadium"
S2013$Venue[108] = "Prince Faisal bin Fahad Stadium"
S2013$Venue[166] = "Prince Faisal bin Fahad Stadium"
S2013$Venue[173] = "Prince Faisal bin Fahad Stadium"


# Merge 2010-2013 ----
S10_13 <- bind_rows(S2010, S2011, S2012, S2013)
class(S10_13$Time)  
chron::chron(times= S10_13$Time) ->S10_13$Time
#Check
class(S10_13$Time)  

## Try to merge them
glimpse(S10_13)
glimpse(S14_19)

as.numeric(S14_19$ScoreH) -> S14_19$ScoreH
as.numeric(S14_19$ScoreA) -> S14_19$ScoreA
glimpse(S14_19)

# Merge 10_13-14_19 ----
bind_rows(S10_13, S14_19 ) -> s10_19

# Save the file ----
write_csv(s10_19,"SPL.csv")
