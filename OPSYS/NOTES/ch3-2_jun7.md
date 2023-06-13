# OPSYS Chapter 3: Processes 2 #   

## Operations on Processes:

### Operations on Processes: Process Creation Steps in Unix/Linux
**fork() system call:**
- issued by a Parent Process to create a Child Process:
    - Child Process is a **clone** of Parent Process
- Both parent and child continue execution at the instruction **immediately after fork():**
    - in the child, fork() **returns 0**
    - in the parent, fork() returns **process id** of the child
    - on failure, fork() **returns -1**
- **Child Process Inherits:**
    - Set of Files opened by the Parent Process
    - Other Resources... (?)

**exec(...) :**
- Replaces the Program of the caller process with a New Program
- **exec() variants:**
    - int execl(const char *path, const char *arg, ...);
    - int execlp(const char *file, const char *arg, ...);
    - int execle(const char *path, const char *arg,..., char *const envp[]);
    - int execv(const char *path, char *const argv[]);
    - int execvp(const char *file, char *const argv[]);
    - int execvpe(const char *file, char *const argv[], char *const envp[]);
    - **NOTE:**
        - ALL follow the format: `int exec(file location, arguments to pass to process);`
        - All return -1 on Failure

**wait(...) :**
- Waits until the Child Terminates
- **wait() variants:**
    - pid_t wait(int *status);
    - pid_t waitpid(pid_t pid, int *status, int options); 
    - int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options); 
    - **NOTE:**
        - wait() and waitpid() return the process id of the child
        - waitid() return 0 on success and -1 on faliure

**exit(int exitcode) :**
- Terminates the caller process with the specified exit code

### Operations on Processes: Process Creation Altogether in Unix/Linux
1. Start with a Parent Process
2. Parent Process issues a `fork()` syscall
3. `fork()` clones the parent process
    - Both parent and child continue by executing the Next Instruction After `fork()`
    - In parent, `fork()` returns the process id of the child
    - In child, `fork()` returns 0
4. Parent issues a `wait()` syscall to wait until child terminates
    - Child issues a `execlp()` syscall to replace its executable image with that of ls command
5. Parent waits (in `wait()`) for the child to terminate
    - ls command executes starting from the first instruction
        - original child code is destroyed
6. `wait()` returns and Parent Process executes the next instruction
    - ls command finishes execution and terminates
7. Parent Process issues an `exit()` syscall in order to self-termiante
8. Parent Process terminates

### Operations on Processes: Zombie State in Unix/Linux
**Zombie Process:**
- a Terminated Process whose PCB was not Deallocated (PCB contains child's exit code i.e. code returned by int main())
    - If a parent `fork()`s a child, but does not issue a `wait()` After the child terminates:
        - then the terminated child becomes a **zombie process**
- Child's exit code may be useful to the Parent (to see whether the child has exited with an error pawssibly)

### Operations on Processes: Orphan State in Unix/Linux
**Orphan Process:**
- What if the parent process terminates instead of calling `wait()` on the child?
    - Child becomes an **Orphan Process**
    - init process becomes the New Parent of the orphaned child
    - init periodically calls `wait()` to collect the return statuses of Orphans

------------------------
## INTERPROCESS COMMUNICATIONS (IPC) 
**Process Categories:**
- **Independent:**
    - cannot affect or be affected by other processes
- **Cooperating:**
    - process that can affect/be-affected by other processes
        - (i.e: sharing memory with other processes)

**Advantages of Process Co-op:**
- **Information Sharing:**
    - (i.e: exchanging data)
- **Computation Speedup:**
    - (i.e: breaking tasks into sub-tasks to execute them concurrently)
- **Modularity:**
    - divide system functions into separate processes
- **Convenience:**
    - allows work on multiple tasks at the same time

**Fundamental Models:**
- Models are necessary to mechanize Cooperating Processes
- **Shared Memory:**
    - Co-op processes exchange info by reading/writing data from/to a Region of Shared Memory
- **Message Passing:**
    - Co-op processes Exchange Messeges with eachother

### IPC: Shared Memory vs Memory Passing
**Shared Memory:**
- Pros:
    - Faster than Message Passing 
    - good for Large Transfers of Info
- Cons: 
    - requires Process Synchronization to ensure no memory-writing conflicts

**Message Passing:**
- Pros: 
    - No need for Synchronization
    - good for small info transfers
    - Easier to Implement than Shared Memory
- Cons: 
    - usually requires OS intervention on every msg. transfer (can be slower than shared memory)

### IPC: Shared Memory (Producer Consumer)
**Producer Consumer Problem:**
- Producer Process produces info for Consumer
- Consumer Process consumes info for Producer
- Solution: use **Shared Memory:**
    - Approach 1: **Unbounded Buffer**
        - No Practical Limits on size of the buffer 
        - producer may produce items infinitely
        - consumer Waits until items are available
    - Approach 2: **Bounded Buffer**
        - assures a Fixed Fize shared buffer
        - producer must Wait if the buffer is full
        - consumer must Wait if the buffer is empty

### IPC: Message Passing
**Functions:**
- `send(message):   //sends the message`
- `receive(message):   //receives the message `

**Types:**
- **Sizes:**
    - Fixed Size:
        - easier to implement, but imposes limitations
    - Variable-Size: 
        - harder to implement, but more flexible

**Links:**
- Synchronous or Asynchronous communication
- Automatic or Explicit buffering
- Direct or Indirect communications 
    - **Direct:**
        - process must Explicitly Name the Sender or Receiver
        - **Symmetrical:**
            - `send(P, message)    //sends from process P`
            - `receive(Q, message)   //receives from process Q`
            - Links processes automatically
            - Links are between Exactly Two Processes
            - each pair of processes has Only One Link
        - **Asymmetrical:**
            - sender must Explicitly Name the Receiver (not the Sender)
            - `send(P, message)    //sends from process P`
            - `receive(id, message)   //receives from Any Process (saves sender's id)`
    - **Indirect:**
        - process relies on Mailboxes to send/receive messages:
        - `send(A, message)    //sends to mailbox A`
        - `receive(A, message)   //receives from mailbox A`
        - Links exist only if processes Share a Mailbox
        - Links are associated with More than Two Processes
        - communicating processes Must Share a Mailbox

**Problems:**
- **Direct:**
    - if the Sender Process changes it's id, then every Receiver Process needs to change the Sender's id too
        - (i.e: if the Receiver saves Sender Messages, we need to update the id stored in all of those too)
- **Indirect:**
    - Multiple Receivers have access to the same Sender Messages (who gets them?)
        - (i.e: which receivers should get which messages)
        - *SOLUTION:* 
            - Restrict One Link to at most Two Processes
            - Allow only One Process at a time to Execute Receive
            - Select Receiver Arbitrarily and notify the Sender of the Receiver's id 

### IPC: Message Passing Synchronization
**Rendevous:**
- when both `send()` and `receive()` are implemented as blocking between two processes
    - Receiver Blocks until the Message is Available
    - Sender Blocks until the Receiver gets the Message

**Buffering:**
- Messages exchanged between processes get put in a Temporary Queue
- **Queue Implementation:**
    - Zero Capacity (no buffering):
        - queue has a max length of zero
        - Sender Must Block until the message is received
    - Bounded Capacity: 
        - queue has a finite capacity
        - Sender Blocks when the capacity is exceeded
    - Unbounded Capacity:
        - queue has infinite capacity
        - Sender Never Blocks

**Pipes:**
- UNIX ordinary pipes are used for Parent-Child communication
    - you can use `read()` and `write()` system calls to achieve this
- `pipe(fd)`
    - system call (where int fd[2]) creates a pipe where:
        - `fd[0]` is the `Read` end
        - `fd[1]` is the `Write` end
- Child Inherits the Pipe
    - Pipes are treated like files (child inherits state of parent files)
- Parent and Child should close the Unused Ends of the Pipe

**Named Pipes:**
- implemented Through a File on the System
    - multiple processes can read/write with the file as a Buffer for IPC data
- supports Bi-Directional Relay of Data (one direction at a time)
- persists after processes that use them have Terminated
    - must be Explicitly Removed
- can be used for IPC between Unrelated Processes (and can be reused too)
- **Implementation:**
    - use a FIFO in UNIX Shell (mkfifo command)
        - NOTE: FIFO means Named Pipe in UNIX
        - (i.e: Methods)
            - Create a FIFO: `mkfifo myfifo`
            - Write a string to the FIFO: `echo “Hello” > myfifo`
            - Read a string from the FIFO: `cat myfifo`
        - (i.e: Named Methods)
            - Create a Named FIFO: `mkfifo("myfifo", S_IWUSER | S_IRUSR);`
                - first param is name 
                - second param implies User can Read/Write to the FIFO
            - Read/Write to FIFO: `fread()`, `fgets()`, `fstream`, etc...
                - any other standard method will work also

**Sockets:**
- Socket: 
    - an Endpoint of communication
- Pair of Processes communicate using a Pair of Sockets
- Provide means for Low-Level communications: unstructured byte-stream
- Reading/Writing is similar to Pipes
- **Identification:**
    - concatenate an IP Address & a Port Number on the system
- **Operation:**
    - a server Listens on the port, to which the client connects
    - the server Accepts the client's connection
    - the server sets up a Pair of Sockets used for comms

------------------------
## UNIX SYSTEM V (FIVE) IPC

### IPC Examples: System V Shared Memory 
**System V Shared Memory:**
- Allocate a Shared Memory Region: 
    - `segment_id = shmget(key, size, S_IRUSR | S_IWUSR);`
        - segment_id:
            - success: segment_id =  unique id of shared memory segment
            - error:   segment_id = -1
        - key: some key associated with the shared memory segment
        - size: how much memory to allocate?
        - OTHER FLAGS:
            - IPC_CREAT: create a memory segment with the key `key` if the segment doesn't exist
            - IPC_EXCL: exit with an error if IPC_CREAT flag is specified, but the segment with key `key` already exists
- Accessing a Shared Memory Region: 
    - `shared_memory = (char*)shmat(segment_id, NULL, 0);`
        - segment_id: the segment id to attach to local memory
        - shared_memory: a pointer to the Beginning of the shared memory segment
- ETC FUNCTIONS:
    - Copy String to Buffer/shmat: `strncpy(target, content, size);`
        - target can be buffer (buf) or local shmat (shared_memory)
        - content can be string ("text") if to shared_memory, or local shmat (shared_memory) if to buffer
    - Writing to Shared Memory: `sprintf(shared_memory, "Hello world");`
    - Detaching Shared Memory:            `shmdt(shared_memory);`
    - Deallocating Shared Memory Segment: `shmctl(segment_id, IPC_RMID, ...);`
- *EXAMPLE FUNCTIONALITY:*
    - Processes P1 and P2 need to communicate using Shared Memory. P1 is responsible for allocating the segment:
        - P1 Steps:
            1. Create a shared memory region by invoking `shmget()` with key params of 123 and flag IPC_CREAT
                - OS sees key 123 does not already exist, and sees IPC_CREAT flag, so it allocates memory!
            2. Attach the allocated region by invoking `shmat()` with segment id (returned by `shmget()`) as a parameter
            3. Access shared memory through the Pointer (returned by `shmat()`)
        - P2 Steps: 
            1. Access a shared memory region by invoking `shmget()` with the same key as P1 
            2. Attach the allocated region by invoking `shmat()` with segment id (returned by `shmget()`) as a parameter
            3. Access shared memory through the Pointer (returned by `shmat()`)

**Shared Memory Problems:**
- How can we ensure that both processes know the key of the shared memory segment?
- *SOLUTION:* 
    - both processes call `ftok()` function w/ the same arguments
    - `key_t key = ftok("/bin/ls", 'b')`
        - Generates a key based on the Random Path ("/bin/ls") and a Random Character ('b')
        - Same Path and Character will ALWAYS generate the Same Key
            - make sure processes agree upon the same file path and char before using this!


### IPC Examples: System V Message Queues 
**Sender:**
- **Methods:**
    1. Create Message Queue: `int msqid = msgget(key, S_IRUSR | S_IWUSR, IPC_CREAT);`
        - creates message queue with key 'key'
        - if nonexistent, create it (IPC_CREAT flag)
        - perms are set ( S_IRUSER | S_IWUSR )
        - Returns the `id` of the created queue
            - key is similar to file name, id is similar to file handle (for interacting)
        - NOTE: 
            - we tend to assume that the Sender creates the Queue
    2. Create a Message: `struct msgBuff { long mtype; int someInt; char data[100]; };`
        - all messages are represented by Structs
        - Struct can contain basically anything
        - first element MUST be `long int mtype` to represent message type
    3. Create an Instance: `msgBuff msg;`
        - first element (Long Int mtype) is set to some positive value 
            - receiver checks for this value when checking for messages
    4. Populate an Instance: `msg.mtype = 2;` `msg.SomeInt = 123;`, `strncpy(msg.data, "Hello World" 12);`
        - establish some type of message for receivers to look for (msgtype = #)
        - you populate the fields establisthed when u Create the Message Type 
    5. Place the Message into the Queue: `msgsnd(msqid, &msg, sizeof(msgBuff) - sizeof(long), 0);`
        - msqid: id of the message
        - msg: message being sent
        - sizeof: size of the payload (total message size - size of mtype)
        - 0: misc. flags that you can set or leave as zero 

**Receiver:**
- **Methods:**
    1. Get Message-Queue Handle: `int msqid = msgget(key, S_IRUSR | S_IWUSR);`
        - gets the id of the msg-queue associated with key 'key'
            - established earlier in the sender methods 
        - No need to re-create the queue DO NOT IPC_CREAT 
    2. Store Received Message: `struct msgBuff { long mtype; int someInt; char data[100]; };`
        - use the SAME FORMAT that the sender uses 
    3. Create an Instance: `msgBuff msg;`
    4. Retrieve the Message: `msgrcv(msqid, &msg, sizeof(msgBuff) - sizeof(long), mtype_val, 0);`
        - msqid: id of the message
        - msg: message being sent
        - sizeof: size of the payload (total message size - size of mtype)
        - mtype_val: the value of mtype (must match the val established by Sender)
        - 0: misc. flags that you can set or leave as zero 

**ETC Methods:**
- Deallocating a Message Queue: `msgctl(msqid, IPC_RMID, NULL);`
    - msqid: message queue id
    - IPC_RMID: flag indicating we would like to deallocate
    - NULL: last argument can always be set to NULL when removing msg queues

### IPC Examples: Mach
**Mach:**
    - All Communications are based on **Message Passing:**
        - System Calls are Messages
        - Each Task gets Two Mailboxes (Kernel and Notify)
        - Three SysCalls for Message-Transfer:
            - `msg_send()`, `msg_receive()`, and `msg_rpc()`
        - Mailboxes are NECESSARY for communication
            - created using `port_allocate()`
    - OS developed at Carnegie Mellon

### IPC Examples: Windows XP
**Windows XP:**
- Messages are passed via **Local Procedure Call (LPC)**
- Uses Ports to establish & maintain connections between processes
- Types of Ports:
    - **Connection Ports:** visible to all procedures, used to set up comm. ports
    - **Communication Ports:** used for Actual Communications
    
**Mechanism Operations:**
1. Client opens a **Handle (i.e: interface)** to the server's Connection Port object
2. Client sends a **Connection Request**
3. Server creates two **Private Communication Ports** and hands one to the Client
4. Client and Server use **Corresponding Port Handles** to send messages
    