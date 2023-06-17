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

### Shortest-Job-First CONTINUE ON SLIDE 14 WHOAAAAAAAAAA

--------------------
## Priority Queue

--------------------
## Multi-Level Queue

--------------------
## Pthreads API 