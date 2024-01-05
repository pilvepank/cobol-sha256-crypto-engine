*>================================================================
*> PROGRAM:  sha256_constant_time.cbl
*> PURPOSE:  Timing-Attack Resistant Constant-Time Buffer Comparison
*> ================================================================
 IDENTIFICATION DIVISION.
 PROGRAM-ID. SHA256-CT-COMPARE.

 DATA DIVISION.
 WORKING-STORAGE SECTION.
 01  WS-I                   PIC 9(04) COMP-5.

 LINKAGE SECTION.
 COPY "CT-COMPARE.cpy".

 PROCEDURE DIVISION USING CT-BUFFER-DESCRIPTOR.
 0000-MAIN.
     MOVE 0 TO CT-ACCUMULATOR-DIFF
     PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 32
         IF CT-BUF-A(WS-I:1) NOT = CT-BUF-B(WS-I:1)
             ADD 1 TO CT-ACCUMULATOR-DIFF
         END-IF
     END-PERFORM
     IF CT-ACCUMULATOR-DIFF = 0
         MOVE 'Y' TO CT-IS-EQUAL-FLAG
     ELSE
         MOVE 'N' TO CT-IS-EQUAL-FLAG
     END-IF
     GOBACK.
