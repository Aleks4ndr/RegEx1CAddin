cmake_minimum_required(VERSION 3.15)
project(AddInNative LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include_directories(${CMAKE_SOURCE_DIR}/include)
include(FetchContent)

set(PROJECT_VERSION "1.0.0")

if (NOT ARCH)
    if (CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(ARCH "x64")
    else()
        set(ARCH "x86")
    endif()
endif()
message(STATUS "Building for architecture: ${ARCH}")

if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(PLATFORM "linux")
elseif (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(PLATFORM "win")
else()
    set(PLATFORM "unknown")
endif()
message(STATUS "Target platform: ${PLATFORM}")

FetchContent_Declare(
    pcre2
    GIT_REPOSITORY https://github.com/PCRE2Project/pcre2.git
    GIT_TAG 2dce776
)

set(PCRE2_BUILD_PCRE2_8 OFF CACHE BOOL "" FORCE)
set(PCRE2_BUILD_PCRE2_16 ON CACHE BOOL "" FORCE)
set(PCRE2_BUILD_PCRE2_32 OFF CACHE BOOL "" FORCE)
set(PCRE2_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(PCRE2_BUILD_SHARED OFF CACHE BOOL "" FORCE) 
set(PCRE2_BUILD_STATIC ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(pcre2)

set(SOURCES
    AddInNative.cpp
    StrConv.cpp
    stdafx.cpp
    dllmain.cpp
    json.cpp
)

set(HEADERS
    AddInNative.h
    StrConv.h
    stdafx.h
    json.h
)

add_library(${PROJECT_NAME} SHARED ${SOURCES} ${HEADERS} ${AddInDef_SRC})

if(WIN32)
    set(AddInDef_SRC ${CMAKE_CURRENT_SOURCE_DIR}/AddInNative.def)
    if(MINGW)
        target_link_options(${PROJECT_NAME} PRIVATE -Wl,--output-def=AddInNative.def)
    elseif(MSVC)
        set(CMAKE_LINK_DEF_FILE_FLAG AddInNative.def)
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        if (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC")
            # using clang with clang-cl front end
        elseif (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "GNU")
            # using clang with regular front end
        endif()
    else()
        message(FATAL_ERROR "Check you compiler for exporint funcions. See AddInNative.def")
    endif()
    
    add_definitions(-DUNICODE -DWIN32)
elseif(UNIX)
    message("add linker file script")
    # set_target_properties(AddInNative PROPERTIES LINK_FLAGS "-Wl,--version-script=${CMAKE_SOURCE_DIR}/exports.map")
    target_link_options(${PROJECT_NAME} PRIVATE
        -Wl,--version-script=${CMAKE_SOURCE_DIR}/exports.map
    )
else()
    message(FATAL_ERROR "Cannot identify system")
    # set(AddInDef_SRC ${CMAKE_CURRENT_SOURCE_DIR}/exports.map)
endif()

target_link_libraries(${PROJECT_NAME} pcre2-16-static)

set(OUTPUT_NAME "${PROJECT_NAME}-${PROJECT_VERSION}-${PLATFORM}-${ARCH}")

set_target_properties(${PROJECT_NAME} PROPERTIES
    CLEAN_DIRECT_OUTPUT 1
    OUTPUT_NAME ${OUTPUT_NAME}
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/package
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/package
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/package
)

message(STATUS "Output file: ${OUTPUT_NAME}")