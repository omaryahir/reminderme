#!/usr/bin/env bash
osascript - $1 $2 $3 <<END
on run argv
	
	set lineacomando to "$ task [command:'list','new','completelast'] [namelist] "
	
	set lista to ""
	set tarea to ""	

	set comando to ""
	set cmdLIST to "list"
	set cmdNEW to "new"
	set cmdALL to "all"
	set cmdCALS to "cals"
	set cmdCOMPLETELAST to "completelast"
	set cmdCOMPLETELASTCAL to "completelastcal"
	
	set dato to ""	
	set cmdCAL to "cal"

	if (count argv) >= 1 then
		set comando to item 1 of argv
	end if

	if (count argv) >= 2 then 
		set lista to item 2 of argv
	end if 


	set mensaje to " -- Do it Simple ! -- "
	set salida to "" 




	if comando is equal to cmdLIST then
		
		tell application "Reminders"
			
			set ListaaMostrar to lista
			set todoList to name of reminders in list ListaaMostrar whose completed is false
			set salida to "\n"
			if (count of (reminders in list ListaaMostrar whose completed is false)) > 0 then
				repeat with itemNum from 1 to (count of (reminders in list ListaaMostrar whose completed is false))
					set salida to salida & "[" & lista & "] " & (item itemNum of todoList) & "\n"
				end repeat
			else 
				set salida to "No hay pendientes registrados"
			end if

		end tell

	else if comando is equal to cmdNEW then

		tell application "Terminal"
			set input to ""
			display dialog "Nombre de la tarea:" default answer input
 			set tarea to text returned of result
		end tell 

		tell application "Reminders"
			set ListaaMostrar to lista
			tell list ListaaMostrar
				if tarea is not equal to "" then				
					make new reminder with properties {name:tarea}	
					set salida to "\n[" & ListaaMostrar & "] " & tarea
				end if
			end tell 
		end tell

	else if comando is equal to cmdALL then
	
		tell application "Reminders"
			repeat with listNum from 1 to (count of lists)
				set idLista to (list listNum)
				tell idLista
					set salida to salida & "\n[" & name & "]"
				end tell
			end repeat
		end tell

	else if comando is equal to cmdCALS then

		tell application "Calendar" 
			
			repeat with calNum from 1 to (count of calendars)
				set calendario to item calNum of calendars
				tell calendario
					set salida to salida & "[" & name & "] ID: " & id & " \n"
				end tell
			end repeat

		end tell		

	else if comando contains cmdCOMPLETELAST then 

		tell application "Reminders"
			
			set ListaaMostrar to lista		
			set todoList to name of reminders in list ListaaMostrar whose completed is false
			tell list ListaaMostrar
				set recordatorio to last reminder whose completed is false
				copy name of recordatorio to tarea 
	#			set completed of recordatorio to true
			
				set tarea to "[" & ListaaMostrar & "] " & tarea 	
				set salida to "\n" & tarea & " ✔  \n"
			end tell

		end tell

		if comando is equal to cmdCOMPLETELASTCAL then 

			tell application "Calendar"
	
				set idCalendario to (first calendar whose title is lista)
				set idEvento to make new event at end of events of idCalendario
				tell idCalendario 
					set salida to salida & " Calendario:" & name	
				end tell
	
				tell idEvento
					set summary to tarea
					set allday event to true
				end tell
	#
				#set salida to salida & " Sync to calendar"
	#
				#(*
				##Lista de Calendarios
				##set salida to salida & " calendars count: " & (count of calendars)
				#repeat with itemNum from 1 to (count of calendars)
					#set calendario to item itemNum of calendars
					#tell calendario 
						##set salida to salida & name & "\n" #Lista de calendarios
						#if name is ListaaMostrar then
							#make new event with properties {summary:tarea, allday event:true}
							#set salida to salida & " Sync to calendar: " & name & "\n\n"
							#exit repeat
						#end if 
					#end tell
				#end repeat
				#
				##tell application "System Events" to keystroke "R" using command down
#
			end tell

		end if
	
	else 

		set salida to "Use me in this way:\n\n" & lineacomando
	
	end if 
			


	tell application "Terminal"
		set output to salida & "\n" #& "\n\n" & mensaje & "\n"
	end tell 

end
END

# Referencias
# http://www.macosxtips.co.uk/geeklets/productivity/mountain-lion-reminders-list/
# http://apple.stackexchange.com/questions/66981/how-can-i-add-reminders-via-the-command-line
# http://www.mactech.com/articles/mactech/Vol.21/21.11/ScriptingiCal/index.html
