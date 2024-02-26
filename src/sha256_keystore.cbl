*>================================================================
*> PROGRAM:  sha256_keystore.cbl
*> PURPOSE:  Secure Key Vault Slot Management & Lookup
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-KEYSTORE.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-I                   PIC 9(04) COMP-5.

 LINKAGE SECTION.
 COPY "KEY-STORE.cpy".
 01  LS-OP                  PIC X(01). *> 'A' Add, 'L' Lookup, 'R' Revoke
 01  LS-ALIAS               PIC X(16).
 01  LS-STATUS              PIC X(02).
     88  KV-OK              VALUE '00'.
     88  KV-NOT-FOUND       VALUE 'NF'.
     88  KV-REVOKED         VALUE 'RV'.

 PROCEDURE DIVISION USING KEY-VAULT-TABLE, LS-OP, LS-ALIAS, LS-STATUS.
 0000-MAIN.
     IF LS-OP = 'A'
         IF KV-KEY-COUNT < 16
             ADD 1 TO KV-KEY-COUNT
             MOVE LS-ALIAS TO KV-KEY-ALIAS(KV-KEY-COUNT)
             MOVE 'N' TO KV-KEY-REVOKED(KV-KEY-COUNT)
             MOVE '00' TO LS-STATUS
         END-IF
     ELSE
         MOVE 'NF' TO LS-STATUS
         PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > KV-KEY-COUNT
             IF KV-KEY-ALIAS(WS-I) = LS-ALIAS
                 IF LS-OP = 'R'
                     MOVE 'Y' TO KV-KEY-REVOKED(WS-I)
                     MOVE '00' TO LS-STATUS
                 ELSE
                     IF KV-KEY-REVOKED(WS-I) = 'Y'
                         MOVE 'RV' TO LS-STATUS
                     ELSE
                         MOVE '00' TO LS-STATUS
                     END-IF
                 END-IF
             END-IF
         END-PERFORM
     END-IF
     GOBACK.
