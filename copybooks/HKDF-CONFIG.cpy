*>================================================================
*> COPYBOOK: HKDF-CONFIG.cpy
*> PURPOSE:  RFC 5869 HMAC-based Extract-and-Expand Key Derivation
*> ================================================================
 01  HKDF-PARAMETERS.
     05  HKDF-IKM                PIC X(64).
     05  HKDF-IKM-LEN            PIC 9(04) COMP-5 VALUE 0.
     05  HKDF-SALT               PIC X(64).
     05  HKDF-SALT-LEN           PIC 9(04) COMP-5 VALUE 0.
     05  HKDF-INFO               PIC X(64).
     05  HKDF-INFO-LEN           PIC 9(04) COMP-5 VALUE 0.
     05  HKDF-OKM-LEN            PIC 9(04) COMP-5 VALUE 32.
     05  HKDF-PRK                PIC X(64).
     05  HKDF-OKM                PIC X(64).
     05  HKDF-STATUS             PIC X(02) VALUE '00'.
         88  HKDF-OK             VALUE '00'.
         88  HKDF-PARAM-ERROR    VALUE '99'.
