#!/usr/bin/env bash
osascript - title <<END
	on run argv

		set ListaaMostrar to "Home"
		set mensaje to " -- Do it simple ! -- " 

		#tell application "Terminal"
			# say mensaje # Optional: using voice 
		#end 

		tell application "Reminders"
			set todoList to name of reminders in list ListaaMostrar whose completed is false
			set output to "\n" & mensaje & "\n\n"
			if (count of (reminders in list ListaaMostrar whose completed is false)) > 0 then
				repeat with itemNum from 1 to (count of (reminders in list ListaaMostrar whose completed is false))
					set output to output & "- " & (item itemNum of todoList) & "\n"
				end repeat
				set output to output & "\nRemember make your miniplan, put in calendar completed event."
			else 
				set output to "No hay pendientes registrados"
			end
		end

	end
END

# Referencias
# http://www.macosxtips.co.uk/geeklets/productivity/mountain-lion-reminders-list/
# http://apple.stackexchange.com/questions/66981/how-can-i-add-reminders-via-the-command-line
