#!/usr/bin/env bash
osascript - title <<END
	on run argv

		set comando to ""
		set dato to ""
		set mensaje to "Tranquilo puedes hacerlo."
		set salida to "" 

		tell application "Terminal"
			# say mensaje # Optional: using voice 
			
			set input to ""	
			set comandos to {"list","new","completelast"}
			choose from list comandos
			if the result is not false then
				set comando to item 1 of the result

				if comando is equal to "list" then
					display dialog "Nombre de la lista:" default answer input
					set dato to text returned of result
				else if comando is equal to "new" then 
					display dialog "Nombre de la tarea:" default answer input
					set dato to text returned of result
				end if

			end if

		end 


		tell application "Reminders"


			if comando is equal to "list" then 
				set ListaaMostrar to dato
				set todoList to name of reminders in list ListaaMostrar whose completed is false
				set salida to "\n" & dato & "\n\n"
				if (count of (reminders in list ListaaMostrar whose completed is false)) > 0 then
					repeat with itemNum from 1 to (count of (reminders in list ListaaMostrar whose completed is false))
						set salida to salida & "- " & (item itemNum of todoList) & "\n"
					end repeat
				else 
					set salida to "No hay pendientes registrados"
				end

			end if

			if comando is equal to "new" then
				make new reminder with properties {name:dato}
				
			end if

			if comando is equal to "completelast" then
				set ListaaMostrar to "Home"
				set todoList to name of reminders in list ListaaMostrar whose completed is false
				tell list ListaaMostrar
					set recordatorio to last reminder whose completed is false
					set nombretarea to ""
					copy name of recordatorio to nombretarea 
					set completed of recordatorio to true
					set salida to "\n[ OK ] " & nombretarea & "\n\n"
				end tell

			end if
				
		end


		tell application "Terminal"
			set output to salida & "     argumento:" & item 1 of argv

		end 


	end
END

# Referencias
# http://www.macosxtips.co.uk/geeklets/productivity/mountain-lion-reminders-list/
# http://apple.stackexchange.com/questions/66981/how-can-i-add-reminders-via-the-command-line
# http://www.mactech.com/articles/mactech/Vol.21/21.11/ScriptingiCal/index.html
