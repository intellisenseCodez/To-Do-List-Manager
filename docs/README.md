# To-Do List Manager (Bash Script) - Project Case Study

## 1. Project Overview

### Background
In today's fast-paced development environment, developers spend significant time in the terminal. While there are numerous GUI-based task management applications, they often require context switching and can disrupt workflow. This project addresses the need for a lightweight, terminal-based task management solution that integrates seamlessly into a developer's command-line workflow.

### Problem Statement

Developers and system administrators working primarily in terminal environments face challenges with:

- Context switching between GUI applications and terminal work

- Need for quick task capture without leaving the terminal

- Requirement for lightweight tools that don't consume system resources

- Desire for scriptable and automatable task management

- Need for persistent task storage that can be version controlled or synced

### Solution
A feature-rich, terminal-based To-Do List Manager built entirely in Bash that provides comprehensive task management capabilities while maintaining the simplicity and efficiency of command-line tools.

## 2. Technical Architecture
### Core Components

```
┌────────────────────────────────────────────┐
│           User Interface Layer             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Menu    │  │   CLI    │  │  Color   │  │
│  │ System   │  │  Parser  │  │ Handler  │  │
│  └──────────┘  └──────────┘  └──────────┘  │
├────────────────────────────────────────────┤
│           Business Logic Layer             │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Task    │  │  Filter  │  │   Sort   │  │
│  │ Manager  │  │  Engine  │  │  Engine  │  │
│  └──────────┘  └──────────┘  └──────────┘  │
├────────────────────────────────────────────┤
│           Data Access Layer                │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  File    │  │  Backup  │  │  Logger  │  │
│  │  Handler │  │  System  │  │  Module  │  │
│  └──────────┘  └──────────┘  └──────────┘  │
└────────────────────────────────────────────┘
```

### Technology Stack
- **Language**: Bash (#!/bin/bash)
- **Core Utilities**: grep, sed, awk, date, printf
- **Storage**: Flat file system (tasks.csv)
- **Logging**: Plain text log file (task_manager.log)
- **Platform**: Linux/Unix-based systems (cross-distro compatible)

## 3. Detailed Feature Analysis

### 3.1 Task Management Features

### Basic CRUD Task Operations

1. **Add Tasks (CREATE)**
    - Interactive prompts for all fields
    - Input validation for dates and priorities
    - Duplicate prevention
    - Auto-assignment of task IDs
    
2. **Display all Tasks (RETRIEVE)**
    - Display complete task list in a formatted table view
    - Show all task details including ID, description, category, priority, due date, and status
    - Present tasks with clear visual indicators for completed/pending status
    - Support pagination for large task lists

3. **Update Task (UPDATE)s**
    - Enable editing of any task field (description, category, priority, due date)
    - Allow partial updates (modify only specified fields)
    - Preserve original task ID and creation date
    - Track last modification timestamp
    - Provide option to reset completion status when editing

5. **Delete Tasks (DELETE)**
    - Single or bulk deletion
    - Confirmation prompts
    - Soft delete option (archive)
    - Permanent removal option

### 3.2 Advanced Features
- **Mark as Complete**
    - Visual task listing with indices
    - Bulk completion option
    - Completion timestamp recording
    - Visual indicators for completed tasks

- **Filtering Capabilities**
    - By Category: Regex-based category matching
    - By Priority: Priority level filtering
    - By Status: Pending vs Completed
    - By Date Range: Due date filtering
    - Combined Filters: Multiple criteria filtering

- **Sorting Options**
    - Due Date: Chronological order
    - Priority: High → Medium → Low
    - Category: Alphabetical grouping
    - Status: Pending first
    - Custom Sort: User-defined sorting

## 4. User Experience Design
### 4.1 Interactive Menu System

```
╔════════════════════════════════════════╗
║           TO-DO TASK MANAGER           ║
╠════════════════════════════════════════╣
║ 1. Add New Task                        ║
║ 2. Mark Task as Complete               ║
║ 3. Delete Task                         ║
║ 4. Filter Tasks                        ║
║    ├─ By Category                      ║
║    ├─ By Priority                      ║
║    └─ By Status                        ║
║ 5. Sort Tasks                          ║
║    ├─ By Due Date                      ║
║    └─ By Priority                      ║
║ 6. List All Tasks                      ║
║ 7. Search Tasks                        ║
║ 8. Statistics & Reports                ║
║ 9. Export Tasks                        ║
║ 0. Exit                                ║
╚════════════════════════════════════════╝
```

## 4.2 Task Display Format
```
┌─────┬────────────────────┬──────────┬──────────┬────────────┬────────┐
│ ID  │ Description        │ Category │ Priority │ Due Date   │ Status │
├─────┼────────────────────┼──────────┼──────────┼────────────┼────────┤
│ 001 │ Review PR #42      │ Work     │ HIGH     │ 2024-01-15 │ ✓      │
│ 002 │ Buy groceries      │ Personal │ MEDIUM   │ 2024-01-16 │ ☐      │
│ 003 │ Study Bash         │ Study    │ LOW      │ 2024-01-20 │ ☐      │
└─────┴────────────────────┴──────────┴──────────┴────────────┴────────┘
```

## 5. Data Management
### 5.1 Storage Format (tasks.csv)

```
ID,Description,Category,Priority,DueDate,Status,CreatedAt,UpdatedAt,CompletedAt
001,Review PR #42,Work,HIGH,2024-01-15,COMPLETED,2024-01-10 09:00,2024-01-15 14:30,2024-01-15 14:30
002,Buy groceries,Personal,MEDIUM,2024-01-16,PENDING,2024-01-10 09:05,2024-01-12 10:15,
003,Study Bash,Study,LOW,2024-01-20,PENDING,2024-01-10 09:10,,
```

## 5.2 Logging Format (task_manager.log)
```
[2024-01-10 09:00:15] ACTION: Task added - ID:001, Desc: Review PR #42
[2024-01-10 09:05:22] ACTION: Task added - ID:002, Desc: Buy groceries
[2024-01-10 09:10:10] ACTION: Task added - ID:003, Desc: Study Bash
[2024-01-12 10:15:30] ACTION: Task updated - ID:002, Field: Priority (LOW→MEDIUM)
[2024-01-15 14:30:45] ACTION: Task completed - ID:001
[2024-01-15 14:31:10] ERROR: Invalid date format provided
[2024-01-15 14:31:15] WARNING: Attempted to delete non-existent task
```

## 6. Error Handling Strategy
### 6.1 Input Validation
```bash
validate_date() {
    if [[ ! $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ && date -d "$1" ]]; then
        return 1
    fi
    
    date -d "$1" >/dev/null 2>&1
    return $?
}

validate_priority() {
    [[ "$1" =~ ^(HIGH|MEDIUM|LOW)$ ]]
}
```

### 6.2 Path Validation
```bash
validate_path(){
    if [[ -e "$1" ]]; then
        return 0 # path exists
    else
        return 1 # path does not exists
    fi
}
```

### 6.2 Error Categories
- **Fatal Errors**: Exit application (file permission issues)
- **Non-fatal Errors**: Show error, return to menu
- **Warnings**: Yellow text, continue operation
- **Info Messages**: Green text for success

## 7. Performance Considerations
### 7.1 Optimization Techniques
- **Lazy Loading**: Read file only when needed
- **Caching**: Store parsed data in arrays
- **Batch Operations**: Minimize file I/O
- **Indexing**: Maintain task indices for quick access

### 7.2 Scalability
- Handles up to 10,000 tasks efficiently
- File size < 10MB optimal
- Linear search O(n) acceptable for typical use
- Optional pagination for large datasets

## 8. Security Considerations
### 8.1 File Permissions
```bash
# Set appropriate permissions
chmod 600 tasks.txt  # Read/write for owner only
chmod 600 task_manager.log
chmod 755 todo.sh     # Executable for all, write for owner
```

## 9. Deployment and Installation

### 9.1 System Requirements
- Bash version 4.0 or higher
- Core utilities (grep, sed, awk)
- 10MB free disk space
- Read/write permissions in installation directory