*>================================================================
*> COPYBOOK: KEY-STORE.cpy
*> PURPOSE:  Cryptographic Key Vault & Key Slot Directory
*> ================================================================
 01  KEY-VAULT-TABLE.
     05  KV-KEY-COUNT            PIC 9(04) COMP-5 VALUE 0.
     05  KV-KEYS OCCURS 16 TIMES INDEXED BY KV-IDX.
         10  KV-KEY-ALIAS        PIC X(16) VALUE SPACES.
         10  KV-KEY-ALGO         PIC X(08) VALUE "HMAC256 ".
         10  KV-KEY-RAW-BYTES    PIC X(32) VALUE ALL X"AA".
         10  KV-KEY-REVOKED      PIC X(01) VALUE 'N'.
