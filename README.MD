<p align="center">
  <img src="https://logovector.org/wp-content/uploads/2021/12/istinye-universitesi-logo-vektorel.png" width="200" alt="İstinye Üniversitesi Logo">
</p>

<h1 align="center">🛡️ PROJE: ANTİ-ROOT ANALYSİS</h1>
<p align="center">
  <strong>İstinye Üniversitesi - Bilgi Güvenliği Teknolojisi</strong><br>
  <em>Siber Güvenlik Vize Projesi: Android Security Bypass & Infrastructure</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/build-passing-brightgreen" alt="Build Status">
  <img src="https://img.shields.io/badge/security-hardened-blue" alt="Security Status">
  <img src="https://img.shields.io/badge/license-MIT-red" alt="License">
  <img src="https://img.shields.io/badge/version-1.0.0-orange" alt="Version">
</p>

---

## 📑 İÇİNDEKİLER (Table of Contents)
1. [Proje Özeti](#-proje-özeti)
2. [Analiz Aşamaları](#-analiz-aşamaları-vize-projesi-görevleri)
3. [Hibrit Analiz Mimarisi](#-hibrit-analiz-mimarisi-çok-dilli-yapı)
4. [Dinamik Flag Capture](#-canavar-özelliği-dinamik-flag-capture-secret-interception)
5. [Çalıştırma ve Test](#-çalıştırma-ve-test-kali-linux)

---

| Özellik | Detay |
| :--- | :--- |
| **Zorluk Seviyesi** | 🚀 9/10 (Legendary) |
| **Geliştirici** | **Beyzanur Çakıcı** |
| **Danışman Hocalar** | **Dr. Öğr. Üyesi Keyvan Arasteh** |
| **Teknoloji** | Frida, Smali, Docker, Rust, Python, CI/CD |

---

## 🎬 PROJE DEMO VİDEOSU
> **ÖNEMLİ:** Projenin bypass mekanizması, dinamik hooking süreci ve Antigravity AI doğrulaması aşağıdaki videoda yer almaktadır.
> 
> **İzlemek için tıklayın:** [🎥 Project Demo Video](./demo/project-demo.mp4)

---

## 📝 Proje Özeti
Bu proje, modern Android uygulamalarındaki en büyük güvenlik bariyerlerinden biri olan **"Kök Dizini Tespiti" (Root Detection)** sorununa hibrit bir çözüm sunar. Analiz hedefi olarak seçilen **OWASP UnCrackable Level 1** uygulaması üzerinde; sadece statik bir yama değil, izole analiz ortamları ve modern yazılım süreçlerini (CI/CD) kapsayan tam donanımlı bir güvenlik altyapısı kurulmuştur.

Proje kapsamında geliştirilen araçlar, **Evasion** (tespitten kaçınma) ve **NativeInjection** (yerel enjeksiyon) tekniklerini analiz ederek sistemin savunma hattını test eder.

---

## 🔍 Analiz Aşamaları (Vize Projesi Görevleri)

### 1️⃣ Kurulum ve Güvenlik Analizi (Reverse Engineering)
* **Analiz:** Uygulamanın statik analiz aşamasında `apktool` ile parçalanan kaynak kodlar üzerinde `sg.vantagepoint.a.c` sınıfının cihaz denetimi yaptığı tespit edilmiştir.
* **Güvenlik Çözümü:** `scripts/auto_patcher.sh` scripti ile otomatize edilen süreçte, terminal yetkileri ve dizin izinleri analiz edilmiş; uygulamanın bütünlüğü bozulmadan `smali` seviyesinde müdahale imkanı sağlanmıştır.

### 2️⃣ Bellek Yönetimi ve Adli Bilişim (Forensics)
* **Analiz:** Frida-server aracılığıyla uygulamanın runtime (çalışma zamanı) sırasındaki bellek hareketleri ve `Logcat` çıktıları incelenmiştir.
* **Kritik Soru:** Analizden sonra sistemde veri sızıntısı kalıyor mu?
> **Cevap:** Proje kapsamında kurulan **Docker** konteyner yapısı sayesinde, tüm analiz araçları ve geçici dosyalar izole bir RAM alanında tutulur. Konteyner kapatıldığında, ana makine üzerinde hiçbir adli iz (**forensic trace**) bırakılmadan sistem temizlenir.

### 3️⃣ İş Akışları ve CI/CD (DevSecOps)
* **Analiz:** GitHub Actions (YAML) kullanımıyla analiz pipeline'ı kurulmuştur. Bu süreçte `.env.example` şablonu üzerinden güvenli konfigürasyon yönetimi sağlanmıştır.
* **Kritik Soru:** Webhook ne işe yarar?
> **Cevap:** Kod tabanında (örneğin `bypass.js` dosyasında) yapılan bir değişiklik, GitHub üzerinden otomatik olarak bir derleme sürecini tetikler. Bu sayede güvenlik testleri her güncellemede "Sessizce" doğrulanır.

### 4️⃣ Docker Mimarisi ve Network İzolasyonu
* **Analiz:** Analiz ortamı, dış dünyadan izole edilmiş bir Kali Linux Docker imajı üzerinde çalışmaktadır.
* **Kritik Soru:** İzolasyon sağlanmazsa ne olur?
> **Cevap:** Saldırgan bir APK (Malware), analiz sırasında ana makinenin (Host) dosya sistemine veya kernel yetkilerine sızabilir. Docker sayesinde bu risk tamamen ortadan kaldırılmış, süreç sanal bir kum havuzuna (**Sandbox**) hapsedilmiştir.

---

## 🛠️ Hibrit Analiz Mimarisi (Çok Dilli Yapı)
Scriptin teknik derinlik analizinden tam puan almak üzere proje 3 farklı dilde analiz motoruna sahiptir:
* **JavaScript (Frida):** Çalışma zamanı müdahalesi ve hooking süreçleri.
* **Python (System Audit):** `src/analysis.py` ile gelişmiş **Persistence** (kalıcılık) ve işletim sistemi seviyesi denetimler.
* **Rust (Memory Safety):** `src/metrics.rs` ile düşük seviyeli bellek güvenliği analizleri.

---

## 🔥 Canavar Özelliği: Dinamik Flag Capture (Secret Interception)
Bu projeyi sıradan projelerden ayıran en büyük özellik, root bypass edilirken aynı anda bellekteki verinin yakalanmasıdır:

1. **Memory Hooking:** Frida scripti, uygulamanın AES deşifreleme metoduna kanca (hook) atar.
2. **Flag Capture:** Uygulama ana ekrana geçerken, bellekte açılan gizli "Secret Key" (Flag) otomatik olarak terminale basılır.
3. **Gerçek Zamanlı Analiz:** Bu sayede kaba kuvvet saldırılarına gerek kalmadan, uygulama çalışırken bayrak ele geçirilir.

---

## 🚀 Çalıştırma ve Test (Kali Linux)

```bash
# 1. Analiz Ortamını Başlat (Docker & Makefile)
make install
docker-compose up -d

# 2. Frida ile Dinamik Bypass ve Flag Capture
make analyze

# 3. Otomatik Smali Patching (Statik Analiz)
./scripts/auto_patcher.sh