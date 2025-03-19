set(CMAKE_SYSTEM_NAME Windows)

set(CMAKE_C_COMPILER cl)
set(CMAKE_CXX_COMPILER cl)

set (ARCH "x64")
set(CMAKE_GENERATOR_PLATFORM x64)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
# add_definitions(-D_WINDOWS)