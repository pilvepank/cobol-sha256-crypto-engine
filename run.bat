@echo off
call build.bat
sha256_engine.exe
sha256_test.exe
pbkdf2_test.exe
sha256_hmac_test.exe
sha256_hkdf_test.exe
sha256_stream_test.exe
sha256_drbg_test.exe
sha256_ct_test.exe
sha256_totp_test.exe
sha256_keystore_test.exe
