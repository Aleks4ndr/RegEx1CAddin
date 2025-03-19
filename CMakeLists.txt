cmake_minimum_required(VERSION 3.15)
project(AddInNative LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include_directories(${CMAKE_SOURCE_DIR}/include)

include(FetchContent)

# ==== Определение версии проекта ====
set(PROJECT_VERSION "1.0.0")

# ==== Определение архитектуры ====
if (NOT ARCH)
    if (CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(ARCH "x64")
    else()
        set(ARCH "x86")
    endif()
endif()
message(STATUS "Building for architecture: ${ARCH}")

# ==== Определение платформы ====
if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(PLATFORM "linux")
elseif (CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(PLATFORM "win")
else()
    set(PLATFORM "unknown")
endif()
message(STATUS "Target platform: ${PLATFORM}")

# ==== Подключение PCRE2 через FetchContent ====
FetchContent_Declare(
    pcre2
    GIT_REPOSITORY https://github.com/PCRE2Project/pcre2.git
    GIT_TAG pcre2-10.45
)

set(PCRE2_BUILD_PCRE2_8 OFF CACHE BOOL "" FORCE)
set(PCRE2_BUILD_PCRE2_16 ON CACHE BOOL "" FORCE)
set(PCRE2_BUILD_PCRE2_32 OFF CACHE BOOL "" FORCE)
set(PCRE2_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(PCRE2_BUILD_SHARED OFF CACHE BOOL "" FORCE)  # Отключаем динамическую сборку
set(PCRE2_BUILD_STATIC ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(pcre2)

# ==== Файлы проекта ====
SET(AddInNative_SRC 
    AddInNative.cpp
    AddInNative.h
    dllmain.cpp
    stdafx.cpp
    stdafx.h
    StrConv.cpp
    json.cpp
    )

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

if(WIN32)
    SET(AddInDef_SRC AddInNative.def)
    SET(CMAKE_LINK_DEF_FILE_FLAG AddInNative.def)
    add_definitions(-DUNICODE -DWIN32)
endif()

# ==== Создание библиотеки ====
add_library(${PROJECT_NAME} SHARED ${SOURCES} ${HEADERS} ${AddInDef_SRC})

# ==== Линковка PCRE2 (статически) ====
target_link_libraries(${PROJECT_NAME} pcre2-16-static)

# ==== Генерация имени файла ====
set(OUTPUT_NAME "${PROJECT_NAME}-${PROJECT_VERSION}-${PLATFORM}-${ARCH}")

set_target_properties(${PROJECT_NAME} PROPERTIES
    CLEAN_DIRECT_OUTPUT 1
    OUTPUT_NAME ${OUTPUT_NAME}
    ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

message(STATUS "Output file: ${OUTPUT_NAME}")

# # Cmake script for project AddInNative
# # autor: 1C

# CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)

# message("CMAKE_SIZEOF_VOID_P:" CMAKE_SIZEOF_VOID_P)

# SET(CPU "32" CACHE STRING "Some user-specified option")

# #if(CMAKE_SIZEOF_VOID_P EQUAL 8)
# #    set(CPU "64")
# #else()
# #    set(CPU "32")
# #endif()

# message("CPU:" ${CPU} " SYSTEM: " ${CMAKE_GENERATOR})

# PROJECT(AddInNative)



# include_directories(${CMAKE_SOURCE_DIR}/include)

# SET (CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${CMAKE_SOURCE_DIR})

# add_library(${PROJECT_NAME} SHARED ${AddInNative_SRC} ${AddInDef_SRC})

# if (UNIX)
# #    set_source_files_properties(${AddInNative_SRC}
# #                              PROPERTIES COMPILE_FLAGS
# #                              "-fPIC ")
# set (CMAKE_CXX_FLAGS " -std=c++11 -O1 -fPIC ")
							  
# target_link_libraries(${PROJECT_NAME} -L${CMAKE_SOURCE_DIR}/lib/linux/x${CPU}/)
# target_link_libraries(${PROJECT_NAME} -lboost_regex)
							  
# else()
#     target_link_libraries(${PROJECT_NAME} -L${CMAKE_SOURCE_DIR}/lib/win/x${CPU}/)
	
# 	if(CMAKE_SIZEOF_VOID_P EQUAL 8)
#     target_link_libraries(${PROJECT_NAME} -lboost_regex-vc141-mt-s-x64-1_69)
#     elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
#     target_link_libraries(${PROJECT_NAME} -lboost_regex-vc141-mt-s-x32-1_69)
#     endif()

#     SET(AddInDef_SRC AddInNative.def)
#     SET(CMAKE_LINK_DEF_FILE_FLAG AddInNative.def)
#     add_definitions(-DUNICODE -DWIN32 )
# endif()

# set_target_properties( ${PROJECT_NAME} PROPERTIES
#    CLEAN_DIRECT_OUTPUT 1
#    # avoid conflicts between library and binary target names
#    OUTPUT_NAME ${PROJECT_NAME}${MySuffix1}${MySuffix2} 
#    #WINDOWS_EXPORT_ALL_SYMBOLS TRUE
#    )

