#!/bin/bash
# Function to display help
display_help() {
    echo "Usage: $0 [action]"
    echo "You can perform various actions such as creating, updating, deleting, and listing tasks."
    echo "Actions:"
    echo "  create  - Create a new task"
    echo "  update  - Update an existing task"
    echo "  delete  - Delete a task"
    echo "  show    - Show information about a task"
    echo "  list    - List tasks for a specific date"
    echo "  search  - Search for a task by title"
    echo "  help    - Display this help message"
    echo "If no action is provided, tasks for today will be listed."
}

# Function to display additional usage guide
display_usage_guide() {
    echo " Usage Guide:"
    echo "-----------------------"
    echo "Here's how you can use the script:"
    echo "1. Create a new task:"
    echo "   ./todo.sh create"
    echo "   This option allows you to create a new task by providing details such as title, description, location, due date, and due time."
    echo
    echo "2. Update an existing task:"
    echo "   ./todo.sh update"
    echo "   This option enables you to update an existing task by providing its unique identifier and entering the updated details."
    echo
    echo "3. Delete a task:"
    echo "   ./todo.sh delete"
    echo "   This option lets you delete a task by specifying its unique identifier."
    echo
    echo "4. Show information about a task:"
    echo "   ./todo.sh show"
    echo "   This option displays all information about a specific task by entering its unique identifier."
    echo
    echo "5. List tasks for a specific date:"
    echo "   ./todo.sh list"
    echo "   This option lists all tasks for a given date by providing the date in the format YYYY-MM-DD."
    echo
    echo "6. Search for a task by title:"
    echo "   ./todo.sh search"
    echo "   This option allows you to search for tasks containing a specific title by entering the title."
    echo
    echo "7. Display usage guide:"
    echo "   ./todo.sh help"
    echo "   This option displays the basic usage guide, providing information on how to use the script."
    echo
    echo "8. Display additional guide:"
    echo "   ./todo.sh guide"
    echo "   This option displays an additional guide, providing more detailed information on using specific features of the script."
}

# Function to create a new task
create_task() {
    read -p "Enter task title required: " title
    
    if [ -z "$title" ]; then
        echo "Error: Task title is required."
        return 1
    fi
    read -p "Enter task description (optional): " description
    read -p "Enter task location (optional): " location
    read -p "Enter task due date (YYYY-MM-DD) required: " due_date
    # Validate due date format
    if ! [[ $due_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Error: Invalid due date format. Please use YYYY-MM-DD."
        return 1
    fi
    read -p "Enter task due time (optional): " due_time
    echo "$title|$description|$location|$due_date|$due_time|pending" >> todo.txt
    echo "Task created successfully."
    echo "Task data is stored in todo.txt"
}

# Function to update a task
update_task() {
    read -p "Enter the unique identifier of the task to update: " identifier
    if grep -q "^$identifier" todo.txt; then
        # Prompt the user to enter updated task details
        read -p "Enter updated title (press enter to keep current): " updated_title
        read -p "Enter updated description (press enter to keep current): " updated_description
        read -p "Enter updated location (press enter to keep current): " updated_location
        read -p "Enter updated due date (YYYY-MM-DD) (press enter to keep current): " updated_due_date
        if [ ! -z "$updated_due_date" ] && ! [[ $updated_due_date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            echo "Error: Invalid due date format. Please use YYYY-MM-DD."
            return 1
        fi
        read -p "Enter updated due time (press enter to keep current): " updated_due_time
        updated_task="$identifier|${updated_title:-$(grep "^$identifier" todo.txt | cut -d '|' -f 2)}|${updated_description:-$(grep "^$identifier" todo.txt | cut -d '|' -f 3)}|${updated_location:-$(grep "^$identifier" todo.txt | cut -d '|' -f 4)}|${updated_due_date:-$(grep "^$identifier" todo.txt | cut -d '|' -f 5)}|${updated_due_time:-$(grep "^$identifier" todo.txt | cut -d '|' -f 6)}"
        # Update the task in storage
        sed -i "/^$identifier/c\\$updated_task" todo.txt
        echo "Task updated successfully."
    else
        echo "Error: Task with identifier '$identifier' not found."
        return 1
    fi
}

# Function to delete a task
delete_task() {
    read -p "Enter the unique identifier of the task to delete: " identifier
    if grep -q "^$identifier" todo.txt; then
        sed -i "/^$identifier/d" todo.txt
        echo "Task deleted successfully."
    else
        echo "Error: Task with identifier '$identifier' not found."
        return 1
    fi
}

# Function to show all information about a task
show_task() {
    read -p "Enter the unique identifier of the task to show: " identifier
    if grep -q "^$identifier" todo.txt; then
        grep "^$identifier" todo.txt
    else
        echo "Error: Task with identifier '$identifier' not found."
        return 1
    fi
}

# Function to list tasks of a given day
list_tasks() {
    read -p "Enter the date (YYYY-MM-DD) to list tasks for: " date
    if ! [[ $date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Error: Invalid date format. Please use YYYY-MM-DD."
        return 1
    fi
    echo "Completed tasks for $date:"
    grep -E "^.*\|$date\|" todo.txt | grep "|completed$"
    echo "Uncompleted tasks for $date:"
    grep -E "^.*\|$date\|" todo.txt | grep "|pending$"
}

# Function to search for a task by title
search_task() {
    read -p "Enter the title to search for: " title
    if grep -q "$title" todo.txt; then
        echo "Tasks containing the title '$title':"
        grep "$title" todo.txt
    else
        echo "Error: No tasks found with title '$title'."
        return 1
    fi
}

# Main
if [ $# -eq 0 ]; then
    today=$(date +%Y-%m-%d)
    echo "Tasks for $today:"
    list_tasks "$today"
else
    case "$1" in
        create)
            create_task
            ;;
        update)
            update_task
            ;;
        delete)
            delete_task
            ;;
        show)
            show_task
            ;;
        list)
            list_tasks
            ;;
        search)
            search_task
            ;;
        help)
            display_help
            ;;
        guide)
            display_usage_guide
            ;;
        *)
            echo "Error: Invalid action. Valid actions: create, update, delete, show, list, search, help, guide."
            exit 1
            ;;
    esac
fi

