*>================================================================
*> PROGRAM:  sha256_hmac_test.cbl
*> PURPOSE:  Test Harness for HMAC-SHA256
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-HMAC-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "HMAC-STATE.cpy".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  HMAC-SHA256 RFC 2104 TEST SUITE                 "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "Jefe" TO HMAC-KEY
     MOVE 4 TO HMAC-KEY-LEN
     MOVE "what do ya want for nothing?" TO HMAC-DATA
     MOVE 28 TO HMAC-DATA-LEN
     CALL "SHA256-HMAC" USING HMAC-CONTEXT
     IF HMAC-DIGEST(1:16) = "b613679a0814d9ec"
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: RFC 4231 HMAC-SHA256 Vector [PASS]"
     ELSE
         DISPLAY "TEST 1: RFC 4231 HMAC-SHA256 Vector [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "HMAC Tests Run:    " WS-TESTS-RUN
     DISPLAY "HMAC Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL HMAC TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME HMAC TESTS FAILED <<"
     END-IF
     STOP RUN.
