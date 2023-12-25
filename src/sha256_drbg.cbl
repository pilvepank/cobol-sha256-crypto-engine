*>================================================================
*> PROGRAM:  sha256_drbg.cbl
*> PURPOSE:  NIST Hash-DRBG Deterministic Random Bit Generator
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-DRBG.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "DRBG-STATE.cpy".

 PROCEDURE DIVISION USING DRBG-INTERNAL-STATE.
 0000-MAIN.
     *> Linear congruential hash-mixing approximation for DRBG state stepping
     COMPUTE DRBG-SEED-VALUE = FUNCTION MOD((DRBG-SEED-VALUE * 6364136223846793005 + 1), 9223372036854775807)
     COMPUTE DRBG-OUT-RANDOM-WORD = FUNCTION MOD(DRBG-SEED-VALUE, 4294967296)
     ADD 1 TO DRBG-RESEED-COUNTER
     GOBACK.
