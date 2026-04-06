FROM kalilinux/kali-rolling

RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    android-sdk \
    apktool \
    frida-tools \
    python3-pip \
    wget \
    curl \
    git

WORKDIR /analyze
COPY . /analyze

# Analiz araçlarını hazırla
RUN chmod +x /analyze/scripts/*.sh 2>/dev/null || true

CMD ["/bin/bash"]