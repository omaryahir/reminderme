task
----

With this project you can connect terminal with the Reminders of Mac OSX Mountain Lion.

For installation download task.sh and in terminal apply:

	$ chmod +x task.sh

After that you can use:

	$ ./task.sh [name of list] [command]


Commands:

####all

	$ ./task.sh all

This will show you all your list in your Reminders App.

####list

	$ ./task.sh [name of list] list

This will show you all your reminders in a specific list and note or body contain the query.

####new 

	$ ./task.sh [name of list] new "[name of the task]"

This will add new task in the list.

####complete[cal]

	$ ./task.sh [name of list] completecal [number of task] [calendar description]

If you use the completecal so the task will be copy in your Calendar.App in the calendar that contain
[calendar description].


####move
	
	$ ./task.sh move [origin list] [number of task] [destiny list] [position]

This will move the [number of task] from the [origin list] to [destiny list] in the [position] that you
specified. (PRECAUTION: This command only copy name, body and remind me date fields)


####modify
	
	$ ./task.sh [name of list] modify [number of task] "[new text]"

This will modify the text of the task in the list specified.



---

I hope this will help you.


NOTE: Sorry for my English if you have suggestions I will appreciate, thank you.
