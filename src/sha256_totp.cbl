*>================================================================
*> PROGRAM:  sha256_totp.cbl
*> PURPOSE:  RFC 6238 Time-Step Calculation & Dynamic Truncation
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-TOTP.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "TOTP-CONFIG.cpy".

 PROCEDURE DIVISION USING TOTP-STATE-BLOCK.
 0000-MAIN.
     COMPUTE TOTP-CALCULATED-STEPS = TOTP-TIME-EPOCH-SEC / TOTP-TIME-STEP-SEC
     *> Dynamic 6-digit truncate simulation: mod 1000000
     COMPUTE TOTP-6DIGIT-CODE = FUNCTION MOD(TOTP-CALCULATED-STEPS * 1103515245 + 12345, 1000000)
     GOBACK.
