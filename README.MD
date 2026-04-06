<p align="center">
  <img src="https://logovector.org/wp-content/uploads/2021/12/istinye-universitesi-logo-vektorel.png" width="200" alt="İstinye Üniversitesi Logo">
</p>

<h1 align="center">🛡️ PROJE: ANTİ-ROOT ANALYSİS</h1>
<p align="center">
  <strong>İstinye Üniversitesi - Bilgi Güvenliği Teknolojisi</strong><br>
  <em>Siber Güvenlik Vize Projesi: Android Security Bypass & Infrastructure</em>
</p>

---

| Özellik | Detay |
| :--- | :--- |
| **Zorluk Seviyesi** | 🚀 9/10 (Legendary) |
| **Geliştirici** | **Beyzanur Çakıcı** |
| **Rol** | Güvenlik Uzmanı / Sistem Mimarı |
| **Teknoloji** | Frida, Smali, Docker, Bash, CI/CD |

---

## 🎬 PROJE DEMO VİDEOSU
> **ÖNEMLİ:** Projenin bypass mekanizması, dinamik hooking süreci ve Antigravity AI doğrulaması aşağıdaki videoda yer almaktadır.
> 
> **İzlemek için tıklayın:** [🎥 Project Demo Video](./demo/project-demo.mkv)

---

## 📝 Proje Özeti
Bu proje, modern Android uygulamalarındaki en büyük güvenlik bariyerlerinden biri olan **"Kök Dizini Tespiti" (Root Detection)** sorununa hibrit bir çözüm sunar. Analiz hedefi olarak seçilen **OWASP UnCrackable Level 1** uygulaması üzerinde; sadece statik bir yama değil, izole analiz ortamları ve modern yazılım süreçlerini (CI/CD) kapsayan tam donanımlı bir güvenlik altyapısı kurulmuştur.

---

## 🔍 Analiz Aşamaları (Vize Projesi Görevleri)

### 1️⃣ Kurulum ve Güvenlik Analizi (Reverse Engineering)
* **Analiz:** Uygulamanın statik analiz aşamasında `apktool` ile parçalanan kaynak kodlar üzerinde `sg.vantagepoint.a.c` sınıfının cihaz denetimi yaptığı tespit edilmiştir.
* **Güvenlik Çözümü:** `scripts/auto_patcher.sh` scripti ile otomatize edilen süreçte, terminal yetkileri ve dizin izinleri analiz edilmiş; uygulamanın bütünlüğü bozulmadan `smali` seviyesinde müdahale imkanı sağlanmıştır.

### 2️⃣ Bellek Yönetimi ve Adli Bilişim (Forensics)
* **Analiz:** Frida-server aracılığıyla uygulamanın runtime (çalışma zamanı) sırasındaki bellek hareketleri ve `Logcat` çıktıları incelenmiştir.
* **Kritik Soru:** Analizden sonra sistemde veri sızıntısı kalıyor mu?
> **Cevap:** Proje kapsamında kurulan **Docker** konteyner yapısı sayesinde, tüm analiz araçları ve geçici dosyalar izole bir RAM alanında tutulur. Konteyner kapatıldığında, ana makine üzerinde hiçbir adli iz (forensic trace) bırakılmadan sistem temizlenir.

### 3️⃣ İş Akışları ve CI/CD (DevSecOps)
* **Analiz:** `.env` dosyası ve GitHub Actions kullanımıyla analiz pipeline'ı kurulmuştur.
* **Kritik Soru:** Webhook ne işe yarar?
> **Cevap:** Kod tabanında (örneğin `bypass.js` dosyasında) yapılan bir değişiklik, GitHub üzerinden otomatik olarak bir derleme sürecini tetikler. Bu sayede güvenlik testleri her güncellemede "Sessizce" doğrulanır.

### 4️⃣ Docker Mimarisi ve Network İzolasyonu
* **Analiz:** Analiz ortamı, dış dünyadan izole edilmiş bir Kali Linux Docker imajı üzerinde çalışmaktadır.
* **Kritik Soru:** İzolasyon sağlanmazsa ne olur?
> **Cevap:** Saldırgan bir APK (Malware), analiz sırasında ana makinenin (Host) dosya sistemine veya kernel yetkilerine sızabilir. Docker sayesinde bu risk tamamen ortadan kaldırılmış, süreç sanal bir kum havuzuna (Sandbox) hapsedilmiştir.

### 5️⃣ Tehdit Modelleme ve Akış Analizi (Fail-Safe)
* **Analiz:** Sistemin root tespiti durumundaki "Kapanma" (Fail-Closed) davranışı test edilmiştir.
* **Kritik Soru:** Root tespiti engellenemezse ne olur?
> **Cevap:** Uygulama güvenlik riski almamak için `System.exit(0)` çağrısı yaparak kendini kapatır. Bu projede, bu akış dinamik olarak (Frida) ve statik olarak (Smali) manipüle edilerek sistemin her koşulda **"Fail-Safe"** kalması sağlanmıştır.

---

## 🔥 Canavar Özelliği: Dinamik Flag Capture (Secret Interception)
Bu projeyi sıradan projelerden ayıran en büyük özellik, root bypass edilirken aynı anda bellekteki verinin yakalanmasıdır:

1. **Memory Hooking:** Frida scripti, uygulamanın AES deşifreleme metoduna kanca (hook) atar.
2. **Flag Capture:** Uygulama ana ekrana geçerken, bellekte açılan gizli "Secret Key" (Flag) otomatik olarak terminale basılır.
3. **Gerçek Zamanlı Analiz:** Bu sayede kaba kuvvet saldırılarına gerek kalmadan, uygulama çalışırken bayrak ele geçirilir.

---

## 🚀 Çalıştırma ve Test (Kali Linux)

```bash
# 1. Analiz Ortamını Başlat (Docker)
docker build -t anti-root-analysis .
docker run -it anti-root-analysis /bin/bash

# 2. Frida ile Dinamik Bypass ve Flag Capture
frida -U -f com.example.uncrackable1 -l scripts/bypass.js

# 3. Otomatik Smali Patching (Statik Analiz)
./scripts/auto_patcher.sh

📊 Teknik Çıktılar

Sistem başarılı bir analiz sonunda şu yanıtı vererek güvenliği kanıtlamaktadır:
JSON

{
  "status": "BYPASS_SUCCESS",
  "security_check": "ROOT_HIDDEN",
  "captured_flag": "I want to believe",
  "infrastructure": "Docker_Isolation_Active"
}