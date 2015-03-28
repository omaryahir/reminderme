reminderme
----
With this project you can connect terminal with the Reminders of Mac OSX Mountain Lion and Yosemite.
For installation download reminderme.sh and in terminal apply:
	$ chmod +x reminderme.sh
After that you can use:
	$ ./reminderme.sh [name of list] [command]

NOTA: You don't need API or something.


Commands:

####all

$ ./reminderme.sh all

This will show you all your list in your Reminders App.

####list

$ ./reminderme.sh [name of list] list

This will show you all your reminders in a specific list and note or body contain the query.

####new 

$ ./reminderme.sh [name of list] new "[name of the task]"

This will add new task in the list.

####complete[cal]

$ ./reminderme.sh [name of list] completecal [number of task] [calendar description]

If you use the completecal so the task will be copy in your Calendar.App in the calendar that contain
[calendar description].

####move
	
$ ./reminderme.sh move [origin list] [number of task] [destiny list] [position]

This will move the [number of task] from the [origin list] to [destiny list] in the [position] that you
specified. (PRECAUTION: This command only copy name, body and remind me date fields)

####modify
	
$ ./reminderme.sh [name of list] modify [number of task] "[new text]"

This will modify the text of the task in the list specified.


####calendar

$ ./reminderme.sh calendar new [name of calendar] "[name of the task]"

This command will add in your Calendar.App in the [name of calendar] the task specified in [name of the task].


---

I hope this will help you.
NOTE: Sorry for my English if you have suggestions I will appreciate, thank you.



