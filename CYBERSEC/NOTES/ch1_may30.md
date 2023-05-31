# CYBERSEC Chapter 1: Introduction #

## Key Security Concepts ##
__Confidentiality:__
- Preserving restrictions so overall privacy is protected

__Integrity:__
- Guarding against malicious modification/misuse/destruction

__Avaibility:__
- Ensuring that access/use of info is timely and reliable

## Levels of Impact ##
__Low:__
- loss has a limited adverse affects on op.s/assets/people

__Moderate:__
- loss could be expected to have serious affects on op.s/assets/people

__High:__
- loss expected to have severe affects on op.s/assets/people

## CyberSec Challenges ##
1. More difficult than it appears
2. Requires consideration of malicious intents
3. Often involves counterintuitive procedures
4. Demands a focused physical/logical placement 
5. Security mechanisms are complex (not algorithmic)
6. Attackers only need to find a single weakness
7. Security is often an afterthought to existing systems
8. Security requires regular/constant monitoring
9. Security tends to have less-incentive to solve 
10. Security tools often clash with efficiency and user-friendliness

## CyberSec Terminology ##
__Adversary (Threat Agent):__
- Organization that intends/conducts detrimental activities

__Attack:__
- Any kind of Malicious Activity that yields detrimental effects 
    - (ex: Collect/Disrupt/Deny/Degrade/Destroy Assets)

__Countermeasure:__
- A device/technique that impairs/prevents detrimental activities 

__Risk:__
- A measure of the extent to which an entity is threatened by some event

__Security Policy:__
- Criteria for the provision of security services (defines/constraints)

__System Resource (Asset):__
- A critical system or group of systems involved in a project

__Threat:__
- Any circumstance that could yield detrimental effects

__Vulnerability:__
- Weakness in a system that is vulnerable to a threat of some kind 

## Computer System Assets ##
- Hardware, Software, Data, Networks/Comm. Facilites

## Vulnerabilities, Threats, Attacks ##
__Vulnerabilities:__
- Categories:
    - Corrupted (loss of integrity)
    - Leaky (loss of confidentiality)
    - Unavailable or Slow (loss off Availability)

__Threats:__
- Capable of Exploiting Vulnerabiltiies
- Represent potential security harm to an Asset

__Attacks:__
- Threats, but Carried Out
- Categories: 
    - __Passive__ 
        - attempt to learn or make use of system info
    - __Active__
        - attempt to alter system resources or their operations 
    - __Insider__ 
        - Initiated by an entity inside the security perimeter
    - __Outsider__
        - Initiated by an entity outside the security perimeter

## Countermeasures ##
- Means used to deal with security Attacks
    - Prevent
    - Detect 
    - Recover
- May itself introduce new Vulnerabilities
- Residual Vulnerabilities may remain
- Goal: minimize residual level of risk to the assets


## Passive and Active Attacks ##
__Passive Attack:__
- Attempt to learn/make use of system info. w/o affecting the system itself
    - (ex: eavesdropping, monitoring, transmitting, etc...)
- Types:
    - Release of Message Contents
    - Traffic Analysis

__Active Attack:__
- Attempt to alter system resources or their operations
- Involve some modification to data stream to falsify it
- Categories:
    - Replay 
    - Masquerade
    - Modification of Messages
    - Denial of Service

## Security Requirements ##
__For more info, check Discord__
- Requirements:
    - Access Control
    - Awareness and Training
    - Audit and Accountability
    - Certification, Accreditation, and Security Assessments
    - Configuration Management
    - Contingency Planning
    - Identification and Authentication
    - Incident Response 
    - Maintenance
    - Media Protection 
    - Physical and Environmental Protection
    - Planning 
    - Personnel Security
    - Risk Assessment
    - System and Services Acquisition 
    - System and Communications Protection
    - System and Information Integrity

## Attack Surfaces ##
- Consist of reachable and exploitable Vulnerabilites in a system 
    - (ex: UI forms, Inside-Firewall Services, etc...)
- Categories: 
    - __Network Attack Surface__
        - Vulnerbiilities over some network 
            - (ex: net-protocol vulnerabilities, denial of service attacks, etc...)
    - __Software Attack Surface__
        - Vulnerabilities in application utility or OS code
        - Particular focus is Web Servcer Software
    - __Human Attack Surface__
        - Vulnerabilities created by personell/trusted insiders

## Computer Security Strategy ##
__For more info, check Discord__
- Items:
    - Security Policy
    - Security Implementation
    - Assurance 
    - Evaluation