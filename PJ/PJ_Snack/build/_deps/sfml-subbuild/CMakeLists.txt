# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.26.0)

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(sfml-populate NONE)



include(ExternalProject)
ExternalProject_Add(sfml-populate
                     "UPDATE_DISCONNECTED" "False" "DOWNLOAD_EXTRACT_TIMESTAMP" "FALSE" "URL" "file://D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/3rd/SFML-2.6.2.zip"
                    SOURCE_DIR          "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-src"
                    BINARY_DIR          "D:/Archive/subject/two_two/OOP/lab/PJ/PJ_Snack/build/_deps/sfml-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
                    USES_TERMINAL_PATCH     YES
)


