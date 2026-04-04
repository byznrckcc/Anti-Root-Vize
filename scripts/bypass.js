/* 🛡️ Anti-Root & Flag Capture Script (Professional Edition)
   Target: UnCrackable Level 1
   Developer: Beyzanur Çakıcı
*/

Java.perform(function () {
    console.log("\n[*] Script yüklendi, operasyon başlıyor...");

    // --- 1. BÖLÜM: Root Kontrollerini Kandırma (Bypass) ---
    // Uygulamanın 'Burası güvenli mi?' sorusuna her zaman 'Evet' (false) cevabı veriyoruz.
    var RootChecker = Java.use("sg.vantagepoint.a.c");
    
    RootChecker.a.implementation = function () { 
        console.log("[!] Root Check 'a' bypassed!");
        return false; 
    };
    RootChecker.b.implementation = function () { 
        console.log("[!] Root Check 'b' bypassed!");
        return false; 
    };
    RootChecker.c.implementation = function () { 
        console.log("[!] Root Check 'c' bypassed!");
        return false; 
    };
    console.log("[+] Root bypass mekanizmaları aktif edildi.");

    // --- 2. BÖLÜM: Gizli Şifreyi (Secret String) Yakalama ---
    // Şifrenin çözüldüğü tam o anı yakalayıp ekrana yazdırıyoruz.
    var Decryptor = Java.use("sg.vantagepoint.a.a");
    Decryptor.a.implementation = function (arg1, arg2) {
        var retval = this.a(arg1, arg2);
        var password = "";
        for (var i = 0; i < retval.length; i++) {
            password += String.fromCharCode(retval[i]);
        }
        console.log("-------------------------------------------");
        console.log("[HEDEF BULUNDU] Gizli Şifre: " + password);
        console.log("-------------------------------------------");
        return retval;
    };
});