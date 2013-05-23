#!/usr/bin/env bash
on run argv
	set lista to ""
	set tarea to ""	
	
	set comando to ""
	set cmdLIST to "list"
	set cmdNEW to "new"
	set cmdCOMPLETELAST to "completelast"

	if (count argv) >= 2 then 
		set lista to item 1 of argv
		set comando to item 2 of argv
	end if 
	set mensaje to " -- Do it Simple ! -- "
	set salida to "" 

	tell application "Terminal"
		if comando is equal to cmdNEW then
			set input to ""
			display dialog "Nombre de la tarea:" default answer input
 			set tarea to text returned of result
		end if
	end 


	tell application "Reminders"

		if comando is equal to cmdLIST then 
			set ListaaMostrar to lista
			set todoList to name of reminders in list ListaaMostrar whose completed is false
			set salida to "\n [" & lista & "] \n\n"
			if (count of (reminders in list ListaaMostrar whose completed is false)) > 0 then
				repeat with itemNum from 1 to (count of (reminders in list ListaaMostrar whose completed is false))
					set salida to salida & "- " & (item itemNum of todoList) & "\n"
				end repeat
			else 
				set salida to "No hay pendientes registrados"
			end if

		else if comando is equal to cmdNEW  then
			set ListaaMostrar to lista
			tell list ListaaMostrar
				if tarea is not equal to "" then				
					make new reminder with properties {name:tarea}	
					set salida to "\n[" & ListaaMostrar & "] " & tarea
				end if
			end 
		else if comando is equal to cmdCOMPLETELAST then
			set ListaaMostrar to lista		
			set todoList to name of reminders in list ListaaMostrar whose completed is false
			tell list ListaaMostrar
				set recordatorio to last reminder whose completed is false
				copy name of recordatorio to tarea 
				set completed of recordatorio to true
			
				set tarea to "[" & ListaaMostrar & "] " & tarea 	
				set salida to "\n" & tarea & " ✔  \n"
			end tell

		else 

			set salida to "Use me in this way:\n\n$ task namelist [command:'list','new','completelast'] [ENTER]"

		end if
				
	end

	# I will develop this part later ...
	#tell application "Calendar"
	#	if comando is equal to cmdCOMPLETELAST then 
	#		#set calendario to calendar whose title is ListaaMostrar
	#		#set salida to calendario
	#		tell calendar ListaaMostrar
	#			make new event at end with properties {summary:tarea,allday event:true}
	#		end tell
	#	end if
	#end tell

	tell application "Terminal"
		set output to salida & "\n\n" & mensaje & "\n"
	end 


end

# Referencias
# http://www.macosxtips.co.uk/geeklets/productivity/mountain-lion-reminders-list/
# http://apple.stackexchange.com/questions/66981/how-can-i-add-reminders-via-the-command-line
# http://www.mactech.com/articles/mactech/Vol.21/21.11/ScriptingiCal/index.html
