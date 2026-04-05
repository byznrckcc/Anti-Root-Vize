# 🛡️ Anti-Root Analysis: Android Security Bypass & Infrastructure
**Hazırlayan:** Beyzanur Çakıcı  
**Öğrenci No:** 2420191032  
**Bölüm:** İstinye Üniversitesi - Bilgi Güvenliği Teknolojisi  

---

## 🎯 Proje Vizyonu ve Giriş
Bu proje, modern Android uygulamalarında bulunan "Root Detection" (Kök Dizini Tespiti) mekanizmalarını atlatmak için geliştirilmiştir. Analiz hedefi olarak **OWASP UnCrackable Level 1** seçilmiştir. Proje, sadece statik bir yama değil; izole analiz ortamları ve modern yazılım süreçlerini (CI/CD) kapsayan tam donanımlı bir güvenlik altyapısı sunar.

---

## 🏗️ Adım 1: Kurulum ve `auto_patcher.sh` Analizi (Reverse Engineering)
Analiz sürecini standartlaştırmak için özel bir **Bash Automation Script** geliştirilmiştir.

* **İşlev:** `scripts/auto_patcher.sh`, hedef APK'yı `apktool` kullanarak parçalar (decompile), smali kodlarına müdahale imkanı tanır ve ardından `apksigner` ile vizeye özel oluşturulan `.keystore` ile imzalar.
* **Kritik Soru (Güvenlik):** Script içerisindeki araçlar resmi repo adreslerinden çekilmiştir. Siber güvenlik etiği gereği, dışarıdan çekilen her binary dosyasının (örneğin apktool.jar) **Hash (SHA-256)** kontrollerinin yapılması, "man-in-the-middle" saldırılarını engellemek adına raporumuza eklenmiştir.

---

## 🧹 Adım 2: İzolasyon ve İz Bırakmadan Temizlik (Forensics & Cleanup)
Güvenlik testlerinin en kritik aşaması, test yapılan sisteme zarar vermemek ve kalıntı bırakmamaktır.

* **Uygulama:** Tüm analiz süreci `environment/Dockerfile` ile ayağa kaldırılan izole bir **Docker** konteyneri içerisinde yürütülmüştür.
* **Temizlik İspatı:** Konteyner durdurulduğunda (`docker compose down`), analiz sırasında oluşan tüm geçici loglar, `.smali` kalıntıları ve sistem cache'leri ana makineye (host) sızmadan yok edilir. `ps aux` kontrolleriyle arka planda hiçbir analiz servisinin kalmadığı ispatlanmıştır.

---

## ⛓️ Adım 3: İş Akışları ve CI/CD Pipeline Analizi
Proje, kurumsal SecOps standartlarına uygun bir **CI/CD (Sürekli Entegrasyon)** akışına sahiptir.

* **Mekanizma:** `.github/workflows/security-scan.yml` dosyası, her `push` işleminde projenin bütünlüğünü test eder.
* **Kritik Soru (Webhook):** Webhook, bu projenin GitHub tarafındaki değişimlerini (push/pull) CI/CD sunucusuna anlık olarak haber veren bir "habercidir". Webhook sayesinde kod her değiştiğinde otomatize testler (`docker build` vb.) anında tetiklenir.

---

## 🐳 Adım 4: Docker Mimarisi ve Konteyner Güvenliği
Analiz ortamımız "Modern Uygulama" standartlarında paketlenmiştir.

* **Mimari:** İmaj, `kali-rolling` tabanlıdır. Katmanlı (Layered) dosya sistemi sayesinde sadece gerekli araçlar (`openjdk`, `android-tools`) eklenerek imaj boyutu optimize edilmiştir.
* **Güvenlik:** Konteyner, ana makinenin (Kernel) kaynaklarını paylaşsa da, `Namespaces` ve `Control Groups (cgroups)` sayesinde izole edilmiştir. Bu, sanal makinelere (VM) göre çok daha hafif ve hızlı bir analiz ortamı sağlar.

---

## 🎯 Adım 5: Kaynak Kod ve Akış Analizi (Threat Modeling)
Uygulamanın zafiyet analizi ve bypass stratejisi şu şekildedir:

* **Entrypoint:** Uygulama `sg.vantagepoint.uncrackable1.MainActivity` üzerinden tetiklenir.
* **Bypass Stratejisi:** `sg.vantagepoint.a.c` sınıfındaki cihaz denetim metodları (`a`, `b`, `c`) statik analizle tespit edilmiştir. 
* **Uygulama:** İlk olarak `scripts/bypass.js` (Frida) ile dinamik müdahale tasarlanmıştır. Donanım kısıtları nedeniyle süreç statik yamaya (Smali Patching) evrilmiştir. Metodların geri dönüş değerleri `0x0` (False) yapılarak güvenlik bariyerleri kalıcı olarak aşılmıştır.
* **Ele Geçirilen Veri (Flag):** `I want to believe`

---

## 🏁 Sonuç ve Başarı Kanıtı
Yapılan çalışmalar sonucunda Anti-Root mekanizması tamamen etkisiz hale getirilmiş ve uygulamanın ana ekranına başarıyla ulaşılmıştır.

![Bypass Success](./screenshots/IMG-20260404-WA0000(1).jpg)
