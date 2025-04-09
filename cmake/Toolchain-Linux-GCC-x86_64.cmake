set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)

# static linking of libgcc and libstdc++
set(CMAKE_C_FLAGS "-static-libgcc")
set(CMAKE_CXX_FLAGS "-static-libstdc++ -static-libgcc")

# Optimization
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -fPIC -march=x86-64-v4 -flto -fdata-sections -ffunction-sections -fno-rtti -fno-exceptions -fomit-frame-pointer -DNDEBUG")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -fPIC -march=x86-64-v4  -flto -fdata-sections -ffunction-sections -fomit-frame-pointer -DNDEBUG")

set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -s -fdata-sections -ffunction-sections")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3 -s -fdata-sections -ffunction-sections")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--gc-sections,--strip-all,--exclude-libs,-s")
