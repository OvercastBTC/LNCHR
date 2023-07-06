; Remember to replace this line with the file path or relative path of the Console.ahk class.
#include <console>

OnExit("ExitScript")

console.println("Hello world!")
console.print("Enter your name: ")
name := console.read()
console.printfln("Your name is: {1}", name)
return

ExitScript()
{
	; Reset console text and background color as to not make things look weird after closing the script.
	console.set_color()
}

