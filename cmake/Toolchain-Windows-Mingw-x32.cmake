message("Using Windows Mingw toolchain")
set(CMAKE_SYSTEM_NAME Windows)
set(ARCH x32)

set(CMAKE_C_COMPILER i686-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER i686-w64-mingw32-g++)

set(CMAKE_C_FLAGS "-static -static-libgcc -static-libstdc++")
set(CMAKE_CXX_FLAGS "-static -static-libgcc -static-libstdc++")
set(CMAKE_EXE_LINKER_FLAGS "-static")

# Optimization
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O1 -fPIC")
