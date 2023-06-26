# OpSys Chapter: 7 Deadlocks 

## Deadlock
- **Definition**
    - Each Process in a set is Waiting for an event that only Another Process in the set can cause
- **Example:**
    - System w/ one Printer and one DVD drive
    - Process P_i is holding the DVD drive
    - Process P_j is holding the Printer 
    - If P_i requests the printer, and P_j requests the DVD drive? DEADLOCK!
        - (everything in system is waiting, nothing in system is signaling)

### Deadlock Causes

**Deadlock Conditions (ALL MUST BE MET):**
1. **Mutual Exclusion:**
    - Resources involved are Non-Sharable (1 process per resource)
2. **Hold and Wait:**
    - Process must be Holding and Waiting for Additional Resources (other resources are being held by processes)
3. **No Preemption:**
    - Resources are NonPreemptive (process will continue until task is complete)
4. **Circular Wait:**
    - Each Process in the Set exist such that they're all Holding and Waiting for Eachother 

-------------
## Resource-Allocation Graph
- used to precisely Describe Deadlocks
- **Graph:**
    - A set of `Vertices ( V )` and a set of `Edges ( E )`
    - `V is Partitioned` into two types of vertices:
        - `P = {P_1,... P_n}` are all the Processes in the system
        - `R = {R_1,... R_m}` are all the Resource Types in the system
    - `Request Edge`: Directed Edge P_i -> R_j
    - `Assignment Edge`: Directed Edge R_j -> P_i 
- **Cycles:**
    - If a graph contains No Cycles, then No Deadlock is Possible
    - If a graph contains A Cycle:
        - If only One Instance per resource type, then Deadlock!
        - If Several Instances per resource type, then Possibility of Deadlock


-------------
## Handling Deadlocks 
- Ensure that the system will Never enter a Deadlocked State
- OR: 
    - Allow the system to enter a deadlocked, Detect the deadlock, and Recover
    - Pretend that deadlocks Cannot Happen (common Windows and Unix)

### Deadlock Prevention
- making sure that At Least One of the 4 Deadlock Conditions are filled
- **Problems:**
    1. Some Resources (i.e: Mutexes) are inherently Non-Sharable
    2. Allocating before Hold and Wait can cause low resource util. and starvation
    3. Making Everything Preempt only works if Processes can be Easily Saved and Restored
    4. Circulation can be solved if we impose a Total Ordering of All Resource Types 
        - (request resources in increasing enumerated order)

### Deadlock Avoidance
- require process provide information about resources it will need In The Future
- use this info to Delegate Resources in a way that will Avoid Deadlocks 

### Deadlock Detection and Recovery
- Allowing Deadlocks, but having means of Recovering from them
