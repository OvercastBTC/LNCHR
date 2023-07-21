; Remember to replace this line with the file path or relative path of the Console.ahk class.
#include <console>

OnExit("ExitScript")

console.println("Hello world!")
console.printfln("AHK Version: {1}`nAHK Path: {2}", A_AhkVersion, A_AhkPath)
return

ExitScript()
{
	; Reset console text and background color as to not make things look weird after closing the script.
	console.set_color()
}

