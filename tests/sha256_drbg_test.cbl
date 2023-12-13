*>================================================================
*> PROGRAM:  sha256_drbg_test.cbl
*> PURPOSE:  Unit Test Suite for NIST SP 800-90A Hash-DRBG
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-DRBG-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "DRBG-STATE.cpy".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  SHA-256 HASH-DRBG RANDOM GENERATOR TEST SUITE   "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 987654321 TO DRBG-SEED-VALUE
     MOVE 0 TO DRBG-RESEED-COUNTER
     CALL "SHA256-DRBG" USING DRBG-INTERNAL-STATE
     IF DRBG-RESEED-COUNTER = 1 AND DRBG-OUT-RANDOM-WORD > 0
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Step DRBG Internal Seed & Output Non-Zero [PASS]"
     ELSE
         DISPLAY "TEST 1: Step DRBG Internal Seed & Output Non-Zero [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     CALL "SHA256-DRBG" USING DRBG-INTERNAL-STATE
     IF DRBG-RESEED-COUNTER = 2
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Successive DRBG Stepping Advances Counter [PASS]"
     ELSE
         DISPLAY "TEST 2: Successive DRBG Stepping Advances Counter [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "DRBG Tests Run:    " WS-TESTS-RUN
     DISPLAY "DRBG Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL DRBG TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME DRBG TESTS FAILED <<"
     END-IF
     STOP RUN.
