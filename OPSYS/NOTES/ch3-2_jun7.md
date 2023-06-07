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
        - ALL follow the format: `exec(file location, arguments to pass to process);`
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

# PICK BACK UP ON SLIDE 24: ( INTERPROCESS COMMUNICATIONS (IPC) )