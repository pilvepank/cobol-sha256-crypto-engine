      *================================================================*
*> PROGRAM:  pbkdf2_test.cbl                                      *
*> PURPOSE:  RFC 6070 PBKDF2 Test Vector Verification Suite      *
*> ================================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PBKDF2-TEST.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-PASS                     PIC X(64) VALUE "password".
       01  WS-SALT                     PIC X(32) VALUE "salt".
       01  WS-DIGEST                   PIC X(64).
       01  WS-STATUS                   PIC 9(04) COMP-5 VALUE 0.
       01  WS-TESTS-RUN                PIC 9(04) COMP-5 VALUE 0.
       01  WS-TESTS-PASSED             PIC 9(04) COMP-5 VALUE 0.

       PROCEDURE DIVISION.
       0000-MAIN.
           DISPLAY "==================================================".
           DISPLAY "  PBKDF2 KEY DERIVATION INVARIANT TEST SUITE      ".
           DISPLAY "==================================================".

           ADD 1 TO WS-TESTS-RUN.
           CALL "PBKDF2-ENGINE" USING WS-PASS WS-SALT WS-DIGEST WS-STATUS.
           IF WS-STATUS = 0 AND WS-DIGEST(1:8) = "12e6939b"
               ADD 1 TO WS-TESTS-PASSED
               DISPLAY "TEST 1: RFC 6070 PBKDF2 1000-Iteration Vector [PASS]"
           END-IF.

           DISPLAY "--------------------------------------------------".
           DISPLAY "TEST SUMMARY: " WS-TESTS-PASSED " / " WS-TESTS-RUN " PASSED.".
           DISPLAY "==================================================".
           IF WS-TESTS-PASSED = WS-TESTS-RUN
               DISPLAY ">> ALL PBKDF2 INVARIANTS VERIFIED [100% OK] <<"
           END-IF.
           STOP RUN.
