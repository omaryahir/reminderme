task
----

This project connect with your Reminders App. With that so you can see your reminders in the terminal.

For installation download task.sh and in terminal apply:

	$ chmod +x task.sh

After that you can use:

	$ ./task.sh [command] [name of list]

The command can be:
- list [name of list]
- lists
- new
- all [word that task contain]
- cals
- completelast
- completelastcal
- complete [word that task contain]
- completecal [word that task contain] 
- modify
- next
- body [word that task contain in field note]
- set [name of list] [number of task] [field] [this information will add to task]

####list

This command show you the tasks of a list.

####lists

With this you can see all your lists.


####new 

This command will make a new task in the list that you specify.

####all

This command will show you all your list that you have in reminders. if you put a text after command all, so will show you the task that contain that words (you can use " for long text with spaces).

####cals

This command will show you all your calendars that you have registered in app Calendar.

####completelast

This command will mark as done the last item of the list that you specified.

####completelastcal

Similar that before command, but, this command besides will add the task in the calendar with the same
DESCRIPTION of the list that you specified.

####complete & completecal

This command will mark as done the task if contains the character that you put for example.

$./task.sh complete "hello world"

The last example will mark as done the
task that coantin -hello world- in the name.

if you use completecal the task will be created in calendar.

####next

This command will show you the next events in the days specified example:

$./task.sh next 10

In this form will show you the next 10 events in all your calendars.

####body

This command will show you the task that contain the word specified in the field note.


####set [name of list] [number of task] [field] [this information will add to task in the field specified]

This command will set a note in the task specified with a number (to know the number use list command to see the number of the list).

When task find the number of task will asign to the [field] specified the information next.

Some field valids are:
- body

More field are comming...


---

I hope this will help you.


NOTE: Sorry for my English if you have suggestions I will appreciate thank you.
