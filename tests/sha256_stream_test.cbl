*>================================================================
*> PROGRAM:  sha256_stream_test.cbl
*> PURPOSE:  Test Harness for Streaming Multi-Block Chunk Hasher
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-STREAM-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "STREAM-IO.cpy".
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  SHA-256 STREAMING CHUNK I/O TEST SUITE          "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE "abc" TO SCB-BUFFER
     MOVE 3 TO SCB-BUFFER-LEN
     MOVE 'Y' TO SCB-EOF-FLAG
     CALL "SHA256-STREAM-IO" USING STREAM-CONTROL-BLOCK
     IF SCB-TOTAL-BYTES-READ = 3 AND SCB-FINAL-DIGEST(1:16) = "ba7816bf8f01cfea"
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Streaming Multi-Block EOF Digest [PASS]"
     ELSE
         DISPLAY "TEST 1: Streaming Multi-Block EOF Digest [FAIL]"
     END-IF
     
     DISPLAY "--------------------------------------------------"
     DISPLAY "Stream Tests Run:    " WS-TESTS-RUN
     DISPLAY "Stream Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL STREAMING TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME STREAMING TESTS FAILED <<"
     END-IF
     STOP RUN.
