/*
	@name console.ahk
	@author TopHatCat
	@version 1.0.0
	@description
		This is a console wrapper tool for the AutoHotkey language.
		This is useful for debugging and getting user input.
	@includes
		./console.colors.ahk
*/

/*
	@class __Console
	@singleton
	@brief Console class for debugging and user input.
	@notes
		This should not be initialized in the by the user.
		It is automatically initialized in this file.

	@methods
		- CONSTRUCTOR
		- DESTRUCTOR
		- set_color(clr)
		- print_clr(items...)
		- print(txt)
		- println(txt)
		- printf(frmt, items...)
		- printfln(frmt, items...)
		- read()
		- getch(keyname)
	@properties
		- title
*/
class __Console
{
	static __is_created := false

	#include %A_LineFile%/../console.colors.ahk

	/*
		@constructor
		@brief Initializes the console class by creating a new console and getting the output and input handles.
		@throws {console.Init} If console instance already exists.
		@notes THIS SHOULD NOT BE CALLED BY ANY USER SCRIPT.
	*/
	__new()
	{
		if (__Console.__is_created)
		{
			throw Exception("Console class cannot be created again", -1)
		}

		DllCall("AllocConsole")

		this.stdout := FileOpen(DllCall("GetStdHandle", "int", -11, "ptr"), "h `n")
		this.stdin  := FileOpen(DllCall("GetStdHandle", "int", -10, "ptr"), "h `n")

		__Console.__is_created := true
		return this
	}

	/*
		@destructor
		@brief Closes the console.
		@notes This is called with garbage collection.
	*/
	__delete()
	{
		this.stdout.Close()
		this.stdin.Close()
		DllCall("FreeConsole")
	}

	/*
		@property
		@name TITLE
		@brief The title of the console.
		@gets Console title.
		@sets Console title.
		@example
			console.title := "My Console"
			console.println("The current console title is:  " . console.title)
			console.println("The original console title was:  " . console.title.original)
	*/
	title[original := false]
	{
		get
		{
			if (original == true)
			{
				VarSetCapacity(Title, 1024, 0)
				DllCall("GetConsoleOriginalTitle", "uint", &Title, "uint", 1024)
				return title
			}
			VarSetCapacity(Title, 1024)
			DllCall("GetConsoleTitle", "str", Title, "uint", 1024)
			return Title
		}
		set
		{
			static suffix := A_IsUnicode ? "W" : "A"
			DllCall("SetConsoleTitle" . suffix, "str", value)
		}
	}

	/*
		@name set_color
		@brief The text color of any newly printed text to the console.
		@param {integer} clr - The new color combo to use.
		@example
			console.set_color(console.Color.FG_RED)
			console.println("This text should be RED on a BLACK background!")

			console.set_color(console.Color.FG_BLACK + console.Color.BG_WHITE)
			console.println("This text should be BLACK on a WHITE background!")
	*/
	set_color(clr := 7)
	{
		return DllCall("SetConsoleTextAttribute", "uint", this.stdout.__Handle, "uchar", clr == NULL ? 7 : clr)
	}

	/*
		@name print_clr
		@brief Prints text to the console with a color object.
		@param {console.clr|string} items... - The text objects to use.
		@example
			console.print_clr(new console.clr("This text should be RED on a BLACK background!", console.Color.FG_RED)
				, new console.clr("This text should be BLACK on a RED background!", console.Color.FG_BLACK, console.Color.BG_RED)))
	*/
	print_clr(items*)
	{
		for index, value in items
		{
			if (value.__Class == "__Console.clr")
			{
				this.set_color(value.color)
				this.print(value.txt)
			}
			else
			{
				this.set_color()
				this.print(value)
			}
		}
		this.set_color()
	}

	/*
		@name print
		@brief Prints text to the console.
		@param {string} txt - The text to print.
		@example
			console.print("Hello World! ")
			console.print("Keep in mind, I will show on the same line!")
	*/
	print(txt)
	{
		static suffix := A_IsUnicode ? "W" : "A"

		if (!StrLen(txt))
		{
			return NULL
		}

		result := DllCall("WriteConsole" . ((A_IsUnicode) ? "W" : "A")
			, "UPtr", this.stdout.__Handle
			, "Str", txt
			, "UInt", StrLen(txt)
			, "UInt*", Written
			, "uint", 0)
		this.stdout.Read(0)
		return result
	}

	/*
		@name println
		@brief Prints text to the console with a newline.
		@param {string} str - The text to print.
		@example
			console.println("Hello World!")
			console.println("Keep in mind, I will show on a new line!")
	*/
	println(txt)
	{
		return this.print(txt . "`n")
	}

	/*
		@name printf
		@brief Prints formatted text to the console.
		@param {string} frmt - The format string.
		@param {string} items... - The items to use.
		@example
			console.printf("Your name is: {1}", "George")
			console.printf(" with an age of: {1}", 25)
	*/
	printf(frmt, items*)
	{
		return this.print(Format(frmt, items*))
	}

	/*
		@name printfln
		@brief Prints formatted text to the console with a newline.
		@param {string} frmt - The format string.
		@param {string} items... - The items to use.
		@example
			console.printfln("Your name is: {1} with an age of: {2}", "George", 25)
	*/
	printfln(frmt, items*)
	{
		return this.println(this.printf(frmt, items*))
	}

	/*
		@name read
		@brief Reads text from the console.
		@param {string} str - My presumsion, this is a prompt. I don't know.
		@returns {string} The text read from the console.
		@throws {console.ReadError} If could not get user input from console.
		@example
			console.print("Enter your name: ")
			name := console.read()
			console.println("Your name is: " . name)
	*/
	read(ByRef str := "")
	{
		static BufferSize := 8192  ; 65536 bytes is the maximum
		static _ptr := (A_PtrSize) ? "uptr" : "uint"
		static suffix := (A_IsUnicode) ? "W" : "A"

		charsRead := 0

		VarSetCapacity(str, BufferSize)
		result := DllCall("ReadConsole" . suffix
				, _ptr, this.stdin.__Handle
				, _ptr, &str
				, "UInt", BufferSize
				, _ptr . "*", charsRead
				, _ptr, 0
				, "UInt")

		if ((result) && (!charsRead))
		{
			return NULL
		}

		if ((!result) || (ErrorLevel))
		{
			throw Exception("ReadConsole" . suffix . "() Error", -1)
		}

		loop % charsRead
		{
			msg .= Chr(NumGet(str, (A_Index - 1) * ((A_IsUnicode) ? 2 : 1), (A_IsUnicode) ? "ushort" : "uchar"))
		}
		str := StrSplit(msg, "`r`n")[1]
		DllCall("FlushConsoleInputBuffer", "uint", this.stdin.__Handle)
		return str
	}

	/*
		@name getch
		@brief Gets a single character input from the console.
		@param {string} BYREF keyname - The character read from the console.
		@returns {integer} The key code.
		@example
			console.print("Press any key to continue...")
			console.getch(result)
			console.println("You pressed: " . result)
	*/
	getch(byref keyname := "")
	{
		DllCall("FlushConsoleInputBuffer", "uint", this.stdin.__Handle)

		If (A_IsUnicode)
		{
			key := DllCall("msvcrt.dll\_getch", "int")
			if ((key == 224) || (key == 0)) ; 'à' in Unicode is 224 or 0xE0
			{
				; ungetch twice is neccessary...
				; we're using a "sort-of bug" at our advantage
				DllCall("msvcrt.dll\_ungetch", "int", key, "int")
				DllCall("msvcrt.dll\_ungetwch", "int", key, "int")

				skey := DllCall("msvcrt.dll\_getch", "int")
			}
		}
		else
		{
			key := DllCall("msvcrt.dll\_getch", "int")
			if ((key == 224) || (key == 0))
			{
				skey:= DllCall("msvcrt.dll\_getch", "int")
			}
		}

		keyname := "Unknown"

		switch (key)
		{
			case 1: keyname := "Ctrl+A"
			case 3: keyname := "Ctrl+C"
			case 4: keyname := "Ctrl+D"
			case 5: keyname := "Ctrl+E"
			case 6: keyname := "Ctrl+F"
			case 7: keyname := "Ctrl+G"
			case 8: keyname := "Backspace"
			case 9: keyname := "Tab"
			case 13: keyname := "Return"
			case 24: keyname := "Ctrl+X"
			case 25: keyname := "Ctrl+Y"
			case 26: keyname := "Ctrl+Z"
			case 27: keyname := "Esc"
			case 32: keyname := "Space"
			case 224:
			{
				switch (skey)
				{
					case 71: keyname := "Home"
					case 72: keyname := "Up"
					case 73: keyname := "PgUp"
					case 75: keyname := "Left"
					case 77: keyname := "Right"
					case 79: keyname := "End"
					case 80: keyname := "Down"
					case 81: keyname := "PgDn"
					case 82: keyname := "Ins"
					case 83: keyname := "Del"
					case 133: keyname := "F11"
					case 134: keyname := "F12"
					case 224:
					{
						keyname := Chr(224)
						return 224
					}
				}
			}
			case 0:
			{
				keyname := "FunctionKey"
				if ((skey >= 59) && (skey <= 68))
				{
					keyname := "F" . (skey - 58)
				}
			}
			default:
			{
				keyname := Chr(key)
			}
		}

		DllCall("FlushConsoleInputBuffer", "uint", this.stdin.__Handle)

		if (key == 224)
		{
			return ("224+" . skey)
		}
		else if (key == 0)
		{
			return ("0+" . skey)
		}
		else
		{
			return key
		}
	}
}

/*
	@global
	@brief The console object.
	@notes This object is used to interact with the console.
	@example
		console.println("Hello World!")
		console.println("Press any key to continue...")
		console.getch(result)
		console.println("You pressed: " . result)
*/
global console := new __Console()
