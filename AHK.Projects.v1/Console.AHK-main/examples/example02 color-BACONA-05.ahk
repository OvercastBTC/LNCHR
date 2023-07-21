; Remember to replace this line with the file path or relative path of the Console.ahk class.
#include <console>

OnExit("ExitScript")

console.println("Hello world!")
console.set_color(console.clr.FG_GREEN)
console.println("This text is green!")
return

ExitScript()
{
	; Reset console text and background color as to not make things look weird after closing the script.
	console.set_color()
}

