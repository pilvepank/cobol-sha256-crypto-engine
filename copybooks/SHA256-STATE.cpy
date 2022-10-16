*>================================================================*
*> SHA256-STATE.cpy - FIPS 180-4 Working State & Buffers
*>================================================================*
 01  SHA256-STATE.
     05  STATE-H OCCURS 8 TIMES PIC 9(9) COMP-5.
     05  TOTAL-BIT-LEN       PIC 9(18) COMP-5.
     05  BLOCK-BUFFER        PIC X(64).
     05  BUFFER-LEN          PIC 9(4) COMP-5.
     05  HEX-DIGEST          PIC X(64).
