*>================================================================
*> PROGRAM:  sha256_keystore_test.cbl
*> PURPOSE:  Unit Test Suite for Key Vault Management
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-KEYSTORE-TEST.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 COPY "KEY-STORE.cpy".
 01  WS-OP                  PIC X(01) VALUE 'A'.
 01  WS-ALIAS               PIC X(16) VALUE "JWT-HMAC-PROD   ".
 01  WS-STAT                PIC X(02) VALUE '  '.
 01  WS-TESTS-RUN           PIC 9(04) VALUE 0.
 01  WS-TESTS-PASSED        PIC 9(04) VALUE 0.

 PROCEDURE DIVISION.
 0000-MAIN.
     DISPLAY "=================================================="
     DISPLAY "  SHA-256 KEY VAULT MANAGEMENT TEST SUITE         "
     DISPLAY "=================================================="
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 0 TO KV-KEY-COUNT
     MOVE 'A' TO WS-OP
     MOVE "JWT-HMAC-PROD   " TO WS-ALIAS
     CALL "SHA256-KEYSTORE" USING KEY-VAULT-TABLE, WS-OP, WS-ALIAS, WS-STAT
     
     MOVE 'L' TO WS-OP
     CALL "SHA256-KEYSTORE" USING KEY-VAULT-TABLE, WS-OP, WS-ALIAS, WS-STAT
     IF WS-STAT = '00' AND KV-KEY-COUNT = 1
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 1: Key Enrolled & Looked Up Successfully [PASS]"
     ELSE
         DISPLAY "TEST 1: Key Enrolled & Looked Up Successfully [FAIL]"
     END-IF
     
     ADD 1 TO WS-TESTS-RUN
     MOVE 'R' TO WS-OP
     CALL "SHA256-KEYSTORE" USING KEY-VAULT-TABLE, WS-OP, WS-ALIAS, WS-STAT
     
     MOVE 'L' TO WS-OP
     CALL "SHA256-KEYSTORE" USING KEY-VAULT-TABLE, WS-OP, WS-ALIAS, WS-STAT
     IF WS-STAT = 'RV'
         ADD 1 TO WS-TESTS-PASSED
         DISPLAY "TEST 2: Revoked Key Access Denied [PASS]"
     ELSE
         DISPLAY "TEST 2: Revoked Key Access Denied [FAIL]"
     END-IF

     DISPLAY "--------------------------------------------------"
     DISPLAY "Keystore Tests Run:    " WS-TESTS-RUN
     DISPLAY "Keystore Tests Passed: " WS-TESTS-PASSED
     IF WS-TESTS-RUN = WS-TESTS-PASSED
         DISPLAY ">> ALL KEYSTORE TESTS PASSED [100% OK] <<"
     ELSE
         DISPLAY ">> SOME KEYSTORE TESTS FAILED <<"
     END-IF
     STOP RUN.
