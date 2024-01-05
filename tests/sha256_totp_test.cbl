*>================================================================
*> PROGRAM:  sha256_totp_test.cbl
*> PURPOSE:  Unit Test Suite for RFC 6238 TOTP Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-TOTP-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "TOTP-CONFIG.cpy".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  SHA-256 RFC 6238 TOTP CODE TEST SUITE           "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1600000000 TO TOTP-TIME-EPOCH-SEC
     MOVE 30 TO TOTP-TIME-STEP-SEC
     CALL "SHA256-TOTP" USING TOTP-STATE-BLOCK
     IF TOTP-CALCULATED-STEPS = 53333333 AND TOTP-6DIGIT-CODE > 0
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Valid Epoch Steps & 6-Digit Code [PASS]"
     ELSE
         DISPLAY "TEST 1: Valid Epoch Steps & 6-Digit Code [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 1600000015 TO TOTP-TIME-EPOCH-SEC
     CALL "SHA256-TOTP" USING TOTP-STATE-BLOCK
     IF TOTP-CALCULATED-STEPS = 53333333
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Same 30-Second Window Yields Identical Step [PASS]"
     ELSE
         DISPLAY "TEST 2: Same 30-Second Window Yields Identical Step [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "TOTP Tests Run:    " WS-TESTS-RUN
     DISPLAY "TOTP Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL TOTP TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME TOTP TESTS FAILED <<"
     END-IF
     STOP RUN.
