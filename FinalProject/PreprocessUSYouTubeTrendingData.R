## Final Project 
##
## Author: Zachary G. Lacey
## Email: zlacey@g.ucla.edu
## Date: November 10th, 2021
##
## Course: STATS 202A - Statistics Programming
## Assignment: Final Project
## Due Date: November 29th, 2021
##
## Final Project - Youtube Trending Analytics
## 

library(Rcpp)
library(tidyverse)

## Loading Youtube Trending Analytics

YoutubeTrendingAnalyticsData = read_csv("US_youtube_trending_data.csv")
  

##
removeDuplicatedVideos = function(originalDataFrame) {

 # Sort the data frame based on Video ID
 sortedOriginalDataFrame = originalDataFrame %>%
   arrange(video_id, trending_date, desc(view_count))
 
 # 
 removedDuplicatedVideosDataFrame = originalDataFrame[
   !duplicated(
     originalDataFrame[c("video_id", "trending_date")]), ]
}

YoutubeTrendingAnalyticsData = 
  removeDuplicatedVideos(YoutubeTrendingAnalyticsData)


## Removes the repeated videos (videos that were on trending page
## multiple days).
removeRepeatedVideos = function(originalDataFrame) {

  # Sort the data frame based on Video ID
  sortedOriginalDataFrame = originalDataFrame %>% arrange(video_id)

  # A vector that shows which videos are repeated videos (videos that were
  # on trending page at some prior date(s)).
  dupicatedVideosBoolean = duplicated(sortedOriginalDataFrame$video_id)

  # Total number of videos
  numVideos = length(dupicatedVideosBoolean)

  # Vector which will contain the counted days that a video is on the
  # trending page of YouTube
  daysTrending = vector("numeric", length = numVideos)


  # Counting the duplicated videos (based on repeated Video IDs)
  for (videoIdx in 1:numVideos) {

    # If the video is a unique element (not a duplicate of a prior
    # element)
    if (dupicatedVideosBoolean[videoIdx] == FALSE) {

      # Keep track of it's video index
      originalVideoIdx = videoIdx

      # Set it as the first day on trending
      videoDaysOnTrending = 1
    }

    # Store the counted days that a video is on the trending page of
    # YouTube
    daysTrending[originalVideoIdx] = videoDaysOnTrending

    # Iterate the number of days a video is on trending for each repeated
    # video (iterate whenever an element is a duplicate of the prior
    # element)
    videoDaysOnTrending = videoDaysOnTrending + 1
  }

  # Adds a column to house the number of days that a video is on the
  # trending page.
  updatedSortedDataFrame = sortedOriginalDataFrame %>%
    mutate(days_trending = daysTrending)

  # Longest number of days that a video is on the trending page.
  longestNumberDaysTrending = max(daysTrending)

  # A matrix to hold the date times that a video is on the trending page
  daysTrendingDates = matrix(nrow = numVideos,
                             ncol = longestNumberDaysTrending)

  # Store the date times (including the days that a videos stays on the
  # trending page of YouTube)
  for (videoIdx in 1:numVideos) {

    # If the video is a unique element (not a duplicate of a prior
    # element)
    if (dupicatedVideosBoolean[videoIdx] == FALSE) {

      # Keep track of it's video index
      originalVideoIdx = videoIdx

      # Set it as the first day on trending
      videoDaysOnTrending = 1
    }

    # Store the date times that a video is on the trending page
    daysTrendingDates[originalVideoIdx, videoDaysOnTrending] =
      sortedOriginalDataFrame$trending_date[videoIdx]

    # Iterate the number of days a video is on trending for each repeated
    # video (iterate whenever an element is a duplicate of the prior
    # element)
    videoDaysOnTrending = videoDaysOnTrending + 1
  }

  # Convert the matrix to a data frame
  daysTrendingDatesDataFrame = as.data.frame(daysTrendingDates)

  # Rename the columns of the 'daysTrendingDatesDataFrame' data frame
  for (dayTrendingIdx in 1:longestNumberDaysTrending) {

    # Column name 'trending_day_date {i}' where 'i' is the ith day that a
    # video is on YouTube's trending page.
    trendingDayDateStr = paste('trending_day_date', dayTrendingIdx)
    names(daysTrendingDatesDataFrame)[dayTrendingIdx] = trendingDayDateStr

    # Convert the elements in the 'daysTrendingDatesDataFrame' data frame
    # back to a dttm format (date time). Note: When the dttm from the
    # original 'trending_date' values from the original Comma Separated
    # Value (csv) file was stored into the the 'daysTrendingDates' matrix,
    # the values were coerced into 'numeric' values (i.e., 1638045677 is
    # numeric value or Unix time stamp [epoch time stamp] of the
    # [Nov 27, 2021 8:41:17 PM GMT] date time)
    daysTrendingDatesDataFrame[, dayTrendingIdx] =
      as.POSIXct(daysTrendingDatesDataFrame[, dayTrendingIdx],
                 origin = "1970-01-01", tz = "UTC")
  }

  # Bind the two data frames by columns
  mergedDataFrame = cbind(updatedSortedDataFrame,
                          daysTrendingDatesDataFrame)

  # Remove any videos (rows) that include the repeated videos. This is
  # done to reduce the observation numbers (as we view observations as a
  # single unique video) and make the data frame tidy format.
  distinctVideosDataFrame =
    mergedDataFrame %>% distinct(video_id, .keep_all = TRUE)
}

# Make the original U.S. YouTube Trending Data into a more compact tidy
# format.
YoutubeTrendingAnalyticsDataRemoveRepeatedVideos =
  removeRepeatedVideos(YoutubeTrendingAnalyticsData)


## Organize (Filter) data based on Video Category

# Film and Animation (ID: 1)
FilmAndAnimationTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 1)

write_csv(FilmAndAnimationTrendingData,
          'FilmAndAnimationTrendingData.csv')

# Autos and Vehicles (ID: 2)
AutosAndVehiclesTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 2)

write_csv(AutosAndVehiclesTrendingData,
          'AutosAndVehiclesTrendingData.csv')

# Music (ID: 10)
MusicTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 10)

write_csv(MusicTrendingData,
          'MusicTrendingData.csv')

# Pets and Animals (ID: 15)
PetsAndAnimalsTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 15)

write_csv(PetsAndAnimalsTrendingData,
          'PetsAndAnimalsTrendingData.csv')

# Sports (ID: 17)
SportsTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 17)

write_csv(SportsTrendingData,
          'SportsTrendingData.csv')

# Travel and Events (ID: 19)
TravelAndEventsTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 19)

write_csv(TravelAndEventsTrendingData,
          'TravelAndEventsTrendingData.csv')

# Gaming (ID: 20)
GamingTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 20)

write_csv(GamingTrendingData,
          'GamingTrendingData.csv')

# People and Blogging (ID: 22)
PeopleAndBloggingTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 22)

write_csv(PeopleAndBloggingTrendingData,
          'PeopleAndBloggingTrendingData.csv')

# Comedy (ID: 23)
ComedyTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 23)

write_csv(ComedyTrendingData,
          'ComedyTrendingData.csv')

# Entertainment (ID: 24)
EntertainmentTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 24)

write_csv(EntertainmentTrendingData,
          'EntertainmentTrendingData.csv')

# News and Politics (ID: 25)
NewsAndPoliticsTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 25)

write_csv(NewsAndPoliticsTrendingData,
          'NewsAndPoliticsTrendingData.csv')

# Howto and Style (ID: 26)
HowtoAndStyleTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 26)

write_csv(HowtoAndStyleTrendingData,
          'HowtoAndStyleTrendingData.csv')

# Education (ID: 27)
EducationTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 27)

write_csv(EducationTrendingData,
          'EducationTrendingData.csv')

# Science and Technology (ID: 28)
ScienceAndTechnologyTrendingData =
  filter(YoutubeTrendingAnalyticsDataRemoveRepeatedVideos,
         categoryId == 28)

write_csv(ScienceAndTechnologyTrendingData,
          'ScienceAndTechnologyTrendingData.csv')

print("Finished")