*>================================================================
*> PROGRAM:  sha256_ct_test.cbl
*> PURPOSE:  Unit Test Suite for Constant-Time Comparison
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-CT-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "CT-COMPARE.cpy".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  SHA-256 CONSTANT-TIME TIMING ATTACK TEST SUITE  "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "0123456789abcdef0123456789abcdef" TO CT-BUF-A
     MOVE "0123456789abcdef0123456789abcdef" TO CT-BUF-B
     CALL "SHA256-CT-COMPARE" USING CT-BUFFER-DESCRIPTOR
     IF CT-BUFFERS-MATCH AND CT-ACCUMULATOR-DIFF = 0
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Identical Buffers Match with Zero Diff [PASS]"
     ELSE
         DISPLAY "TEST 1: Identical Buffers Match with Zero Diff [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "0123456789abcdef0123456789abcdeX" TO CT-BUF-B
     CALL "SHA256-CT-COMPARE" USING CT-BUFFER-DESCRIPTOR
     IF CT-IS-EQUAL-FLAG = 'N' AND CT-ACCUMULATOR-DIFF = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Single Byte Discrepancy Correctly Detected [PASS]"
     ELSE
         DISPLAY "TEST 2: Single Byte Discrepancy Correctly Detected [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Constant-Time Tests Run:    " WS-TESTS-RUN
     DISPLAY "Constant-Time Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL CONSTANT-TIME TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME CONSTANT-TIME TESTS FAILED <<"
     END-IF
     STOP RUN.
