message("Using Windows Mingw toolchain")
set(CMAKE_SYSTEM_NAME Windows)
set(ARCH x86_64)

set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)

# Setup path for MinGW
set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32)

# Cross-compile
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Disable search for system libs and headers in Linux
set(CMAKE_SYSROOT /usr/x86_64-w64-mingw32)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

include_directories(SYSTEM /usr/x86_64-w64-mingw32/include)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_C_FLAGS "-static-libgcc")
set(CMAKE_CXX_FLAGS "-static-libgcc -static-libstdc++")

# Optimization
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -fPIC -flto -fdata-sections -ffunction-sections -fvisibility=hidden -fomit-frame-pointer -DNDEBUG")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -fPIC -flto -fdata-sections -ffunction-sections -fvisibility=hidden -fomit-frame-pointer -DNDEBUG")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -fno-exceptions")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-Bstatic -lgcc -lstdc++ -Wl,-Bdynamic -s")
# set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--gc-sections,-s")
