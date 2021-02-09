; Game Cinematic Timelapse AHI allows you to create a cinematic timelapse in a game.
;
; Copyright (C) 2020-2021 Mingming Cui
; 
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
; 
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
; 
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.

#Persistent
#include Lib\AutoHotInterception.ahk

global AHI := new AutoHotInterception()

keyboardId := AHI.GetKeyboardId(0x1038, 0x2001)
mouseId := AHI.GetMouseId(0x0000, 0x0000)

cm1 := AHI.CreateContextManager(keyboardId)

#if cm1.IsActive	; Start the #if block

Gui, Add, Text,, Press Shift+L to start the programe.`nPress Ctrl+Esc to quit at any time.
Gui, Add, Text, section, X movement (px):
Gui, Add, Text,, Y movement (px):
Gui, Add, Text,, Number of shots:
Gui, Add, Text,, Interval (ms):
Gui, Add, Button, default w60, OK  ; The label ButtonOK (if it exists) will be run when the button is pressed.
Gui, Add, Edit, Number vX w60 ys, 1 ; The ym option starts a new column of controls.
Gui, Add, Edit, Number vY w60, 0
Gui, Add, Edit, Number vN w60, 1000 
Gui, Add, Edit, Number vI w60, 3000
Gui, Add, DropDownList, vXvector choose1 altsubmit w60 ys, Right|Left
Gui, Add, DropDownList, vYvector choose1 altsubmit w60, Down|Up
Gui, Show,, Configuration
return  ; End of auto-execute section. The script is idle until the user does something.

GuiClose:
ExitApp
ButtonOK:
Gui, Submit  ; Save the input from the user to each control's associated variable.
if (Xvector = 2)
{
	vX := X * -1
} else {
	vX := X
}
if (Yvector = 2)
{
	vY := Y * -1
} else {
	vY := Y
}

::aaa::JACKPOT
+a::
MsgBox X is %vX% Y is %vY%
return
+l:: 
	Loop %N% {
	AHI.SendKeyEvent(keyboardId, GetKeySC("F12"), 1)
	Sleep % I - 100
	AHI.SendMouseMove(mouseId, vX, vY)
	Sleep 100
	}
	AHI.SendKeyEvent(keyboardId, GetKeySC("F12"), 0)
	AHI.SendKeyEvent(keyboardId, GetKeySC("Esc"), 1)
	AHI.SendKeyEvent(keyboardId, GetKeySC("Esc"), 0)
	Sleep 10
	MsgBox, Done
	Gui, Show,, Configuration
return
#if			; Close the #if block
^Esc::
	ExitApp
