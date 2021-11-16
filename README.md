
![alt text](https://alioh.github.io/images/2019-5-24/spl.png)

# SPL_Attendance_Prediction

This is my capstone Project in the MISK DSI course 2021

The project is about building a machine learning model that predicts the attendance of a Saudi Professional League game by using 17 features. The dataset includes all the 1861 attendance game records since AFC made it mandatory in 2010 until the suspension duo to COVID 19 in 03/2020.

## **HTML Page**

https://ammarhawashem.github.io/SPL_Attendance_Prediction/CapstoneFinalVersion.html

## **Files**

1- The "PreCapstone" file

  includes all the codes that used: from scaping and adding:
  - Attendance
  -  Venue
  -  Then, editing, mergeing all the 10 seasons in one data frame.

2- The "PreCapstone_1" file

  includes the revision of the team names and venues since they were collected from multiple resources. In addition, it includes adding:
  - Longitude of the venues
  - Latitude of the venues
  - Capacity of the venues
  - Twitter followers for both the Home & Away Team
  - Weekend feature
  - The rank feature 

3- The "PreCapstone_2" file 
 
  includes adding the environmental features which are the temperature & Relative humidity and the lagged attendance feature
  
4- The "CapstoneFinalVersion" file 

  The file that have the EDA, feature engineering, modeling, results, & conclusion


 
## **Data**

* The dataframe uthat has all the features  "SPL_F1.csv"



## **Variables Desription**
 Variable  | Description
-------- | -------------
1- Week  | The fixture (Round) [1-26] & [1-30]
2- Home | The name of the home team
3- Away | The name of the away team
4-Venue | The stadium name
5-Capacity | of the venue 
6-H_Followers | The number of twitter followers for the Home Team (assumed to be constant)
7-A_Followers | The number of twitter followers for the Away Team  (assumed to be constant)
8-Rank_H | Position  of Home Team before the this week (1-14) & (1-16)
9-Rank_A | Position of Away Team before the this week
10- RankDiff | The rank difference between the Home & Away Teams
11-Period | Is it Daytime or  night time (17:00 is used to separate)
12-Weekend | Were the game played on a weekend day? (Thus, Fri, Sat + Holidays)
13-TemperatureC | The temperature(Celsius) in the day and time of the match 
14-RH | % of Relative Humidity (estimated from the Temperature and Dew Point)
15-Families | Were women were allowed to attend? (12-01-2018)
16- LaggedAttendance | Attendance one home match earlier 
17- GameImp | Game importance (4 categories)
18- Attendance | of one game which is the target

## **Resources**

* Base Data:
  - https://github.com/alioh/Saudi-Professional-League-Datasets
 
* Attendance & Venue
  - https://fbref.com/en/comps/70/749/schedule/2014-2015-Saudi-Professional-League-Scores-and-Fixtures

  - https://web.archive.org/web/20160705031432/http:/slstat.com/spl2010-2011ar/attendance.php


* Rank
  - https://web.archive.org/web/20160721071334/http:/www.slstat.com/spl2013-2014ar/alltable.php

  - https://www.transfermarkt.com/saudi-professional-league/spieltagtabelle/wettbewerb/SA1/saison_id/2017/spieltag/2

* Temperature & Dew Point
  - https://datasource.kapsarc.org/explore/dataset/saudi-hourly-weather-data
  
  - https://www.transfermarkt.com/saudi-professional-league/spieltagtabelle/wettbewerb/SA1/saison_id/2017/spieltag/2






