message("Using Windows Mingw toolchain")
set(CMAKE_SYSTEM_NAME Windows)
set(ARCH x64)

set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)

# Устанавливаем правильные пути для MinGW
set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32)

# Указываем, что мы кросс-компилируем
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Отключаем поиск системных заголовков и библиотек Linux
set(CMAKE_SYSROOT /usr/x86_64-w64-mingw32)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# add_definitions(_D_WINDOWS)

# add_definitions(-D__USE_MINGW_ANSI_STDIO=1)
# add_definitions(-D_WINDOWS)
include_directories(SYSTEM /usr/x86_64-w64-mingw32/include)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_C_FLAGS "-static -static-libgcc -static-libstdc++")
set(CMAKE_CXX_FLAGS "-static -static-libgcc -static-libstdc++")
# set(CMAKE_EXE_LINKER_FLAGS "-static")

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static -static-libgcc -static-libstdc++ -Wl,-Bstatic,--whole-archive -lucrt -Wl,--no-whole-archive")

# Оптимизация
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O1 -fPIC")
