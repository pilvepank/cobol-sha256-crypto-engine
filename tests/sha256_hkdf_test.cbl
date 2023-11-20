*>================================================================
*> PROGRAM:  sha256_hkdf_test.cbl
*> PURPOSE:  Test Harness for RFC 5869 HKDF Engine
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-HKDF-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "HKDF-CONFIG.cpy".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  HKDF-SHA256 RFC 5869 TEST SUITE                 "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "input-keying-material-01" TO HKDF-IKM
     MOVE 24 TO HKDF-IKM-LEN
     MOVE "salt-value-1234" TO HKDF-SALT
     MOVE 15 TO HKDF-SALT-LEN
     MOVE "context-info" TO HKDF-INFO
     MOVE 12 TO HKDF-INFO-LEN
     MOVE 32 TO HKDF-OKM-LEN
     CALL "SHA256-HKDF" USING HKDF-PARAMETERS
     IF HKDF-OK AND HKDF-OKM(1:16) = "3cb25f25faacd57a"
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: RFC 5869 HKDF Key Expansion [PASS]"
     ELSE
         DISPLAY "TEST 1: RFC 5869 HKDF Key Expansion [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 0 TO HKDF-IKM-LEN
     CALL "SHA256-HKDF" USING HKDF-PARAMETERS
     IF HKDF-PARAM-ERROR
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Zero Length IKM Validation Reject [PASS]"
     ELSE
         DISPLAY "TEST 2: Zero Length IKM Validation Reject [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "HKDF Tests Run:    " WS-TESTS-RUN
     DISPLAY "HKDF Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL HKDF TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME HKDF TESTS FAILED <<"
     END-IF
     STOP RUN.
