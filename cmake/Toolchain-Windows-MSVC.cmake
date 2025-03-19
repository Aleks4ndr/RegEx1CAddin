set(CMAKE_SYSTEM_NAME Windows)

set(CMAKE_C_COMPILER cl)
set(CMAKE_CXX_COMPILER cl)

if (ARCH STREQUAL "x64")
    set(CMAKE_GENERATOR_PLATFORM x64)
elseif (ARCH STREQUAL "x86")
    set(CMAKE_GENERATOR_PLATFORM Win32)
else()
    message(FATAL_ERROR "Unknown architecture: ${ARCH}")
endif()

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
