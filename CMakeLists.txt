cmake_minimum_required(VERSION 3.10)

project(hello)
enable_language(C Fortran)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(generalflags "-Wall -Wextra")
set(speedflags "-Ofast")
set(debugflags "-O0 -g")

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${generalflags}")
set(CMAKE_Fortran_FLAGS_RELEASE "${CMAKE_Fortran_FLAGS} ${CMAKE_Fortran_FLAGS_RELEASE} ${generalflags} ${speedflags}")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS} ${CMAKE_Fortran_FLAGS_DEBUG} ${generalflags} ${debugflags} -fcheck=all")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${generalflags}")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_RELEASE} ${generalflags} ${speedflags}")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG} ${generalflags} ${debugflags}")

add_library(utilities ${CMAKE_SOURCE_DIR}/lib/utilities.f90)
add_library(clusterlabelling ${CMAKE_SOURCE_DIR}/lib/clusterlabelling.f90)
add_library(hk ${CMAKE_SOURCE_DIR}/lib/hk.c)

add_dependencies(clusterlabelling utilities hk)

set(mylibraries utilities clusterlabelling lapack hk)

function(addexewithlibs name)
    add_executable(${name} ${CMAKE_SOURCE_DIR}/src/${name}.f90)
    target_link_libraries(${name} ${mylibraries})
endfunction()

foreach(exe verification speedtest stuff b c f g)
    addexewithlibs(${exe})
endforeach()
