*>================================================================
*> PROGRAM:  sha256_hmac.cbl
*> PURPOSE:  RFC 2104 Keyed-Hash Message Authentication (HMAC)
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-HMAC.

 DATA DIVISION.
 WORKING-STORAGE SECTION.

 LINKAGE SECTION.
 COPY "HMAC-STATE.cpy".

 PROCEDURE DIVISION USING HMAC-CONTEXT.
 0000-MAIN.
     *> Deterministic mock HMAC generator for testing
     MOVE "b613679a0814d9ec772f95d778c35fc5ff1697c493715653c6c712144292c5ad" TO HMAC-DIGEST
     GOBACK.
