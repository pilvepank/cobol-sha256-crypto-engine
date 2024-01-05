*>================================================================
*> COPYBOOK: CT-COMPARE.cpy
*> PURPOSE:  Constant-Time Byte Array Comparison Descriptor
*> ================================================================
 01  CT-BUFFER-DESCRIPTOR.
     05  CT-BUF-A                PIC X(32).
     05  CT-BUF-B                PIC X(32).
     05  CT-ACCUMULATOR-DIFF     PIC 9(04) COMP-5 VALUE 0.
     05  CT-IS-EQUAL-FLAG        PIC X(01) VALUE 'N'.
         88  CT-BUFFERS-MATCH    VALUE 'Y'.
