set(CMAKE_SYSTEM_NAME Windows)

set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_RC_COMPILER llvm-rc)
set(ARCH x86_64)

set(WINDOWS_SDK_PATH "/opt/windows_sdk/10")

set(CMAKE_SHARED_LINKER_FLAGS "-static -static-libgcc -static-libstdc++")

# Ensure we're targeting Windows
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -target x86_64-pc-windows-msvc -L${WINDOWS_SDK_PATH}/lib/um/x64 -L${WINDOWS_SDK_PATH}/lib/msvc/x64 -L${WINDOWS_SDK_PATH}/lib/ucrt/x64 -I${WINDOWS_SDK_PATH}/include/ucrt -I${WINDOWS_SDK_PATH}/include/msvc -I${WINDOWS_SDK_PATH}/include/um -I${WINDOWS_SDK_PATH}/include/shared")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -target x86_64-pc-windows-msvc -L${WINDOWS_SDK_PATH}/lib/um/x64 -L${WINDOWS_SDK_PATH}/lib/msvc/x64 -L${WINDOWS_SDK_PATH}/lib/ucrt/x64 -I${WINDOWS_SDK_PATH}/include/ucrt -I${WINDOWS_SDK_PATH}/include/msvc -I${WINDOWS_SDK_PATH}/include/um -I${WINDOWS_SDK_PATH}/include/shared")

# Enable optimizations for performance and size
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -flto -mcpu=x86-64-v3 -fvisibility=hidden -fno-rtti -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3 -flto -mcpu=x86-64-v3 -fvisibility=hidden -fno-unwind-tables -fno-asynchronous-unwind-tables")

# Ensure exported functions are properly included
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=default")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fvisibility=default")

# Set paths to Windows SDK (adjust as necessary)


# Minimize DLL size
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -lgcc -lgcc_eh -lpthread -lm -Wl,--gc-sections,--strip-all,--exclude-all-symbols,--icf=all,--end-group,-s")

# Set path to MinGW-w64 system libraries
# set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32)

# Ensure Clang uses MinGW libraries
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -L${WINDOWS_SDK_PATH}/lib/um/x64 -L${WINDOWS_SDK_PATH}/lib/msvc/x64 -L${WINDOWS_SDK_PATH}/lib/ucrt/x64 -fuse-ld=lld -static")


# Include directories
include_directories("${WINDOWS_SDK_PATH}/include")
link_directories("${WINDOWS_SDK_PATH}/lib")

# Set library paths explicitly
# link_directories(/usr/x86_64-w64-mingw32/lib)
# include_directories(SYSTEM /usr/x86_64-w64-mingw32/include)
message("${WINDOWS_SDK_PATH}/include")
message("${WINDOWS_SDK_PATH}/lib")