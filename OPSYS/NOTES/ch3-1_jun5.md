# OPSYS Chapter 3: Processes 1 #   

## Processes Overview:

### Terminology Review
**Program:**
- a set of instructions for the system (passive)

**Process:**
- a unit of work on the system (active)

**Application:**
- a series of 1 or more processes working in parallel

### Process Memory
**Stack:**
- stores function parameters, local variables, and return addresses (local variables & function op.s)

**Heap:**
- contains dynamic memory allocated during process runtime (new/dynamic variable creation)

**Data:**
- contains global variables (global variables & constants)

**Text:**
- stores the program instructions (executable)

### Process States 
**In-General:**
- **New:**
    - Process being created
- **Running:**
    - Instructions are being executed
- **Waiting:**
    - Process is waiting for some event (I/O Completion)
- **Ready:**
    - Process waiting to be assigned a processor
- **Terminated:**
    - Process has finished execution

**Linux:**
- **R:**
    - Process is running/runnable (on run queue)
- **D:**
    - Uninterruptible Sleep (usually I/O)
- **S:**
    - Interruptible Sleep (waiting for an event to complete)
- **Z:**
    - Terminated but not reaped by its parent (Defunct/Zombie)
- **T:**
    - Stopped, either by job control signal or because it's being traced

### Process Control Block (PCB)
**PCB Components:**
- **Process State:**
    - The state of the process (ex: running)
- **Process ID:**
    - A unique ID associated with the process (ex: 123)
- **Program Counter:**
    - The address of the next instruction to be executed
- **CPU Registers:**
    - The current values of the accumulators, stack pointers, etc...
- **CPU-Scheduling Info:**
    - etc. priority and other info required for process assignment in CPU
- **Memory Management Info:**
    - info about memory belonging to the process
- **Accounting Info:**
    - how long processes are running (nd other associated info, etc...)
- **I/O Status Info:**
    - List of I/O devices used by the process, list of open files, etc...

**PCB Example:**
- **Linux PCB struct (task_struct):**
    - struct **mm_struct mm** (stores memory info)
    - struct **files_struct *files** (list of open files)
    - etc... 

## Process Scheduling:

### Process Scheduling: The Queuing Mechanism 
- Objective of **Multiprogramming** (supporting multiple processes)
    - always run some process to increase CPU utilization

**Process Scheduler:**
- decides which available processes get the CPU
- implementation
    - **Job Queue:**
        - contains all processes on the system
    - **Ready Queue:**
        - contains processes that are in main memory & ready to execute
    - **Device Queue:**
        - contains all processes waiting to use a particular device (1 per device)

**Order of Operations:**
1. New process is placed on a **Ready Queue**
2. The process is **dispatched** (selected for execution)
3. **During Execution:**
    - Process may be queued on the device queue using an **I/O Request**
    - Process can create new **Subprocesses** and wait for it's termination
    - Process can be **Interrupted** and removed from the CPU
    - Process **time slice** (time allotted for it's CPU use) expires:
        - process is removed from CPU
        - process is re-placed on Ready Queue until scheduled for another time slice


### Process Scheduling: Schedulers 
**Short-Term:**
- decides which process in memory gets the CPU
- invoked Very Frequently (often at leats once every 100msec)
- Must Be Efficient

**Long-Term:**
- selects spooled processes to load from mass storage device into main memory
- executes less frequently than a short-term scheduler 
- maximize resource util by selecting a **Mix** of **CPU-bound** and **I/O-bound** processes:
    - **I/O-Bound Processes:**
        - processes that spend more time doing I/O operations than CPU computations
    - **CPU-Bound Processes:**
        - processes that spend more time doing CPU computations than I/O operations
    - Importance of Mixing Processes:
        - only I/O-bound means the CPU is empty
        - only CPU-bound means the I/O is empty
- not present on all systems (ex: Windows and Unix)

 **Medium-Term:**
- removes some processes from memory in order to improve process mix 
    - later, removed processes can be brought back into memory
- core job is **Swapping** to improve the process mix

### Process Scheduling: Context-Switching
**Context Switch:**
- switching CPU between processes:
    - storing the state of a thread/process so it can be restored from the **Same Point** later
    - allows multiple processes to **Share One CPU** 
    - essential feature of multitasking Operating Systems 
- Method:
    1. Save CPU State of the currently-executing process into a PCB
    2. Select Another Process
    3. Use the **Saved PCB of the Selected Process** to initialize the CPU
    4. Let the **Selected Process** resume execution
- context switch time is **Pure Overhead** (constant expense)

## Operations On Processes

### Operations on Processes: Process Trees
**Process Trees:**
-  A process may create **new processes_ by issuing a process-creating system (asking OS to create another process)
- **Parent Process:**
    - The creator process
- **Child Process:**
    - The process created by a parent process
    - These can, in turn, create more process (becoming parents too!)
- **Process Tree:**
    - A model of parent-child process relationships 

**Process Tree Visuals:**
- **Linux:**
    - displayed using `htop` program
- **Windows:**
    - `End Process Tree` (in Task Manger) terminates selected process & all descendants

### Operations on Processes: Parent-Child Relations
- after creating a child process, a parent process may:
    - continue executing
    - wait for the child process to terminate to continue
- the child process can either:
    - be a duplicate of the parent process (same program & data)
    - run an entirely new/different program 