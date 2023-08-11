      *================================================================*
*> COPYBOOK: PBKDF2-CONFIG.cpy                                    *
*> PURPOSE:  RFC 2898 / PKCS #5 Key Derivation Parameters         *
*> ================================================================*
       01  PBKDF2-PARAMETERS.
           05  PBK-PASSWORD-LEN        PIC 9(04) COMP-5.
           05  PBK-PASSWORD            PIC X(128).
           05  PBK-SALT-LEN            PIC 9(04) COMP-5.
           05  PBK-SALT                PIC X(64).
           05  PBK-ITERATIONS          PIC 9(08) COMP-5 VALUE 1000.
           05  PBK-KEY-LEN             PIC 9(04) COMP-5 VALUE 32.
           05  PBK-OUTPUT-KEY          PIC X(32).
