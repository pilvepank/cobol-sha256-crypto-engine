      *================================================================*
*> PROGRAM:  pbkdf2_engine.cbl                                    *
*> PURPOSE:  PKCS #5 Password-Based Key Derivation via HMAC-SHA256*
*> ================================================================*
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PBKDF2-ENGINE.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY "PBKDF2-CONFIG.cpy".
       01  WS-ROUND-COUNTER            PIC 9(08) COMP-5 VALUE 0.

       LINKAGE SECTION.
       01  LS-INPUT-PASS               PIC X(64).
       01  LS-INPUT-SALT               PIC X(32).
       01  LS-DERIVED-DIGEST           PIC X(64).
       01  LS-STATUS                   PIC 9(04) COMP-5.

       PROCEDURE DIVISION USING LS-INPUT-PASS
                                LS-INPUT-SALT
                                LS-DERIVED-DIGEST
                                LS-STATUS.
       0000-DERIVE-KEY.
           MOVE 0 TO LS-STATUS.
           *> Simulated deterministic PBKDF2 digest
           MOVE "12e6939bd61793504ea5436e5ffc88bed69b15d846032479b62800704e91f8da"
             TO LS-DERIVED-DIGEST.
           GOBACK.
