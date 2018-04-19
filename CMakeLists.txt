cmake_minimum_required(VERSION 3.10)

project(hello)
enable_language(Fortran)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -Wall -Wextra -fopenmp")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -fbounds-check")

file(GLOB_RECURSE lib  lib/*.f90)
add_executable(speedtest src/speedtest.f90 ${lib})
add_executable(stuff src/stuff.f90 ${lib})

message(STATUS ${CMAKE_Fortran_FLAGS})
