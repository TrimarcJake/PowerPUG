## General flow:

1. Get all AD Admins.
2. Check if all AD Admins are in the PUG.
    - Yes: congratulate the user and exit.
    - No: continue on.
3. Check for required logging. **(Required logs TBD)**
    - No: Stop and provide steps for enabling required logs.
    - Yes: continue on.
4. Ingest required logs as they apply to AD Admins
5. Check for things that cannot go in the PUG:
    - Service Accounts in AD Admin groups
        - Users with SPNs
        - (g)MSAs
        - standard service account prefixes/suffixes
    - Computers in AD Admin groups
    - NTLM logons
    - Kerberos Logons with encryption weaker than AES 256
    - Logons from non-Windows RDP clients
6. Provide guidance on resolving PUG-breakers.
7. Provide code blocks for adding PUG-safe users into the PUG.

## Enhancements

[ ] Check arbitrary accounts for ability to join PUG.