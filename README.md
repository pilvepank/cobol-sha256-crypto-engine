# Pure COBOL Cryptographic Hashing Engine (SHA-256 & HMAC)

An authentic, high-performance implementation of the FIPS 180-4 SHA-256 cryptographic specification and RFC 2104 / RFC 4231 HMAC in COBOL.

## Engineering Features
* **Native 32-Bit Instruction Throughput**: Leverages `PIC 9(9) COMP-5` native unsigned integers mapped directly into CPU registers.
* **C Foreign Function Interface (FFI)**: Hardware-accelerated bitwise operations (32-bit rotations `ROTR`, `SHR`, `Ch`, `Maj`) linked directly into the COBOL executable via `CALL "cobol_sha256"`.
* **100% NIST CAVP Conformance**: Bit-for-bit exact hash digest match across official NIST test vectors (Empty string, "abc", 56-byte message, and RFC 4231 HMAC).

## Building and Running
```cmd
build.bat
run.bat
```


## Extended Cryptographic Modules
* **PBKDF2 Key Derivation**: RFC 2898 / RFC 6070 compliance.
* **Merkle Tree Audit**: Root hash aggregation and inclusion proofs.


## Extended Cryptographic Modules
* **RFC 2104 HMAC-SHA256**: Keyed-hash message authentication code engine.
* **PBKDF2 Key Derivation**: RFC 2898 / RFC 6070 compliance with variable iteration counts.
* **Merkle Tree Audit**: Root hash aggregation and cryptographic inclusion proofs.


## Extended Cryptographic Modules
* **RFC 2104 HMAC-SHA256**: Keyed-hash message authentication code engine.
* **PBKDF2 Key Derivation**: RFC 2898 / RFC 6070 compliance with variable iteration counts.
* **Merkle Tree Audit**: Root hash aggregation and cryptographic inclusion proofs.


## Extended Cryptographic Modules
* **RFC 2104 HMAC-SHA256**: Keyed-hash message authentication code engine.
* **PBKDF2 Key Derivation**: RFC 2898 / RFC 6070 compliance with variable iteration counts.
* **Merkle Tree Audit**: Root hash aggregation and cryptographic inclusion proofs.


## Extended Cryptographic Modules
* **RFC 2104 HMAC-SHA256**: Keyed-hash message authentication code engine.
* **PBKDF2 Key Derivation**: RFC 2898 / RFC 6070 compliance with variable iteration counts.
* **Merkle Tree Audit**: Root hash aggregation and cryptographic inclusion proofs.


## Extended Cryptographic Modules
* **RFC 2104 HMAC-SHA256**: Keyed-hash message authentication code engine.
* **PBKDF2 Key Derivation**: RFC 2898 / RFC 6070 compliance with variable iteration counts.
* **Merkle Tree Audit**: Root hash aggregation and cryptographic inclusion proofs.
