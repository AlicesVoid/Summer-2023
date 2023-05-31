# OPSYS Chapter 1: Introduction #   

## 1.1: OS Purposes ##   
### User-Interface
- OS mediates between Hardware and Application Programs  

### System Organization  
- OS allocates resources in order to run apps efficiently  
- OS controls the execution of programs to ensure integrity  

### Process vs Program  
- __Process__: a unit of work on the system (active)
- __Program__: a set of instructions for a process (passive)

### Process Management
__To-Do:__
- OS systems must mediate the process & system tools:
    - __Allocate__ resources when program starts
    - __Manage__ resources while program runs 
    - __Reclaim__ resources when process terminates
- __Multiplex__ resources among multiple processes
- Provides the means for: 
    - Suspending/Resuming a process
    - Process Synchronization
    - Inter-Process Communications

__Accessing Hardware:__
- OS mediates processes and system resources
    - Processes are __Restricted__ from Direct Hardware Access
        - Processes must request OS to perform access

__Request Services:__
- OS exposes a set of __System Calls:__
    - Processes can Request Services from the OS such as: 
        - Read File from the Disk
        - Send Data over the Network
        - Send Message to Another Process
- Stored in some table (ex: linus -> system call table)

__Dual Mode Operation:__
- __User Mode:__
    - Process Execution 
    - Allows Process to execute only Unprivileged Instructions
        - CPU Restricts other processes
- __System Mode:__
    - OS Execution
    - CPU Allows execution of Privileged Instructions
- __Method:__
    - uses a __Mode Bit__ to determine system mode: 
        - `Set to 0 = System Mode` 
        - `Set to 1 = User Mode` 
    - allows for CPU to quickly verify for Privileged Instructions
- __Benefits:__
    - Protects OS from Errant Programs/Users
    - Protects Errant Users/Programs from eachother 
  
__Example 1: Typical Process Execution Case__  
1. Process executes Unprivileges Instructions and Reads File
2. Process invokes a `System Call`:
    - system switches from `User Mode` to `System Mode` 
    - OS performs Disk Access Service and returns Data 
        - if not found, returns error prompt
3. OS completes the requested service 
    - system switches from `System Mode` to `User Mode` 

### Memory Management 
__Main Memory:__
- a Large Array of Bytes, where each Byte has its own address
- ONLY large storage DIRECTLY accessible by the CPU 
- usually stores sveral programs at once

__Memory Management:__
- keeps track of what is doing what in the memory
- decides which processes to move in/out from memory
- Allocates/Deallocates Memory as needed

### Storage Management
__Files:__
- For convenience, we sort info into __Files:__ 
    - collections of related information defined by its creator
- OS System File Management Services: 
    - Create/Delete Files 
    - Create/Delete Directories (collections of files)
    - Mapping Files to Memory on the Storage Device 
    - File Backup

__Heirarchy:__
- Main Order: 
    1. Hardware Registers
    2. Cache Memory (CPU/motherboard/etc...)
    3. Main Memory (RAM)
    4. Secondary Storage (disk/ssd/etc...)
- NOTES: 
    - Smaller Number -> Faster Device 
    - Larger Number -> More-Expensive Device
    - Must ensure Data Consistency along all heirarchy levels

### I/O Management
__Purpose:__
- Hide peculiarities of Specific Devices from the User 

__Example: Unix I/O Subsystem__
- Provides: 
    - Functionality to Manage Data Buffering, Caching, and Spooling
    - A general device Driver Interface
    - Drivers for the Specific Hardware Devices

### Protection and Security
__Protection:__
- Internal to the OS
- Controls the Access of Users/Processes to the System Resources
- (ex: processes overwriting eachother, etc...)

__Security:__
- External to the OS 
- (ex: malware, viruses, worms, trojans, etc...)

### Computer Environments 
__Distributed Systems:__ 
- a collection of physically separate, networked systems that share resources
- Advantages:
    - Increases computation speed, functionality, data availability, and reliability
- Interconnectivity:
    - Local-Area Network (LAN): 
        - Connects systems within a single floor room or building
    - Wide-Area Network (WAN): 
        - Connects buildings, cities, or countries

__Mobile Computing:__
- Computing on Handheld Smartphones and Tablet Devices
- Sacrifices Computer Size & Capacity in favor of Portability 
- Allows for Portability-Focused Apps: 
    - Navigation, Augmented Reality, Photography, etc... 
- Dominant OSs:
    - iOS: Apple Devices (bad)
    - Android: Not-Apple Devices (good)

### Computer System Types 
__Embedded Systems:__
- systems dedicated to Specific Tasks 
    - usually little to no UI
    - one of the most prevalent types of computers
    - (ex: car-engine control, robotic arms, etc...)

__Real-Time Systems:__
- systems dedicated to Time-Constraint Tasks 
    - usually are paired with Embedded Systems
    - used for specific real-world tasks that require timing 
    - (ex: self-driving cars, assembly robots, etc...) 

__Multimedia Systems:__
- systems made to Deliver Multimedia Content 
- usually have flexible User Interfaces for several purposes
- some media must be delievered within time constraintes (real-time)
- (ex: text, video, etc...)

### Computing Models
__Virtual Machines:__
- Software that can run it's own OS and Apps (mimics a physical system)
- treated as Application Programs by the OS, but 
    - usually more flexible 
    - may have more permissions than standard application programs

__Cloud Computing:__
- delivery of services over a network 
- reduce operating costs
- imrpove resource utilization 
- make it easier to tackle large-scale computing
- types of services: 
    - __Infrastructure-as-a-Service (IaaS):__
    - __Platform-as-a-Service (PaaS):__
    - __Software-as-a-Service (SaaS):__
- types of clouds: 
    - __Public:__
    - __Private:__
    - __Hybrid:__

## ETC Lecture Notes: ##  
 
### CPU
- Performs Instructions based on Memory Locations  
- Involved in High-Level Operations  
- Run by the User  

### Main Memory  
- Linear Sequence of Addressable Bytes 
- Manages Heterogeneous Collection of Entities & Functions 
- View-able by the User 

### Secondary Storage
- Multi-dimensional Structure 
- Requires Complex Low-Level Operations to Store/Access Data
- User doesn't need to know about low-level operations

### I/O Devices
- Reads/Writes Registers of Device Controllers
- Demands Simple, Uniform Interfaces to access devices
- Interacted with by the User