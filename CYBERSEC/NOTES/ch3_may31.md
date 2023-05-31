# CyberSec Chapter 3: User Authentification #

## Identification & Authentication Security Req.s ##
__Basic Security Requirements:__
1. Identify information system Users
2. Authenticate those Users using some process

__Derived Security Requirements:__
3. use Multifactor-Authentification for account access
4. Employ replay-resistant authentification methods to keep integrity
5. prevent reuse of identifiers for a defined period 
6. disable identifiers after a period of inactivity
7. Enforce minimum password complexity to enhance security
8. Prohibit password reuse after a certain number of generations 
9. Allow temporary password use when changing permanent passwords
10. store and transmit only cryptographically-protected passwords
11. Obscure feedback of authentification information

## Authenticate User Identities ##
__Four Means:__
1. Something an Individual Knows (user data)
2. Something an Individual Possesses (token)
3. Something the Invidiual Is (biometric)
4. Something an Individual Does (dynamic biometric)

## Risk Assessment for User Auth ##
__Assurance Level:__
- describes a degree of certainty that someone is who they say they are
- 4 Levels: 
    1. Level 1: Low/No Confidence
    2. Level 2: Some Confidence 
    3. Level 3: High Confidence 
    4. Level 4: Very High/Certain Confidence

__Potential Impact:__
- 3 Levels: 
    1. Low: 
        - averse effects on assets
    2. Moderate:
        - serious general adverse effects
    3. High:
        - severe/catastrophic adverse effects

## Password-Based Authentication ##
- Widely used line of defense
    - user provides name/login and password 
    - system compares password with hash-stored one 
- user ID
    - determines user is authorized to use the system
    - asserts user's privileges
    - used in discretionary access control 
- Vulnerabilities
    - __check discord__

__UNIX Password Implementation:__
- Original Scheme 
    - up to 8 printable characters in length 
    - 12bit salt used to modify DES into a one-way hash
    - zero value repeatedly encrypted 25 times 
    - output translated to 11 char. sequence
- Now regarded as Inadequate 
    - still often req'd for compatibility 

__Improved UNIX PW-Implementation:__
- Much stronger hash/salt scheme for UNIX 
- based on MD5 
    - salt up to 48bits 
    - password length is unlimited
    - produces 128bit hash 
    - uses an inner loop with 1000 iterations to achieve slowdown 
- OpenBSD uses Blowfish block cipher-based hash (Bcrypt):
    - Most secure version of UNIX hash/salt scheme
    - 128bit salt to create 192bit hash value 

## Password Cracking ##
__Dictionary Attacks:__
- develop a dictionary of words to use to guess passwords
__Rainbow Table Attacks:__
- pre-compute salt-hash tables to try them all separately
__Exploits:__
- short & obvious passwords are easier to guess
- __John The Ripper:__
    - first open-source password cracker (1996)
    - uses brute-force and dictionary techniques

### Modern Approaches ###
- Complex password policy 
    - forcing users to pick stronger passwords
- Cracking Methods:
    - processing capacity of computers is greatly increased
    - the use of sophisticated algorithms to generate potential passwords
    - studying examples of actual passwords in use

## Password File Access Control ##
- can block offline guessing by denying access
    - shadow password files 
    - make available only to privileged users
- Vulnerabilities 
    - weakness in the OS that allows file access
    - accident with permissions making it readable 
    - users w/ same password on other systems
    - access from backup media
    - sniffing passwords in network traffic 
