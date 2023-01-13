*>================================================================*
*> PROGRAM-ID.    SHA256SUB.
*> PURPOSE.       CALLABLE COBOL CRYPTO SUBPROGRAM (STRING & HMAC)
*>================================================================*
IDENTIFICATION DIVISION.
PROGRAM-ID. SHA256SUB.

DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-HEX-TEMP             PIC X(64).

LINKAGE SECTION.
01  LS-ACTION               PIC X. *> 'H'=Hash, 'M'=HMAC
01  LS-INPUT                PIC X(1024).
01  LS-INPUT-LEN            PIC 9(9) COMP-5.
01  LS-KEY                  PIC X(64).
01  LS-KEY-LEN              PIC 9(9) COMP-5.
01  LS-OUTPUT-HEX           PIC X(64).

PROCEDURE DIVISION USING LS-ACTION, LS-INPUT, LS-INPUT-LEN,
                         LS-KEY, LS-KEY-LEN, LS-OUTPUT-HEX.
    IF LS-ACTION = "H"
        CALL "cobol_sha256" USING LS-INPUT, LS-INPUT-LEN, LS-OUTPUT-HEX
    ELSE
        CALL "cobol_hmac_sha256" USING LS-KEY, LS-KEY-LEN,
                                       LS-INPUT, LS-INPUT-LEN,
                                       LS-OUTPUT-HEX
    END-IF.
    GOBACK.
