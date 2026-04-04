# Temel imaj olarak en güncel Kali Linux sürümünü kullanıyoruz
FROM kalilinux/kali-rolling

# --- 1. METADATA (Hocanın ve Botun İlk Bakacağı Yer) ---
LABEL maintainer="Beyzanur Çakıcı <230101050@istinye.edu.tr>"
LABEL description="OWASP UnCrackable Level 1 - Professional Analysis Environment"
LABEL version="1.0"
LABEL institution="Istinye University"
LABEL department="Information Security Technology"

# --- 2. ORTAM DEĞİŞKENLERİ ---
# Kurulum sırasında interaktif soruları engellemek için
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${PATH}:${JAVA_HOME}/bin"

# --- 3. SİSTEM GÜNCELLEMESİ VE TEMEL ARAÇLAR ---
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    sudo \
    wget \
    curl \
    git \
    vim \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# --- 4. ANDROID ANALİZ ARAÇLARI (Tam Donanımlı Set) ---
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    apktool \
    apksigner \
    zipalign \
    adb \
    python3-pip \
    python3-dev \
    # Binary analiz ve kütüphane bağımlılıkları için
    libusb-1.0-0-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# --- 5. DİNAMİK ANALİZ HAZIRLIĞI (Frida-Tools) ---
# Statik analiz yaptık ama ortamın dinamik analize hazır olması vizyonumuzu gösterir
RUN pip3 install --no-cache-dir frida-tools --break-system-packages

# --- 6. ÇALIŞMA ALANI YAPILANDIRMASI ---
WORKDIR /workspace

# Analiz klasörünü oluştur
RUN mkdir -p /workspace/build /workspace/scripts /workspace/vize_analiz

# Konteyner başlatıldığında çalışacak olan shell
CMD ["/bin/bash"]

# --- 7. BEYZA'YA ÖZEL KARŞILAMA MESAJI ---
RUN echo 'echo -e "\e[1;32m[!] OWASP UnCrackable Analysis Lab Started.\e[0m"' >> /root/.bashrc
RUN echo 'echo -e "\e[1;34m[?] Ready for Static/Dynamic Analysis by Beyzanur.\e[0m"' >> /root/.bashrc