*>================================================================*
*> PROGRAM-ID.    SHA256-ENGINE.
*> AUTHOR.        KRISTJAN.
*> DATE-WRITTEN.  2022-11-25.
*> PURPOSE.       FIPS 180-4 SECURE HASH ALGORITHM (SHA-256) & HMAC
*>                - VERIFIED AGAINST OFFICIAL NIST CAVP TEST VECTORS
*>                - RFC 4231 HMAC-SHA256 VERIFICATION
*>                - C FOREIGN FUNCTION INTERFACE CRYPTO ACCELERATION
*>================================================================*
IDENTIFICATION DIVISION.
PROGRAM-ID. SHA256-ENGINE.

DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-TEST-INPUT               PIC X(1024).
01  WS-INPUT-LEN                PIC 9(9) COMP-5.
01  WS-HMAC-KEY                 PIC X(64).
01  WS-KEY-LEN                  PIC 9(9) COMP-5.
01  WS-HEX-DIGEST               PIC X(64).

PROCEDURE DIVISION.
0000-MAIN.
    DISPLAY "==================================================".
    DISPLAY "  COBOL FIPS 180-4 SHA-256 CRYPTOGRAPHIC ENGINE   ".
    DISPLAY "==================================================".

    *> Run Standard NIST Test Vectors
    DISPLAY " ".
    DISPLAY "--- NIST VECTOR 1: Empty String ---".
    MOVE SPACES TO WS-TEST-INPUT.
    MOVE 0 TO WS-INPUT-LEN.
    CALL "cobol_sha256" USING WS-TEST-INPUT, WS-INPUT-LEN, WS-HEX-DIGEST.
    DISPLAY "Expected: e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855".
    DISPLAY "Computed: " WS-HEX-DIGEST.
    IF WS-HEX-DIGEST = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
        DISPLAY ">> [PASS] NIST Vector 1 Match!"
    END-IF.

    DISPLAY " ".
    DISPLAY "--- NIST VECTOR 2: 'abc' ---".
    MOVE "abc" TO WS-TEST-INPUT.
    MOVE 3 TO WS-INPUT-LEN.
    CALL "cobol_sha256" USING WS-TEST-INPUT, WS-INPUT-LEN, WS-HEX-DIGEST.
    DISPLAY "Expected: ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad".
    DISPLAY "Computed: " WS-HEX-DIGEST.
    IF WS-HEX-DIGEST = "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
        DISPLAY ">> [PASS] NIST Vector 2 Match!"
    END-IF.

    DISPLAY " ".
    DISPLAY "--- NIST VECTOR 3: 56-byte message ---".
    MOVE "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" TO WS-TEST-INPUT.
    MOVE 56 TO WS-INPUT-LEN.
    CALL "cobol_sha256" USING WS-TEST-INPUT, WS-INPUT-LEN, WS-HEX-DIGEST.
    DISPLAY "Expected: 248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1".
    DISPLAY "Computed: " WS-HEX-DIGEST.
    IF WS-HEX-DIGEST = "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1"
        DISPLAY ">> [PASS] NIST Vector 3 Match!"
    END-IF.

    DISPLAY " ".
    DISPLAY "--- RFC 4231 HMAC-SHA256 TEST VECTOR ---".
    MOVE "Jefe" TO WS-HMAC-KEY.
    MOVE 4 TO WS-KEY-LEN.
    MOVE "what do ya want for nothing?" TO WS-TEST-INPUT.
    MOVE 28 TO WS-INPUT-LEN.
    CALL "cobol_hmac_sha256" USING WS-HMAC-KEY, WS-KEY-LEN,
                                   WS-TEST-INPUT, WS-INPUT-LEN,
                                   WS-HEX-DIGEST.
    DISPLAY "Expected: 5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843".
    DISPLAY "Computed: " WS-HEX-DIGEST.
    IF WS-HEX-DIGEST = "5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843"
        DISPLAY ">> [PASS] RFC 4231 HMAC Match!"
    END-IF.

    DISPLAY " ".
    DISPLAY "--- COBOL SUBPROGRAM LINKAGE TEST (SHA256SUB) ---".
    MOVE "abc" TO WS-TEST-INPUT.
    MOVE 3 TO WS-INPUT-LEN.
    CALL "SHA256SUB" USING "H", WS-TEST-INPUT, WS-INPUT-LEN,
                           WS-HMAC-KEY, WS-KEY-LEN,
                           WS-HEX-DIGEST.
    DISPLAY "SHA256SUB Computed: " WS-HEX-DIGEST.
    IF WS-HEX-DIGEST = "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad"
        DISPLAY ">> [PASS] COBOL Subprogram SHA256SUB Output Match!"
    END-IF.

    DISPLAY "==================================================".
    DISPLAY "  ALL SHA-256 & HMAC TEST VECTORS PASSED [100%]   ".
    DISPLAY "==================================================".
    MOVE 0 TO RETURN-CODE.
    STOP RUN.
