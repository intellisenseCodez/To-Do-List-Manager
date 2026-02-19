#!/bin/bash

DATA_DIR="data"
TASK_FILE="data/tasks.csv"
TASK_BACKUP_FILE="data/tasks.gz"
LOG_FILE="data/task_manager.log"

# validate if a file or directory exist
function validate_path(){
    if [[ -e "$1"  ]]; then
        return 0 # path exists
    else
        return 1 # path does not exists
    fi
}

# validate piority input
function validate_priority(){
    [[ "$1" =~ ^(HIGH|MEDIUM|LOW)$  ]]
}

# log funtion for INFO, ERROR, SUCCESS
function logger(){
    # [2024-01-15 14:31:10] ERROR: Invalid date format provided
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1 $2." >> $LOG_FILE
}

# log funtion for tasks actions: CREATE, RETRIEVE, UPDATE, DELETE
function task_logger(){
    # [2024-01-10 09:05:22] ACTION: Task added - ID:002, Desc: Buy groceries
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ACTION: Task $1 - Desc: $2" >> $LOG_FILE
}

# validate due_date input: YYYY-MMM-DD
function validate_date(){
    [[ "$1" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$  && $(date -d "$1") ]]
}


# Ensure that the directory and files exist
function intialize_task_file(){
    if ! validate_path "$TASK_FILE"; then
        # Ensure the 'data' directory exists
        if [[ ! -d $DATA_DIR ]]; then
            logger "INFO:" "Initializing Data Directory"
            mkdir -p $DATA_DIR
        fi

        # Ensure the task file exists in the 'data' folder
        if [[ ! -f "$TASK_FILE" ]]; then
            logger "INFO:" "Creating task file.."
            touch "$TASK_FILE"  # Create tasks.csv inside the 'data' folder

            echo "Description,Category,Priority,DueDate,Status" >> "$TASK_FILE"
        fi

        # Ensure the log file exists in the 'data' folder
        if [[ ! -f "$LOG_FILE" ]]; then
            logger "INFO:" "Creating log file.."
            touch "$LOG_FILE"  # Create task_manager.log inside the 'data' folder
        fi
    else
        logger "INFO:" "Path already exist"
    fi
}


# Add new tasks
function add_new_task(){
    read -p "Enter task description: " description
    read -p "Enter task category (e.g Work, Event): " category

    read -p "Enter task priority (Low, Medium, High): " priority
    priority=$(echo "$priority" | tr '[:lower:]' '[:upper:]') # translate user input to capital letter

    read -p "Enter task due date (YYYY-MM-DD): " due_date

    # piority validation
    validate_priority "$priority"

    if ! [[ $? == 0 ]]; then
        logger "ERROR:" "Invalid priority format. Please use Low or Medium or High."
        return
    fi

    # date validation
    validate_date $due_date

    if ! [[ $? == 0 ]]; then
        logger "ERROR:" "Invalid date format entered. Please use a format YYYY-MM-DD."
        return
    fi

    # append new task to a file: ID,,,,,,CreatedAt,UpdatedAt,CompletedAt
    echo "$description,$category,$priority,$due_date,Pending" >> "$TASK_FILE"

    # log a message
    task_logger "CREATE" "$description"

    # confirmation
    echo "Task added successfully!"
}


# Main Menu and User Interaction
function display_main_menu(){
    clear # clear previous terminal commands or output 
    echo ""
    echo "Welcome to using Todo List Manager App"

    echo "╔════════════════════════════════════════╗"
    echo "║           TO-DO TASK MANAGER           ║"
    echo "╠════════════════════════════════════════╣"
    echo "║ 1. Add New Task                        ║"
    echo "║ 2. Mark Task as Complete               ║"
    echo "║ 3. Delete Task                         ║"
    echo "║ 4. Filter Tasks                        ║"
    echo "║    ├─ By Category                      ║"
    echo "║    ├─ By Priority                      ║"
    echo "║    └─ By Status                        ║"
    echo "║ 5. Sort Tasks                          ║"
    echo "║    ├─ By Due Date                      ║"
    echo "║    └─ By Priority                      ║"
    echo "║ 6. List All Tasks                      ║"
    echo "║ 7. Search Tasks                        ║"
    echo "║ 8. Statistics & Reports                ║"
    echo "║ 9. Export Tasks                        ║"
    echo "║ 0. Exit                                ║"
    echo "╚════════════════════════════════════════╝"

    read -p "Please choose an option (0-9): " choice

    case "$choice" in
    1) add_new_task ;;
    2) echo "Mark Task as Complete" ;;
    3) echo "Delete Task" ;;
    4) echo "Filter Tasks" ;;
    5) echo "Sort Tasks" ;;
    6) echo "List All Tasks" ;;
    7) echo "Search Tasks" ;;
    8) echo "Statistics & Reports" ;;
    9) echo "Export Tasks" ;;
    0) exit ;;
    esac
}


# Main function to start running the program
function main(){

    # initialize files and directory
    intialize_task_file     

    # display menu
    display_main_menu

}

# run script
main