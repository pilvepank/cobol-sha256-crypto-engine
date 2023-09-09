      *================================================================*
*> COPYBOOK: MERKLE-TREE.cpy                                      *
*> PURPOSE:  Cryptographic Merkle Tree Node & Audit Proof Layout  *
*> ================================================================*
       01  MERKLE-NODE-RECORD.
           05  MN-NODE-ID              PIC 9(08) COMP-5.
           05  MN-LEVEL                PIC 9(02) COMP-5.
           05  MN-HASH                 PIC X(64).
           05  MN-LEFT-CHILD           PIC 9(08) COMP-5.
           05  MN-RIGHT-CHILD          PIC 9(08) COMP-5.
           05  MN-IS-LEAF              PIC X(01).
               88  MN-LEAF             VALUE 'Y'.
               88  MN-BRANCH           VALUE 'N'.
