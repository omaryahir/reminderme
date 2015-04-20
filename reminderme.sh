#/usr/bin/env bash
#clear
#echo "\n\033[34m $1 $2 $3 $4 $5 \n \033[30;1m····\n \033[33m " #\nTiempo = Vida | Tareas:\n..."
echo "\033[33m  [$1] $2 $3 $4 $5 \033[36m " 
osascript - $1 $2 $3 $4 $5 <<END


# FUNCTIONS ####################################################################

# Formatting dates
on date_time_to_iso(dt)
	set {year:y, month:m, day:d, hours:h, minutes:min, seconds:s} to dt
	set y to text 2 through -1 of ((y + 10000) as text)
	set m to text 2 through -1 of ((m + 100) as text)
	set d to text 2 through -1 of ((d + 100) as text)
	set h to text 2 through -1 of ((h + 100) as text)
	set min to text 2 through -1 of ((min + 100) as text)
	set s to text 2 through -1 of ((s + 100) as text)
	#return y & "-" & m & "-" & d & "T" & h & ":" & min & ":" & s
	#set day_abbr to (text 1 thru 3 of ((weekday of dt) as string)) 
	return  d & "-" & m & "-" & y & " " & h & ":" & min
end date_time_to_iso

# Order Lists
on simple_sort(my_list)
 set the index_list to {}
 set the sorted_list to {}
 repeat (the number of items in my_list) times
 set the low_item to ""
 repeat with i from 1 to (number of items in my_list)
 if i is not in the index_list then
 set this_item to item i of my_list as text
 if the low_item is "" then
 set the low_item to this_item
 set the low_item_index to i
 else if this_item comes before the low_item then
 set the low_item to this_item
 set the low_item_index to i
 end if
 end if
 end repeat
 set the end of sorted_list to the low_item
 set the end of the index_list to the low_item_index
 end repeat
 return the sorted_list
end simple_sort


on flista(nombre_lista,consulta)

	tell application "Reminders"
			
		set salida to ""
		set listReminders to ""

		set mostrar_cuerpo_tarea to false
		if consulta is not equal to "" then
			if consulta contains "n:" then
				set numero_a_mostrar to item 3 of consulta
				set listReminders to reminders in list nombre_lista whose completed is false
				set mostrar_cuerpo_tarea to true
				#set salida to salida & "\nMostrando tarea: # " & numero_a_mostrar & " \n"
			else  
				set listReminders to reminders in list nombre_lista whose completed is false and name contains consulta
			end if
		else	
			set listReminders to reminders in list nombre_lista whose completed is false
		end if

		if (count of listReminders) > 0 then
			repeat with itemNum from 1 to (count of listReminders)


				tell item itemNum of listReminders 

					if name contain "[D]" then
						set salida to salida & " "
					else 
						set salida to salida & "  "
					end if 

					if mostrar_cuerpo_tarea then 
						if ("" & itemNum & "") is equal to numero_a_mostrar then 
							if itemNum is less than 10 then 
								set salida to salida & "0" & itemNum & ": "
							else 
								set salida to salida & itemNum & ": "
							end if 
							set salida to salida & name & "\n"
							if mostrar_cuerpo_tarea and body is not null and body is not "" then 
								set salida to salida & "\nDetalles:\n"
								set salida to salida & "" & body
								set salida to salida & "\n"
							end if
						end if
					else
						if itemNum is less than 10 then
							set salida to salida & "0" & itemNum & " " & name & "\n"
						else 
							set salida to salida & itemNum & " " & name & "\n"
						end if
					end if
				end tell
			end repeat
		else 
			set salida to "No hay pendientes registrados"
		end if

	end tell

	return salida
	#return salida & "\nDo it Simple !  " & current date & "\n")

end flista






# MAIN ##############################################################################

on run argv

	# GLOBALS   #######################################################################
	set salida to ""

	# IF NOT COMMAND THE DEFAULT COMMAND IS LIST ######################################
	if (count of argv) = 1 then 
		set end of argv to "list"
	end if 


	# COMMAND: HELP ###################################################################

	if (item 1 of argv) is equal to "help" then

		set salida to salida & "check README.md file in the folder please... this help is comming"
		
	# COMMAND: ALL ####################################################################

	else if (item 1 of argv) is equal to "all" then

		set nombres_listas to {"", "", "", "", "", "", "", "", "", "", ""}
		set num to 1
		tell application "Reminders"
			repeat with listNum from 1 to (count of lists)
				set nombre_lista to (name of (list listNum))
				set item num of nombres_listas to nombre_lista
				set num to num + 1 
				##set salida to salida & "[" & nombre_lista & "]\n"	
			end repeat
		end tell

		repeat with num_item from 1 to (num-1)
			set nombre_lista to item num_item of nombres_listas 
			set salida to salida & "[" & nombre_lista & "]\n"
			if (item 2 of argv) is equal to "show" then 
				set salida to salida & "\n" & flista(nombre_lista, "") & "\n"
			end if 
		end repeat 


	# COMMAND: LISTSAY #################################################################

	else if (item 2 of argv) is equal to "listsay" then

		set consulta to ""
		if (count of argv) >= 3 then
			set consulta to (item 3 of argv)
		end if

		set salida to flista((item 1 of argv),consulta)
		say salida



	# COMMAND: LIST #################################################################

	else if (item 2 of argv) is equal to "list" then

		set consulta to ""
		if (count of argv) >= 3 then
			set consulta to (item 3 of argv)
		end if
	
		# limpiar pantalla:	
		#tell application "System Events" to tell process "Terminal" to keystroke "k" using command down

		set salida to flista((item 1 of argv),consulta)



	# COMMAND: CALENDAR NEW #########################################################
	# task calendar new calendariohm "Mi evento"
	else if (item 1 of argv) is equal to "calendar" and (item 2 of argv) is equal to "new" then

			tell application "Calendar"

				set nombre_tarea to ""
				repeat with argNum from 4 to (count of argv)
					set nombre_tarea to nombre_tarea & (item argNum of argv) & " "
				end repeat

				set description_calendar to (item 3 of argv)
				set idCalendario to (first calendar whose description is description_calendar)
				set idEvento to make new event at end of events of idCalendario	
				tell idEvento
					set summary to nombre_tarea 
					set allday event to true
				end tell

			end tell	
			set salida to "  added to calendar !"


	# COMMAND: NEW #################################################################

	else if (item 2 of argv) is equal to "new" then
		
		set nombre_lista to (item 1 of argv)

		set nombre_tarea to ""
		repeat with argNum from 3 to (count of argv)
			set nombre_tarea to nombre_tarea & (item argNum of argv) & " "
		end repeat

		tell application "Reminders"
			tell list nombre_lista
				if nombre_tarea is not equal to "" then				
					make new reminder with properties {name:nombre_tarea,body:""}	
					#set salida to "[" & nombre_lista & "] " & nombre_tarea & " << added"
					set salida to "  added !"
				end if
			end tell 
		end tell


	# COMMAND: COMPLETE[CAL] ######################################################

	else if (item 2 of argv) contain "complete" then

		set nombre_lista to (item 1 of argv)	
		set num_recordatorio to (item 3 of argv)
		set nombre_tarea to ""

		tell application "Reminders"
			
			set listReminders to ""
			set listReminders to reminders in list nombre_lista whose completed is false

			if (count of listReminders) > 0 then
				set numero_recordatorio to 0
				repeat with itemNum from 1 to (count of listReminders)
					set numero_recordatorio to (numero_recordatorio + 1)
					if num_recordatorio is equal to (numero_recordatorio as string) then
						tell item itemNum of listReminders 
							set completed to true
							set nombre_tarea to name
							set salida to "[" & nombre_lista & "] " & nombre_tarea & " ✔  " 
							#set salida to "  completed ✔  " 
							exit repeat
						end tell
					end if
				end repeat
			else 
				set salida to "No hay pendientes registrados"
			end if

		end tell

		if (item 2 of argv) is equal to "completecal" then 

			tell application "Calendar"

				set description_calendar to (item 4 of argv)
				set idCalendario to (first calendar whose description is description_calendar)
				set idEvento to make new event at end of events of idCalendario	
				tell idEvento
					set summary to nombre_tarea 
					set allday event to true
				end tell

			end tell	
			set salida to salida & " -- synced to calendar \n "
		end if 	
	

	
	# COMMAND: MOVE ##################################################################
	else if (item 1 of argv) is equal to "move" then
		
		set nombre_lista_origen to (item 2 of argv)
		set numero_tarea_origen to (item 3 of argv)
		set nombre_lista_destino to (item 4 of argv)
		set posicion_tarea_destino to (item 5 of argv)
		set tarea_name to ""
		set tarea_rdate to ""
		set tarea_body to ""


		tell application "Reminders"



			# getting tarea in the origin and removing			
			set listReminders to ""
			set listReminders to reminders in list nombre_lista_origen whose completed is false

			set numero_tarea to 0
			repeat with itemNum from 1 to (count of listReminders)
				set numero_tarea to (numero_tarea+1)
				if ((numero_tarea as string) is equal to (numero_tarea_origen as string)) then  
					
					set tarea_name to name of (item itemNum of listReminders)


					if (remind me date of (item itemNum of listReminders)) is missing value then 
						set tarea_rdate to ""
					else 
						set tarea_rdate to (remind me date of (item itemNum of listReminders))
					end if


					if (body of (item itemNum of listReminders)) is missing value then 
						set tarea_body to ""
					else 
						set tarea_body to (body of (item itemNum of listReminders))
					end if


					exit repeat

				end if
			end repeat
	

			delete every reminder in list nombre_lista_origen whose name is tarea_name


			# adding to destiny list
			set allEvents to reminders in list nombre_lista_destino whose completed is false
			#set newEvents to {}
			set newEvents_name to {}
			set newEvents_rdate to {}
			set newEvents_body to {}
			set posicion_tarea to 0
			set entre to false
			repeat with itemEvent in allEvents

				set posicion_tarea to (posicion_tarea + 1)	

				if ((posicion_tarea as string) is equal to (posicion_tarea_destino as string)) then 
					set entre to true
					set end of newEvents_name to tarea_name
					set end of newEvents_rdate to tarea_rdate
					set end of newEvents_body to tarea_body
				end if
				
				set end of newEvents_name to (name of itemEvent)
				
				if (remind me date of itemEvent) is missing value then 
					set end of newEvents_rdate to ""
				else 
					set end of newEvents_rdate to (remind me date of itemEvent)
				end if

				if (body of itemEvent) is missing value then 
					set end of newEvents_body to ""
				else 
					set end of newEvents_body to (body of itemEvent)
				end if
				
					
			end repeat
			
			if not entre then 
				# In case the position desire is not found so add to end
				set end of newEvents_name to tarea_name
				set end of newEvents_rdate to tarea_rdate
				set end of newEvents_body to tarea_body
			end if 


			delete every reminder in list nombre_lista_destino whose completed is false


			repeat with itemNum from 1 to (count of newEvents_name)

				set sname to (item itemNum of newEvents_name)
				set srdate to (item itemNum of newEvents_rdate) 
				set sbody to (item itemNum of newEvents_body)

				set new_reminder to make new reminder in list nombre_lista_destino 
		
				tell new_reminder	
					set name to sname
					if srdate is not equal to "" then set remind me date to srdate
					if sbody is not equal to "" then set body to sbody
				end tell

				delay 0.8

			end repeat

			#set salida to salida & (tarea_name)
			#set salida to salida & " -- moved to [" & nombre_lista_destino & ":" & posicion_tarea_destino & "]" 

		
		end tell	

		set salida to flista(nombre_lista_destino,"")

	# COMMAND: MODIFY ######################################################

	else if (item 2 of argv) contain "modify" then

		set nombre_lista to (item 1 of argv)	
		set num_recordatorio to (item 3 of argv)
		set new_text to ""
		repeat with argNum from 4 to (count of argv)
			set new_text to new_text & (item argNum of argv) & " "
		end repeat



		tell application "Reminders"
			
			set listReminders to ""
			set listReminders to reminders in list nombre_lista whose completed is false

			if (count of listReminders) > 0 then
				set numero_recordatorio to 0
				repeat with itemNum from 1 to (count of listReminders)
					set numero_recordatorio to (numero_recordatorio + 1)
					if num_recordatorio is equal to (numero_recordatorio as string) then
						tell item itemNum of listReminders
							set name to new_text 
							set salida to name & " < task changed !"
							exit repeat
						end tell
					end if
				end repeat
			else 
				set salida to "No hay pendientes registrados"
			end if

		end tell

	# COMMAND: MARK ######################################################

	else if (item 2 of argv) contain "mark" then

		set nombre_lista to (item 1 of argv)	
		set num_recordatorio to (item 3 of argv)

		tell application "Reminders"
			
			set listReminders to ""
			set listReminders to reminders in list nombre_lista whose completed is false

			if (count of listReminders) > 0 then
				set numero_recordatorio to 0
				repeat with itemNum from 1 to (count of listReminders)
					set numero_recordatorio to (numero_recordatorio + 1)
					tell item itemNum of listReminders					
						if num_recordatorio is equal to (numero_recordatorio as string) then	
							if not name contain "[D]"	then		
								set name to name & "[D]"
							end if
						else if name contain "[D]" then
							set name_temp to name
							set pos_d to (offset of "[D]" in name_temp) - 1
							set name_temp to text 1 thru pos_d of name_temp
							set name to name_temp
						end if
					end tell				
				end repeat
				#set salida to "task marked ! \n"
			else 
				set salida to "No hay pendientes registrados"
			end if

		end tell
		set salida to flista(nombre_lista,"")

	end if

	tell application "Terminal"
		set output to salida
	end tell
	


	(*	
	# Separando la tarea final
	if salida contain "" then	
		
		set pos_last_task to (offset of "" in salida) - 1

		set task to text 1 thru pos_last_task of salida
		set last_task to text pos_last_task thru ((length of salida)-1) of salida

		tell application "Terminal"
			set output to task
			set output to output & last_task & "\n"			
		end tell

		#tell application "Terminal"
				#do shell script " echo \" " & character id 92 & "033[33m hey  \" \n "
				#do shell script " echo \" " & character id 92 & "033[33m hey2  \" \n "
				#set output to output & character id 92 & "033[33m" & last_task & "\n"
				#do shell script " echo \" " & salida & " \""
				#do shell script " echo \"  " & salida & character id 92 & "n " & character id 92 & "033[33m " & last_task & " \""
				#do shell script " echo \"  " & salida & " \" "
				#say "va"
				#do shell script " echo \"  " & character id 92 & "n " & character id 92 & "033[33m " & last_task & character id 92 & "n \""
				#copy output to stdout  
		#end tell

		#do shell script " echo " & quoted form of salida


		#tell application "Terminal"
			#set stdout to stdout & " ok"
			#set textColor to {40000,20000,50000}
		#end tell

		#tell application "Terminal"
			#set output to output & last_task & "\n"
			#do shell script " echo \"  " & character id 92 & "n " & character id 92 & "033[33m " & last_task & character id 92 & "n \""
		#end tell

	else 
			tell application "Terminal"
			set output to salida
		end tell
	end if
	*)	


	#tell application "Terminal"
		#set textColor to {-9787, -9787, -9787}
		#set output to salida 
	#end tell 

 
end
END

# Referencias
# http://www.macosxtips.co.uk/geeklets/productivity/mountain-lion-reminders-list/
# http://apple.stackexchange.com/questions/66981/how-can-i-add-reminders-via-the-command-line
# http://www.mactech.com/articles/mactech/Vol.21/21.11/ScriptingiCal/index.html
# http://www.mactech.com/articles/mactech/Vol.21/21.11/ScriptingiCal/index.html
