*>================================================================
*> COPYBOOK: STREAM-IO.cpy
*> PURPOSE:  Chunked Stream Hashing & Buffer Control Layout
*> ================================================================
 01  STREAM-CONTROL-BLOCK.
     05  SCB-TOTAL-BYTES-READ    PIC 9(12) COMP-5 VALUE 0.
     05  SCB-BLOCKS-PROCESSED    PIC 9(08) COMP-5 VALUE 0.
     05  SCB-BUFFER              PIC X(4096).
     05  SCB-BUFFER-LEN          PIC 9(04) COMP-5 VALUE 0.
     05  SCB-EOF-FLAG            PIC X(01) VALUE 'N'.
         88  SCB-IS-EOF          VALUE 'Y'.
     05  SCB-FINAL-DIGEST        PIC X(64).
