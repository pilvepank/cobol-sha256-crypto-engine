*>================================================================
*> COPYBOOK: HMAC-STATE.cpy
*> PURPOSE:  RFC 2104 HMAC-SHA256 State Layout
*> ================================================================
 01  HMAC-CONTEXT.
     05  HMAC-KEY                PIC X(64).
     05  HMAC-KEY-LEN            PIC 9(04) COMP-5.
     05  HMAC-DATA               PIC X(128).
     05  HMAC-DATA-LEN           PIC 9(04) COMP-5.
     05  HMAC-DIGEST             PIC X(64).
