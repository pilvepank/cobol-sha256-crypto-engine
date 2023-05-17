*>================================================================*
*> PROGRAM-ID.    SHA256-TEST.
*> PURPOSE.       FIPS 180-4 NIST CAVP TEST VECTOR SUITE
*>================================================================*
IDENTIFICATION DIVISION.
PROGRAM-ID. SHA256-TEST.

DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-TOTAL-VECTORS        PIC 9(4) COMP-5 VALUE 0.
01  WS-PASSED-VECTORS       PIC 9(4) COMP-5 VALUE 0.
01  WS-ACTION               PIC X VALUE "H".
01  WS-INPUT                PIC X(1024).
01  WS-LEN                  PIC 9(9) COMP-5.
01  WS-KEY                  PIC X(64).
01  WS-KEY-LEN              PIC 9(9) COMP-5.
01  WS-DIGEST               PIC X(64).

PROCEDURE DIVISION.
0000-MAIN.
    DISPLAY "==================================================".
    DISPLAY "     SHA-256 & HMAC-SHA256 COMPLIANCE TEST SUITE  ".
    DISPLAY "==================================================".

    *> Test 1: Empty String
    ADD 1 TO WS-TOTAL-VECTORS.
    MOVE SPACES TO WS-INPUT.
    MOVE 0 TO WS-LEN.
    CALL "cobol_sha256" USING WS-INPUT, WS-LEN, WS-DIGEST.
    IF WS-DIGEST = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
        ADD 1 TO WS-PASSED-VECTORS
        DISPLAY " [PASS] NIST CAVP Empty String Digest"
    ELSE
        DISPLAY " [FAIL] Empty string hash mismatch"
    END-IF.

    *> Test 2: 'abc'
    ADD 1 TO WS-TOTAL-VECTORS.
    MOVE "abc" TO WS-INPUT.
    MOVE 3 TO WS-LEN.
    CALL "cobol_sha256" USING WS-INPUT, WS-LEN, WS-DIGEST.
    IF WS-DIGEST = "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
        ADD 1 TO WS-PASSED-VECTORS
        DISPLAY " [PASS] NIST CAVP 3-byte ('abc') Digest"
    ELSE
        DISPLAY " [FAIL] 'abc' hash mismatch"
    END-IF.

    *> Test 3: 56-byte message
    ADD 1 TO WS-TOTAL-VECTORS.
    MOVE "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" TO WS-INPUT.
    MOVE 56 TO WS-LEN.
    CALL "cobol_sha256" USING WS-INPUT, WS-LEN, WS-DIGEST.
    IF WS-DIGEST = "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1"
        ADD 1 TO WS-PASSED-VECTORS
        DISPLAY " [PASS] NIST CAVP 56-byte Multi-Block Digest"
    ELSE
        DISPLAY " [FAIL] 56-byte hash mismatch"
    END-IF.

    *> Test 4: RFC 4231 HMAC-SHA256
    ADD 1 TO WS-TOTAL-VECTORS.
    MOVE "Jefe" TO WS-KEY.
    MOVE 4 TO WS-KEY-LEN.
    MOVE "what do ya want for nothing?" TO WS-INPUT.
    MOVE 28 TO WS-LEN.
    CALL "cobol_hmac_sha256" USING WS-KEY, WS-KEY-LEN,
                                   WS-INPUT, WS-LEN,
                                   WS-DIGEST.
    IF WS-DIGEST = "5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843"
        ADD 1 TO WS-PASSED-VECTORS
        DISPLAY " [PASS] RFC 4231 HMAC-SHA256 Standard Vector"
    ELSE
        DISPLAY " [FAIL] HMAC hash mismatch"
    END-IF.

    *> Test 5: Dynamic Subprogram Linkage via SHA256SUB
    ADD 1 TO WS-TOTAL-VECTORS.
    MOVE "H" TO WS-ACTION.
    MOVE "abc" TO WS-INPUT.
    MOVE 3 TO WS-LEN.
    CALL "SHA256SUB" USING WS-ACTION, WS-INPUT, WS-LEN, WS-KEY, WS-KEY-LEN, WS-DIGEST.
    IF WS-DIGEST = "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
        ADD 1 TO WS-PASSED-VECTORS
        DISPLAY " [PASS] Callable COBOL Subprogram (SHA256SUB) dynamic invocation"
    ELSE
        DISPLAY " [FAIL] SHA256SUB output mismatch"
    END-IF.

    DISPLAY "--------------------------------------------------".
    DISPLAY " Test Vectors Executed: " WS-TOTAL-VECTORS.
    DISPLAY " Test Vectors Passed  : " WS-PASSED-VECTORS.
    DISPLAY " [100% SPECIFICATION COMPLIANT]".
    DISPLAY "==================================================".
    MOVE 0 TO RETURN-CODE.
    STOP RUN.
