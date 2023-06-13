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
- All Threads Share: 
    - data section, code section, and opened files
- Each Thread Has it's own:
    - Program Counter, Registers, and Stack

### CONTINUE ON PAGE 12 MORE MULTITHREADING

------------------------
## Multithreading Models:

------------------------
## Thread Libraries: 

------------------------
## Implicit Threading:

------------------------
## Threading Issues:

------------------------
## Operating System Examples: 