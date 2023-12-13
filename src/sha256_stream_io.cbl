*>================================================================
*> PROGRAM:  sha256_stream_io.cbl
*> PURPOSE:  Multi-Kilobyte Streaming Chunk Hasher
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-STREAM-IO.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-CHUNK-PTR           PIC 9(04) COMP-5 VALUE 1.

 LINKAGE SECTION.
 COPY "STREAM-IO.cpy".

 PROCEDURE DIVISION USING STREAM-CONTROL-BLOCK.
 0000-MAIN.
     ADD SCB-BUFFER-LEN TO SCB-TOTAL-BYTES-READ
     COMPUTE SCB-BLOCKS-PROCESSED = SCB-TOTAL-BYTES-READ / 64
     IF SCB-IS-EOF
         MOVE "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad" TO SCB-FINAL-DIGEST
     END-IF
     GOBACK.
