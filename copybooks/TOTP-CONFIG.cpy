*>================================================================
*> COPYBOOK: TOTP-CONFIG.cpy
*> PURPOSE:  RFC 6238 Time-based One-Time Password Descriptor
*> ================================================================
 01  TOTP-STATE-BLOCK.
     05  TOTP-TIME-EPOCH-SEC     PIC 9(18) COMP-5 VALUE 1600000000.
     05  TOTP-TIME-STEP-SEC      PIC 9(04) COMP-5 VALUE 30.
     05  TOTP-CALCULATED-STEPS   PIC 9(18) COMP-5 VALUE 0.
     05  TOTP-6DIGIT-CODE        PIC 9(06) VALUE 0.
