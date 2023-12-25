*>================================================================
*> COPYBOOK: DRBG-STATE.cpy
*> PURPOSE:  NIST SP 800-90A Hash-DRBG Pseudorandom Engine State
*> ================================================================
 01  DRBG-INTERNAL-STATE.
     05  DRBG-SEED-VALUE         PIC 9(18) COMP-5 VALUE 123456789.
     05  DRBG-RESEED-COUNTER     PIC 9(09) COMP-5 VALUE 0.
     05  DRBG-SECURITY-STRENGTH  PIC 9(04) COMP-5 VALUE 256.
     05  DRBG-OUT-RANDOM-WORD    PIC 9(09) COMP-5 VALUE 0.
