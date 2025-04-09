# Базовый образ Ubuntu 24.04
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
# RUN find /opt/windows_sdk/10/Lib/ -type f -name "*.Lib" -exec bash -c 'mv "$0" "${0%.Lib}.lib"' {} \;
# Обновление пакетов и установка зависимостей
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    libc6-dev \
    # libc6-dev-i386 \
    libstdc++6 \
    build-essential \
    gcc g++ \
    gcc-multilib g++-multilib \
    cmake ninja-build \
    make git wget curl 
    
ARG http_proxy
ARG https_proxy
RUN apt-get install -y \
    mingw-w64 
    # clang lld lldb 
    
    # libstdc++6:i386 \
    # && rm -rf /var/lib/apt/lists/*


# COPY windows_sdk /opt/windows_sdk
# RUN find /opt/windows_sdk/10/lib -depth -exec bash -c 'f="$1"; mv "$f" "$(dirname "$f")/$(basename "$f" | tr A-Z a-z)"' _ {} \;
# # RUN find /opt/windows_sdk/10/include -depth -exec bash -c 'f="$1"; ln -s "$(dirname "$f")/$(basename "$f" | tr A-Z a-z)"' _ {} "$f" \;
# RUN find /opt/windows_sdk/10/include -type f -exec sh -c 'ln -s "$1" "$(dirname "$1")/$(basename "$1" | tr A-Z a-z)"' _ {} \; 2>/dev/null
# RUN mv /opt/windows_sdk/10/include/shared/driverspecs.h /opt/windows_sdk/10/include/shared/DriverSpecs.h \
#     && ln -s /opt/windows_sdk/10/include/shared/DriverSpecs.h /opt/windows_sdk/10/include/shared/driverspecs.h \
#     mv /opt/windows_sdk/10/include/shared/specstrings.h /opt/windows_sdk/10/include/shared/SpecStrings.h \
#     && ln -s /opt/windows_sdk/10/include/shared/SpecStrings.h /opt/windows_sdk/10/include/shared/specstrings.h \
# ENV WINDOWS_SDK_PATH="/opt/windows-sdk"
# Устанавливаем архитектуру 32-бит для сборки 32-битных версий
# RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y \
#     libc6:i386 libstdc++6:i386 \
#     && rm -rf /var/lib/apt/lists/*

WORKDIR /build
CMD ["/bin/bash"]
# Use toolchain file 
# ARG TOOLCHAIN_FILE
# ENV TOOLCHAIN_FILE=${TOOLCHAIN_FILE}

# Command for building project
# ENTRYPOINT [ "cmake" ]
#CMD  rm -rf build/CMakeFiles build/CmakeCache.txt build/_deps && cmake -S . -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/${TOOLCHAIN_FILE}.cmake && cmake --build build --config Release
