#!/bin/bash

# --- Ayarlar ---
APK_NAME="UnCrackable-Level1.apk"
DECODE_DIR="vize_analiz"
KEYSTORE="vize.keystore"
ALIAS="vize"
PASS="123456"

echo "[*] Operasyon Başlıyor: $APK_NAME"

# 1. Decompile
echo "[+] Dosya parçalanıyor (Decompile)..."
apktool d ../build/$APK_NAME -o $DECODE_DIR

echo "--------------------------------------------------------"
echo "[!] DUR! Şimdi Smali kodunu manuel düzenle."
echo "Dosya: $DECODE_DIR/smali/sg/vantagepoint/a/c.smali"
echo "Düzenleme bittikten sonra buraya gel ve ENTER'a bas..."
read -p ""
echo "--------------------------------------------------------"

# 2. Rebuild
echo "[+] APK tekrar toplanıyor (Rebuild)..."
apktool b $DECODE_DIR -o ../build/patched_unsigned.apk

# 3. Signing
echo "[+] APK imzalanıyor..."
apksigner sign --ks $KEYSTORE --ks-pass pass:$PASS --out ../build/patched_final.apk ../build/patched_unsigned.apk

# 4. Cleanup & Install
echo "[+] Gereksiz dosyalar temizleniyor..."
rm ../build/patched_unsigned.apk
echo "[+] Uygulama telefona kuruluyor..."
adb install ../build/patched_final.apk

echo "[OK] İşlem Başarılı! Uygulamayı açabilirsin."