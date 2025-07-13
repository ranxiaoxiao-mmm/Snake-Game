cmake_minimum_required(VERSION 3.26)
project(CMakeSFMLProject LANGUAGES CXX)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

include(FetchContent)
FetchContent_Declare(SFML
    URL file://${CMAKE_SOURCE_DIR}/3rd/SFML-2.6.2.zip
    )
FetchContent_MakeAvailable(SFML)

add_executable(main sfSnake/main.cpp sfSnake/Fruit.cpp sfSnake/Fruit.h sfSnake/Game.cpp sfSnake/Game.h sfSnake/GameOverScreen.cpp sfSnake/GameOverScreen.h sfSnake/GameScreen.cpp sfSnake/GameScreen.h sfSnake/MenuScreen.cpp sfSnake/MenuScreen.h sfSnake/Screen.cpp sfSnake/Screen.h sfSnake/Snake.cpp sfSnake/Snake.h sfSnake/SnakeNode.cpp sfSnake/SnakeNode.h sfSnake/Button.cpp sfSnake/Button.h sfSnake/Grid.cpp sfSnake/Grid.h sfSnake/HelpScreen.cpp sfSnake/HelpScreen.h sfSnake/OptionButton.cpp sfSnake/OptionButton.h sfSnake/OptionScreen.cpp sfSnake/OptionScreen.h sfSnake/PauseScreen.cpp sfSnake/PauseScreen.h sfSnake/GameMode.h sfSnake/ModeScreen.cpp sfSnake/ModeScreen.h)
target_sources(main PRIVATE sfSnake/main.cpp sfSnake/Fruit.cpp sfSnake/Fruit.h sfSnake/Game.cpp sfSnake/Game.h sfSnake/GameOverScreen.cpp sfSnake/GameOverScreen.h sfSnake/GameScreen.cpp sfSnake/GameScreen.h sfSnake/MenuScreen.cpp sfSnake/MenuScreen.h sfSnake/Screen.cpp sfSnake/Screen.h sfSnake/Snake.cpp sfSnake/Snake.h sfSnake/SnakeNode.cpp sfSnake/SnakeNode.h sfSnake/Button.cpp sfSnake/Button.h sfSnake/Grid.cpp sfSnake/Grid.h sfSnake/HelpScreen.cpp sfSnake/HelpScreen.h sfSnake/OptionButton.cpp sfSnake/OptionButton.h sfSnake/OptionScreen.cpp sfSnake/OptionScreen.h sfSnake/PauseScreen.cpp sfSnake/PauseScreen.h sfSnake/GameMode.h sfSnake/ModeScreen.cpp sfSnake/ModeScreen.h)
target_compile_features(main PRIVATE cxx_std_17)
# target_include_directories(main PRIVATE ${CMAKE_SOURCE_DIR}/3rd/include)
# target_link_directories(main PRIVATE ${CMAKE_SOURCE_DIR}/3rd/lib)
target_link_libraries(main PRIVATE sfml-graphics sfml-window sfml-system sfml-audio sfml-network)


file(COPY ${CMAKE_SOURCE_DIR}/sfSnake/Fonts DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
file(COPY ${CMAKE_SOURCE_DIR}/sfSnake/Music DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
file(COPY ${CMAKE_SOURCE_DIR}/sfSnake/Pic DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
file(COPY ${CMAKE_SOURCE_DIR}/sfSnake/Sounds DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})