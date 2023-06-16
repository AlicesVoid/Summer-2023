# OPSYS Chapter 4: Threads #   

## Overview:
**Why we care:**
- most modern applications are multithreaded
- threads run within application
- multiple tasks with the app. can be implemented by separate threads:
    - update display
    - fetch data
    - spell-check
    - answering a network request
- process creation is heavy-weight, while thread creation is light-weight
- can simplify code, increase efficiency
- kernels are generally multithreaded

### Thread Introduction
**Threads:**
- Basic Units of CPU Utilization
- Components:
    - **Program Counter:**
        - keeps track of what instructions to execute next
    - **Register Values:**
        - stores the current working variables
    - **Stack:**
        - keeps track of the program execution history

**Thread vs. Process:**
- **Process:**
    - used for grouping resources together
    - classical processes have a set of instructions and a Single Thread of control (i.e: execution)
- **Thread:**
    - an entity scheduled for the execution on the CPU
    - **Multithreading:**
        - allowing a process to have Multiple Parallel Threads of execution

**Benefits**
- **Responsiveness:**
    - may allow continued execution if part of process is blocked, especially important for UI
- **Resource Sharing:**
    - threads share resources of process, Easier than shared memory or message passing
- **Economy:**
    - cheaper than process creation, thread switching Lower Overhead than context switching
- **Scalability:**
    - process can take advantage of multiprocessor architectures

### Thread Types
**User Threads:**
- Management done by User-Level Threads Library
- types of libraries:
    - POSIX Pthreads
    - Windows threads
    - Java threads

**Kernel Threads:**
- Threads being Supported by the Kernel
- examples:
    - Windows
    - Solaris
    - Linux
    - Tru64 UNIX
    - Mac OSX

------------------------
## Multicore Programming:
**Multicore Programming**
- Multicore or Multiprocessor systems putting pressure on programmers
- **Challenges:**
    - Dividing Activities
    - Balance
    - Data Splitting
    - Data Dependency
    - Testing and Debugging
- **Parallelism:**
    - implies a system can Perform More Than One Task Simultaneously
    - Types: 
        - **Data Parallelism:**
            - distributes subsets of the same data across multiple cores
                - same operation on each core
        - **Task Parallelism:**
            - distributing threads across cores, each thread performing unique operation
- **Concurrency:**
    - supports more than one task making Progress
        - Single Processor / Core, scheduler providing concurrency
- **NOTE:**
    - as the # of threads grows, so does architectural support for threading
        - CPUs have Cores as well as Hardware Threads
            - (ex: Oracle SPARC T4 has 8 cores, 8 hardware threads per core)

### Multithreading
**Intro:**
- All Threads Share: 
    - data section, code section, and opened files
- Each Thread Has it's own:
    - Program Counter, Registers, and Stack

------------------------
## Multithreading Models:
**Multithreading Models:**
- **Many-to-One:**
    - Many User Threads mapped to One Kernel Thread
    - few systems actually use this 
    - Pros:
        - User can create Any Number of Threads
        - Kernel has more control over who gets CPU time
    - Cons:
        - One Thread Blocking causes All Threads to Block
        - Multiple Threads may not run in parallel on multicore systems
            - only One may be in Kernel at a time
    - examples:
        - Solaris Green Threads
        - GNU Portable Threads
- **One-to-One:**
    - Each User Thread mapped to One Kernel Thread
        - Creating a User Thread creates a Kernel Thread
    - Pros:
        - More Concurrency than many-to-one
            - Results in True Concurrency
    - Cons:
        - Number of Threads per Process sometimes restricted due to overhead
            - the Overhead of creating a Thread is high
                - Most implementations Limit the number of threads
        - Kernel has Less Control
    - examples:
        - Windows
        - Linux
        - Solaris 9 (and later)
- **Many-to-Many:**
    - Many User Threads to Many Kernel Threads
        - Multiplexes use this
    - Types:
        - **Bound:**
            - Each Thread mapped to a Single Kernel Thread
            - a.k.a: Two-Level Model
        - **Unbound:**
            - Many Threads mapped to a Single Kernel Thread
    - Pros:
        - Only the Caller Thread blocks on a blocking system call
        - Enables Threads to Run Concurrently on Multiple Processors
        - Tries to get "the best of both  worlds" of Many-to-One and One-to-One
    - examples: 
        - Old Solaris
        - IRIX
        - HP-UX
        - Tru64 UNIX

### MAPPING 
**Importance:**
- Kernel Threads are Real Threads in the system
    - User Threads are based on software techniques (multithread programming)
- Kernel Thread is the Unit of Execution 
    - Scheduled by the Kernel to Execute on the CPU
- User Threads require association with Kernel Threads
- Allows OS Kernel to Have More Control over User Threads (for better performance)
    - (i.e: what if a user created 100 threads for a task that actually requires one thread?)

### Terminology Recap
**Kernel Threads:**
- Software Threads that are Created and Scheduled by the OS 
- the Real Threads in the system

**User Threads:**
- Software Threads created by User-Mode Libraries

**Software Threads:**
- Software-Level Threads (i.e: Kernel and User Threads)
- Created by OS or other Application Programs

**Hardware Threads:**
- Allow better utilization of the Processor under some circumstances
- Featured in Some Processors

**Hyperthreading (Intel):**
- Method to Improve the Efficiency of One Core
- Intel made this

------------------------
## Thread Libraries: 
**Thread Libraries:**
- Provides Programmers with API for creating/managing threads
- **Implementation Methods:**
    - Library entirely in User Space
    - Kernel-Level Library supported by the OS

**Pthreads:**
- provided as either User-Level or Kernel-Level
- a POSIX standard API for Thread Creation and Synchronization 
- **Specification, not Implementation:**
    - API Specifies behavior of the Thread Library
        - Implementation is up to the Development of the Libarary
- Common in UNIX OS (Solaris, Linux, MAC OS X)

**Java Threads:**
- Mangaged by the JVM
- Typically implemented using Thread Models provided by Underlying OS
- **Creation:**
    - `public interface Runnable { public abstract void run(); }`
    - Extending Thread class
    - Implementing the Runnable Class

------------------------
## Implicit Threading:
**Implicit Threading:**
- Creation and Management of Threads done by Compilers and Run-Time Libraries as opposed to Programmers
    - Growing in popularity as number of threads increase (easier to proofread/debug)
- **Methods:**
    - Thread Pools
    - OpenMP
    - Grand Central Dispatch
    - (etc: Microsoft Thread Building Blocks, java.util.concurrent package)

**Thread Pools:**
- Create a Number of Threads in a Pool where they Await Work 
- Pros: 
    - usually Faster to sevice a request with an Existing Thread than to create a new one
    - allows the Number of Threads in apps to be Bound to the Pool Size
    - Separating task to be Performed from mechanics of Creating task allows new strategies for running tasks
        - Tasks could be scheduled to run periodically 
- **Windows API Thread Pool Method:**
    - `DWORD WINAPI PoolFunction(AVOID Param) { /* this function runs as a separate thread */ }`

**OpenMP:**
- Set of Compiler Directives for an API (C, C++ Fortran)
- Provides support for Parallel Progreamming in Shared-Memory Environments 
- Identifies Parallel Regions:
    - blocks of code that can run in Parallel
- **Methods:**
    - `#pragma omp parallel {  /* some parallel code here */ }` 
        - Creates as many Threads as there are Cores
    - `#pragma omp parallel for(i=0; i<N; i++) { /* some parallel-able loop code */ }`
        - Runs a For Loop in Parallel

**Grand Central Dispatch:**
- Apple Tech for MAC OS X and iOS 
- Extensions to C, C++ languages, API, and Run-Time Library
- Allows Identification of Parallel Sections
- Manages most of the details in Threading
- Block is in `^{ /* code block goes here */ }` format
- Blocks placed in **Dispatch Queue:**
    - Assigned to Available Thread in Thread Pool when removed from Queue
- **Types:**
    - **Serial:**
        - Blocks Removed in FIFO order, One by One
        - Queue is Per Process, called the Main Queue
            - Programmers can make additional Serial Queues within Program
    - **Concurrent:**
        - Blocks Removed in FIFO order, but Several may be removed at a time
        - Three System Wide Queues w/ priorities (low, default, high)

------------------------
## Threading Issues:
**Threading Issues:**
- Semantics of fork() and exec() system calls
- Signal Handling
    - Synchronous and Asynchronous
- Thread Cancellation of Target Thread
    - Asynchronous or Deferred
- Thread-Local Storage
- Scheduler Activations

**Semantics of fork() and exec() system calls:**
- Does fork() Duplicate only the calling thread? or all threads?
    - some UNIXes have two versions of fork
- Does exec() replace only the calling thread? or all threads?
    - exec() usually works as normal- replacing the running process including All Threads

**Signal Handling:**
- Signals are used in UNIX systems to notify a process that a particular event has occurred
- a **Signal Handler** is used to process signals:
    1. Signal is Generated by a Particular Event
    2. Signal is Delivered to a Process
    3. Signal is Handled by one of two signal handlers (default or user-defined)
- Every Signal has a **Default Handler** that kernel runs when handling signal 
    - **User-Defined Signal Handler** can override the default 
    - For single-threaded, signal delivered to process
- Where should a signal be delivered for multi-threaded?
    - Deliver the signal to the thread to which the signal Applies
    - Deliver the signal to Every Thread in the process
    - Deliver the signal to Certain Threads in the process
    - Assign a Specific Thread to receive all signals for the process

**Thread Cancellation:**
- Terminating a Thread before is has Finished
- Thread to be canceled is the Target Thread
- Two Approaches:
    - **Asynchronous Cancellation:**
        - terminates the Target Thread Immediately
    - **Deferred Cancellation:**
        - allows the Target Thread to periodically check if it should be Cancelled
        - Default Thread Type
        - Cancellation only occurs when Thread reaches Cancellation Point
            - ( i.e: pthread_testcancel() )
            - then Cleanup Handler is invoked
- If thread has Cancellation Disabled:
    - Cancellation remains pending until Thread enables it
- **Pthread Method:**
    - `pthread tid;`
    - Create a Thread: `pthread_create(&tid, 0, worker, NULL);`
    - Cancel a Thread: `pthread_cancel(tid);`
- on Linux: 
    - thread cancellation is handled through signals

**Thread-Local Storage (TLS):**
- Allows each thread to have it's Own Copy of Data
    - Useful when you do not have control over thread creation process (i.e: thread pools)
- Different from Local Variables:
    - Local Variables visible only during Single Function Invocation
    - TLS visible across Function Invocations 
- Similar to Static Data
    - TLS is Unique to Each Thread

**Scheduler Activations:**
- Both M:M and Two-Level Models require Communication to Maintain the Appropriate Number of Kernel Threads Allocated
- Typically use an Indermediate Data Structure between User and Kernel Threads: 
    - **Lightweight Process (LWP):** 
        - Appears to be a Virtual Processor on which a process can schedule User Thread(s) to run
        - Each LWP attached to Kernel Thread
        - How many LWPs to create?
- Schedule Activations provide **Upcalls:**
    - communication mechanism from the Kernel to an **Upcall Handler** in the Thread Library
    - This communication allows an app to maintain the Correct Number of Kernel Threads

------------------------
## Operating System Examples: 

### Windows Threads
**Windows Threads:** 
- Windows implements the WIndows API (primary API for Windows 98, NT, 2000, and 7)
- Implements the One-to-One mapping, Kernel Level
- Each Thread Contains:
    - a Thread id 
    - Register set representing state of processor
    - Separate User and kernel Stacks for when thread runs in User-Mode or Kernel-Mode
    - Private Data Storage area used by Run-Time Libraries and Dynamic Link Libraries (DLLs)
- The register set, stacks, and private storage area are known as the context of the thread

**Primary Data Structures of a Thread:**
- **ETHREAD (executive thread block):**
    - includes Pointer to Process to which thread belongs to KTHREAD, in kernel space
- **KTHREAD (kernel thread block):**
    - Scheduling and Synchronization info, kernel-mode stack, pointer to TEB, in kernel space
- **TEB (thread environment block):**
    - Thread id, user-mode stack, thread-local storage, in user space

### Linux Threads
**Linux Threads:**
- referred to as Tasks rather than Threads
- Thread Creation is done through `clone()` syscall
    - clone() allows a child task to share the address space of the parent task (process)
- Points to Process Data Structures (shared or unique): `struct task_struct`