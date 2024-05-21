# Project-System-Programming-and-Administration
todo project

### Description
This project is a Bash script for managing tasks. It allows you to create, update, delete, display, and list tasks, as well as search for tasks by title.

### Design Choices

#### Data Structure
Tasks are stored in a text file (`todo.txt`) with the following information separated by pipes (|):
- Title
- Description
- Location
- Due date
- Due time
- Status (pending or completed)

Example line in "todo.txt" : Title|Description|Location|YYYY-MM-DD|HH:MM|pending  

#### Code Organization

The Bash script is organized into several functions:
- display_help: Displays help on using the script.
- display_usage_guide: Displays a detailed guide on using the script.
- create_task: Creates a new task and adds it to `todo.txt`.
- update_task: Updates an existing task.
- delete_task: Deletes an existing task.
- show_task: Displays details of a specific task.
- list_tasks: Lists tasks for a given date.
- search_task: Searches for a task by title.

# Script Functionality
When the script is executed without arguments, it lists tasks for the current date. Otherwise, it takes an argument to specify the action to perform (create, update, delete, show, list, search, help, guide).

### Usage

#### Prerequisites
- Bash (for Windows users, you can use Git Bash )
- A text editor (such as Notepad )


##### How to Run the Program

To run the program, follow these steps:

1. Make the script executable (if necessary):
    chmod +x todo.sh
    
2. Execute the script with the desired action:
    
    ./todo.sh <action>
    

   Replace <action> with one of the following:
   - create: Create a new task.
   - update: Update an existing task.
   - delete: Delete a task.
   - show: Display details of a specific task.
   - list: List tasks for a given date.
   - search: Search for a task by title.
   - help: Display help.
   - guide: Display detailed usage guide.

3. Follow the prompts and instructions provided by the script to perform the desired action.


#### Instructions

1. Clone the repository:
    
    git clone https://github.com/Meryembenaammi/Project-System-Programming-and-Administration.git
    cd Project-System-Programming-and-Administration
    

2. Create a new task:
    
    ./todo.sh create


3. Update an existing task:
    
    ./todo.sh update
    

4. Delete a task:
    
    ./todo.sh delete
   

5.Display details of a specific task:
 
    ./todo.sh show
    

6. List tasks for a given date:
    
    ./todo.sh list
   

7. Search for a task by title:
    
    ./todo.sh search
    

8. Display help:
   
    ./todo.sh help
    

9. Display detailed usage guide:
    
    ./todo.sh guide
   
