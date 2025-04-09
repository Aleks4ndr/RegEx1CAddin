set(CMAKE_SYSTEM_NAME Linux)
set(ARCH x86_64)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)

set(CMAKE_C_FLAGS "-static-libgcc -static-libstdc++")
set(CMAKE_CXX_FLAGS "-static-libgcc -static-libstdc++")
set(CMAKE_SHARED_LINKER_FLAGS "-static")
