# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-src"
  "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-build"
  "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-subbuild/sfml-populate-prefix"
  "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-subbuild/sfml-populate-prefix/tmp"
  "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-subbuild/sfml-populate-prefix/src/sfml-populate-stamp"
  "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-subbuild/sfml-populate-prefix/src"
  "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-subbuild/sfml-populate-prefix/src/sfml-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-subbuild/sfml-populate-prefix/src/sfml-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-subbuild/sfml-populate-prefix/src/sfml-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
