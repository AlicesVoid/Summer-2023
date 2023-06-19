# OPSYS Chapter 6: Scheduling #   

## Introduction 
### CPU Scheduling
- CPU is one of the Primary Computer Resources
- **Scheduling:**
    - selecting the Next Process for execution on the CPU once the current process leaves the CPU Idle 
    - maximizes the degree of Multiprogramming (something is running at all times)
    - **Scheduling Factors:**
        - CPU Execution 
        - I/O waiting

### CPU-I/O Burst Cycle:
- Processes alternate between CPU Bursts and I/O Bursts
    - ( Burst -> performing a process for something )
    - usually encompasses Large Number of Short CPU Bursts 
        - and a Small Number of Long CPU bursts

### Short-Term CPU Scheduler:
- Selects a process and alloctaes the CPU to the process (from processes in memory ready to execute)
- **Scheduling Decisions:**
    1. When a process switches from Running to Waiting state
    2. When a process switches from Running to Ready state
    3. When a process switches from Waiting to Ready state
    4. When a process Terminates
    - NOTES:
        - Scheduling under 1 and 4 is **NonPreemptive:**
            - process executing on CPU Can Be Interrupted in order to make-way for other processes
        - All other scheduling is **Preemptive:**  
            - process executing on CPU Cannot Be Interrupted, and so it runs to completion

### Dispatcher:
- Module that Gives Control of the CPU to the scheduler-selected Process
    - Switches the Context
    - Switches to User Mode 
    - Jumps to the Proper Location in the Program to Restart that Program
- Invoked during Every Process Switch
- **Dispatcher Latency:**
    - The time it takes for the dispatcher to Stop one process and Start another 
    - Should be Minimized!

--------------------
## CPU Scheduling Algorithms

### Scheduling Criteria
- Performance Metrics of Scheduling Algorithms
- **CPU Utilization:** 
    - keeping the CPU as busy as possible 
- **Throughput:**
    - the amount of processing that can be performed (per unit of time)
- **Waiting Time:** 
    - the amount of time the process spends in the Ready Queue
- **Response Time:**
    - the amount of time it takes from when a Request is Submitted, until the First Response is produced
- **Running Time:**
    - the amount of Execution Time of the process
    - Running Time = CPU Burst Time
- **Turnaround Time:**
    - how long does it take to execute a process?
    - Turnaround Time = Waiting Time + Running Time 

### First-Come First-Served (FCFS)
- the process that Requests the CPU first is Allocated to the CPU first 
- **Example:**
    - Suppose Processes w/ Burst Times Arrive in order: { P1, P2, P3 | 24ms, 3ms, 3ms } 
    - **Gantt Chart:** 
        - (shows starting and ending times)
    - **Waiting Times:**
        - { P1, P2, P3 | 0ms, 24ms, 27ms } 
    - **Average Waiting Time:** 
        - (0 + 24 + 27) / 3 = 17 ms 
    - **Turnaround Times:** 
        - { P1, P2, P3 | 24ms, 27ms, 30ms } 
    - **Average Turnaround Time (ATT):** 
        - (24 + 27 + 30) / 3 = 27ms
- Pros:
    - Simple to Implement and Understand
- Cons:
    - Average Waiting Time is often Quite Long
    - **Convoy Effect:**
        - Short Process waiting behind a Long Process
    - **Non-Preemptive:**
        - once CPU is allocated to a process, that process keeps the CPU til it requests I/O or Termiantes

### Shortest-Job-First 
- Associates with each proces the Length of it's next CPU Burst 
    - use these lengths to Schedule the process with the shortest time
    - can be either Preemptive or NonPreemptive
- **NonPreemptive Example:**
    - Suppose Processes w/ Burst Times Arrive in order: { P1, P2, P3, P4 | 6ms, 8ms, 7ms, 3ms }
    - **Waiting Time:** 
        - { P1, P2, P3, P4 | 3ms, 16ms, 9ms, 0ms } 
    - **Average Waiting Time:** 
        - (3 + 16 + 9) / 4 = 7ms (10.25 w/ FCFS)
    - **Shortest-Remaining-Time-First (SRT):**
        - Will Interrupt the currently executing process 
        - Order is determined by which Process has the Shortest Remaining Time 
- Pros:
    - Optimal Layout (gives The Minimum Avg. Wait Time for a set of Processes)
- Cons:
    - Relies on Process Length Estimations for CPU Request 
    - What if we have an emergency job that's very long?

--------------------
## Priority Queue
### Priority Scheduling
- each Process has an **Associated Priority:**
    - CPU is allocated to the process w/ the Highest Priority (Preemptive or NonPre)
        - Smaller Priority Number = Higher Priority
    - All Processes Arrive at The Same Time 
- **Preemptive Priority:**
    - Scheduling will preempt the CPU if the newly-arriving process has a Higher Priority than the current one
    - **Starvation:**
        - Low-Level Priority Processes may have tow ait infinitely 
            - (i.e: MIT's IBM-7094 that starved a process for 6 years)
            - Solution: Aging! (gradually increase priorities based on their wait time)
- **Linux:**
    - Processes have a **Nice Value:**
        - from -20 to 19
        - Lower Values indicate Higher Priority
    - Methods:
        - start program ls w/ nice value of 19: `nice -n 19 ls`
        - change nice value of pid 1234 to 15: `renice 15 -p 1234`

### Round-Robin (RR)
- Each Process gets a small amount of CPU Time (i.e: Time Quantum) and then added to the end of the Ready Queue
    - Process Waiting Time: `(n-1)*q time units ( n: processes, q: time-quanta )`
    - Performance is Sensitive to choice of **Time Quanta:**
        - **Very Large:**
            - RR degenerates to FCFS Model 
        - **Very Small:**
            - q must be large in comparison to Context-Switch latency
                - otherwise Overhead is too high 
                - nothing ever gets done, really
        - **Turnaround:**
            - most efficient if processes finish their Next CPU Burst in 1 time-quantum
- **Example:**
    - lets say NonPreemptive Processes { P1, P2, P3 | 24ms, 3ms, 3ms } and q = 4ms
    - **Waiting Times:**
        - { P1, P2, P3 | 6(10-4)ms, 4ms, 7ms }

--------------------
## Multi-Level Queue
- Partitions the Ready Queue into **Several Separate Queues:**
    - Processes are Permanently Assigned to Queues (based on property,size,type,etc... )
    - Each Queue has it's Own Scheduling Algorithm
    - Requires the Queues Themselves to be Scheduled Together (usually preemptive)

### Multi-Level Feedback Queue
- Similar to Multilevel Queue Scheduling, but the process can Move Between Queues
- **Scheduler Parameters:**
    - Number of Queues
    - Scheduling Algorithm for Each Queue
    - Method to determine when to Upgrade a Process
    - Method to determine when to Demote a Process
    - Method to determine which Queue a process will Enter when that process needs Service
- **Example:**
    - 3 Queues { Q0, Q1, Q2 | RR-8ms, RR-16ms, FCFS }
    - **Scheduling:**
        - A New Process enters Q0 
        - When it gets to the CPU, it receives 8ms of Burst Time
        - If it doesn't finish in 8ms, it's moved to Q1 
        - If it doesn't finish in 16ms on Q1, it's moved to Q2
        - It Will Get Done in Q2

### Multi-Processor Scheduling
- CPU Scheduling is More Complex when Multiple CPUs are available
- Homogeneous Processor within a Multiprocessor
- **Asymmetric Multiprocessing:**
    - One processor Handles All Scheduling, I/O Processing, etc... 
        - all other processors only execute User Code
    - Only one processor access the System Data Structures 
        - no need to worry about data sharing issues
- **Symmetric Multiprocessing (SMP):**
    - Each Processor is Self-Scheduling, in common-ready queue, or each has it's own private queue of ready processes
- **Processor Affinity:**
    - Process has affinity for Processor that it's currently running on
    - **Soft Affinity:**
        - A process Can migrate between processors
    - **Hard Affinity:**
        - A process Cannot migrate between processors

--------------------
## Pthreads 

### Pthreads Scheduling
- **User-Level** and **Kernel-Level** Threads are Scheduled Differently:
    - M:1 and M:M models, thread libraries schedule User Threads to run on a **Lightweight Process (LWP):**
        - Virtual Processor on which the Thread can be scheduled
    - **Process-Contention Scope (PCS): User:**
        - Thread of a process Competes for execution on a LWP (or Kernel Thread) with other same-process User Threads
    - **System-Contention Scope (SCS): Kernel:**
        - Thread executing User Threads of a process compete for execution on the CPU w/ other same-process Kernel Threads

### Pthreads API 
- Enables the devs to specify either PCS or SCS during Thread Creation
    - **PTHREAD_SCOPE_PROCESS:**
        - schedules threads using PCS (each thread is bount to an available LWP)
    - **PTHREAD_SCOPE_SYSTEM:**
        - schedules threads using SCS (M:M systems create/bind an LWP for each User Thread)

### CPU Scheduling on NUMA Systems
- **Non-Uniform Memory Access Systems (NUMA):**
    - comprises Combined CPU and Memory Boards
    - CPUs on the board can access the Memry on that board with Less Latency than the other boards
    - **Scheduling Goal:** 
        - Schedule a process on the CPU attached to the memory bank containing the process data