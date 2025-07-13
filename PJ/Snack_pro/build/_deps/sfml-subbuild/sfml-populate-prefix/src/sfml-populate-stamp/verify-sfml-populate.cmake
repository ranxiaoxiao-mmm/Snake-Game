# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

if("D:/Archive/subject/two_two/OOP/lab/PJ/Snack_pro/3rd/SFML-2.6.2.zip" STREQUAL "")
  message(FATAL_ERROR "LOCAL can't be empty")
endif()

if(NOT EXISTS "D:/Archive/subject/two_two/OOP/lab/PJ/Snack_pro/3rd/SFML-2.6.2.zip")
  message(FATAL_ERROR "File not found: D:/Archive/subject/two_two/OOP/lab/PJ/Snack_pro/3rd/SFML-2.6.2.zip")
endif()

if("" STREQUAL "")
  message(WARNING "File will not be verified since no URL_HASH specified")
  return()
endif()

if("" STREQUAL "")
  message(FATAL_ERROR "EXPECT_VALUE can't be empty")
endif()

message(STATUS "verifying file...
     file='D:/Archive/subject/two_two/OOP/lab/PJ/Snack_pro/3rd/SFML-2.6.2.zip'")

file("" "D:/Archive/subject/two_two/OOP/lab/PJ/Snack_pro/3rd/SFML-2.6.2.zip" actual_value)

if(NOT "${actual_value}" STREQUAL "")
  message(FATAL_ERROR "error:  hash of
  D:/Archive/subject/two_two/OOP/lab/PJ/Snack_pro/3rd/SFML-2.6.2.zip
does not match expected value
  expected: ''
    actual: '${actual_value}'
")
endif()

message(STATUS "verifying file... done")
