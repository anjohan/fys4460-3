cmake_minimum_required(VERSION 3.10)

project(hello)
enable_language(Fortran)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -Wall -Wextra -fopenmp -O2")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} -O0 -g -fcheck=all")

add_library(utilities ${CMAKE_SOURCE_DIR}/lib/utilities.f90)
add_library(clusterlabelling ${CMAKE_SOURCE_DIR}/lib/clusterlabelling.f90)

add_dependencies(clusterlabelling utilities)

set(mylibraries utilities clusterlabelling lapack)

function(addexewithlibs name)
    add_executable(${name} ${CMAKE_SOURCE_DIR}/src/${name}.f90)
    target_link_libraries(${name} ${mylibraries})
endfunction()

foreach(exe verification speedtest stuff b c)
    addexewithlibs(${exe})
endforeach()
