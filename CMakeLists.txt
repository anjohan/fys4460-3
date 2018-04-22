cmake_minimum_required(VERSION 3.10)

project(hello)
enable_language(Fortran)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -Wall -Wextra -fopenmp")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -fbounds-check")

add_library(utilities ${CMAKE_SOURCE_DIR}/lib/utilities.f90)
add_library(clusterlabelling ${CMAKE_SOURCE_DIR}/lib/clusterlabelling.f90)

set(mylibraries utilities clusterlabelling)

add_executable(verification ${CMAKE_SOURCE_DIR}/src/verification.f90)
add_executable(stuff ${CMAKE_SOURCE_DIR}/src/stuff.f90)

target_link_libraries(verification ${mylibraries})
target_link_libraries(stuff ${mylibraries})

add_executable(b ${CMAKE_SOURCE_DIR}/src/b.f90)
target_link_libraries(b ${mylibraries})
