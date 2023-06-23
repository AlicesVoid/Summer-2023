# OPSYS Chapter 5: Process Synchronization #

## Process Synchronization 

### Process Sync Intro:
**Cooperating** process can Share Data 

**Concurrent** access to data may result in Data Inconsistency

**Process Sync:**
- ensuring an Orderly Execution of cooperating processes that Share Data, in order to maintain Data Consistency
    - necessary to prevent Race Conditions

### Race Conditions:
Multiple Processes/Threads access and manipulate the Same Data Concurrently, the outcome depends on Particular Order
- You need to make sure that there's a Set Order, even at a Concurrent Level

--------------------------------------
## Producer Consumer Problem: Race Condition

### Bound-Buffer Recap:

**Bound-Buffer Implementation (a Wrap Around Buffer):**
- `#define BUFFER_SIZE 10 typedef struct {...}item;`
- `item buffer[BUFFER_SIZE]; int in, out, counter = 0;`
- NOTE: 
    - `counter` keeps track of the # of Available Slots 
    - `in` -> First Empty Position, `out` -> First Full Position 
    - Buffer is Empty if `in == out`, Full if `((in+1) % BUFFER_SIZE_) == out`

### Producer Consumer Problem:
**Producer Code:**
1. wait for Buffer Space `(register1 = counter)`
2. produce an Item `(register1 += 1)`
3. save the Produced Item
4. compute the Next Free Index `(counter = register1)`

**Consumer Code:**
1. wait for Buffer Items `(register2 = counter)`
2. consume an Item `(register2 -= 1)`
3. compute the Next Item Index `(counter = register2)`
4. return the Item

**Problem:**
- Concurrently executing Producer and Consumer Codes may lead to Several Different Sequential Executions
- Final Value of the Counter depends on the Order of Execution
    (i.e: letting a random register determine final counter val. can drastically change the outcome)

--------------------------------------
## Critical Region Problem
### Critical Section:
A segment of Process Code where the **Process Modifies Shared Resources**
- (i.e: updating a table, writing to a file, etc...)

**Da Golden Rule:**
- No Two Process may execute the Critical Section At The Same Time 
    - (this seems very obvious-)

### Critical Section Problem:
How can we ensure that only One Process is executing it's critical section at a time?

**Solution Requirements:**
- **Mutual Exclusion:**
    - only One Process may enter a Critical Section at a time
- **Progress:**
    - No Process executing Outside of it's Critical Section may Block Another Process from entering theirs
- **Bounded Waiting:**
    - Process Cannot Be Perpetually Barred by Other Processes from entering it's Critical Section
- Existing Solutions:
    - **Peterson's Solution:** software-based solution
    - **Synchronization Hardware:** hardware-based solution
    - **Semaphores:** specialized integer variables

--------------------------------------
## Software Solutions: Semaphores, Peterson's Solution

### Semaphores
- Are **Easier** to use than Hardware-Based Synchronization
- An `int S`, accessible only through `wait()` and `signal()`
    - `wait(S) { while(S <= 0); S--; } `
    - `signal(S) {S++;} `
- All modifications to `S` are **Atomic**

**Types of Semaphores:**
- **Binary:**
    - Value Range is from 0 to 1
    - Also known as `mutex` (mutual exclusion) locks
    - mutex is initialized to 1 
    - follows the order of `wait(mutex);` //Critical Section Goes Here `signal(mutex);`
    - Problems:
        - requires **busy waiting:** (constantly polling S in a while loop)
        - works best if the Critical Section is **short** (otherwise inefficient)
- **Counting:**
    - Value Range is Unrestricted
    - Useful for coordinating access to a resource w/ Finite Number of Instances
    - Semaphore is initialized to the Maximum Number of Instances
    - `wait()`
        - decrements S
        - if S is positive, process can continue executing
            - else, process waits in a loop until S becomes positive
    - `signal()`
        - increments S
    - **Code Implementation:**
        - Each Semaphore is a Wait Queue of Processes (linked list)
            - `typedef struct {int value; struct process *list; }semaphore;`
        - wait()
            - `wait(semaphore *S) {S->value--; if(S->value < 0)`
                - `{add this process to S->list; block;} }`
        - signal()
            - `signal(semaphore *S) {S->value++; if(S->value <= 0)`
                - `{remove a process from S->list; wakeup(P);} }`
        - wakeup()
            - (i.e: start executing the Next Process)

### Peterson's Solution
- Assumes Two Processes (P.i and P.j)
- Assumes that the `LOAD` and `STORE` operations are Atomic (i.e: they cannot be interrupted)
- Two processes **Share Variables:**
    - `int turn;` //indicates whose turn it is to enter Critical Section
    - `bool flag[2];` //indicates if a process is Ready to enter it's Critical Section
        - `flag[i] = true` //implies that P.i is ready to enter it's Critical Section
- Parts:
    - **Observation:**
        - P.i sets `flag[i] = true`, indicating it's ready to enter Critical Section
        - P.i sets `turn = j`, indicating that P.j may enter it's Critical Section (if it wants to)
    - **Result:**
        - If both processes try to enter their Critical Sections at the same time:
            - Turn will be set to BOTH i and j at **Roughly The Same Time**
        - The **Final Value** will be determined by the process that gets to **Update Turn Last**
            - thus, preventing both processes from entering their Critical Section simultaneously


--------------------------------------
## Hardware Solutions: TestAndSet(), Swap()
**Solution for Uniprocessor Systems:**
- **Disable Interrupts** while modifying a Shared Variable:
    - if no other instructions are being executed, then nothing can interfere with the var.mod. operation
        - Approach taken by NonPreemptive Kernels
        - Difficult on Multiprocessor Systems

**Special Atomic Hardware Instructions:**
- must be Atomic (i.e: once started, always completes)
- **TestAndSet():**
    - Atomically Test, and then Set the Value of a Variable
- **Swap():**
    - Atomically Swap the contents of Two Variables
- **Core Method:**
    - either TestAndSet() or Swap() can provide syncrhonization:
        - Both processes share a variable `lock = False`
        - Both process could also share a variable `myWait = True`

--------------------------------------
## Deadlock, Starvation, Priority Inversion Problems

### Deadlocks
- Multiple Processes **Waiting Indefinitely** for an event that can be triggered by only One of the waiting Processes
    - (i.e: `P0 { wait(Q); wait(S); signal(S); signal(Q); }` will probably not work )

### Starvation
- A Process is **Never Removed** from the Semaphore Queue in which it waits 
    - May happen if the Other Processes keep grabbing shared resource Before the Queued Process

### Priority Inversion
- When a **Lower Priority Process** holds a lock and prevents a **Higher Priority** process from acquiring it
    - (ex: see discord)

**Priority Inheritance:**
- If a **Higher Priority** process waits for a **Lower Priority** process to release the lock
    - the Lower Priority Process **temporarily inherits the priority** of the Waiting Process
- When process Releases the lock, the priority is Reverted