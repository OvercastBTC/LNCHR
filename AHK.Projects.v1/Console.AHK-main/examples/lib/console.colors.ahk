/*
	@class clr
	@brief A color class for console's text and background colors.
	@notes
		To set the text's color and background color see the example below.
	@example
		console.set_color(console.clr.FG_RED + console.clr.BG_GREEN)

	@methods
		- CONSTRUCTOR
		- TO STRING
*/
class clr
{
	static FG_BLACK              := 0
	static FG_DARKBLUE           := 1
	static FG_DARKGREEN          := 2
	static FG_DARKCYAN           := 3
	static FG_DARKRED            := 4
	static FG_DARKMAGENTA        := 5
	static FG_DARKYELLOW         := 6
	static FG_GRAY               := 7
	static FG_DARKGRAY           := 8
	static FG_BLUE               := 9
	static FG_GREEN              := 10
	static FG_CYAN               := 11
	static FG_RED                := 12
	static FG_MAGENTA            := 13
	static FG_YELLOW             := 14
	static FG_WHITE              := 15

	static BG_NAVYBLUE           := 16
	static BG_GREEN              := 32
	static BG_TEAL               := 48
	static BG_MAROON             := 64
	static BG_PURPLE             := 80
	static BG_OLIVE              := 96
	static BG_SILVER             := 112
	static BG_GRAY               := 128
	static BG_BLUE               := 144
	static BG_LIME               := 160
	static BG_CYAN               := 176
	static BG_RED                := 192
	static BG_MAGENTA            := 208
	static BG_YELLOW             := 224
	static BG_WHITE              := 240

	static FOREGROUND_BLUE       := 0x0001    ; text color contains blue.
	static FOREGROUND_GREEN      := 0x0002    ; text color contains green.
	static FOREGROUND_RED        := 0x0004    ; text color contains red.
	static FOREGROUND_INTENSITY  := 0x0008    ; text color is intensified.
	static BACKGROUND_BLUE       := 0x0010    ; background color contains blue.
	static BACKGROUND_GREEN      := 0x0020    ; background color contains green.
	static BACKGROUND_RED        := 0x0040    ; background color contains red.
	static BACKGROUND_INTENSITY  := 0x0080    ; background color is intensified.

	/*
		@class Preset
		@brief A few presets for the console's text and background colors.
		@notes
			To use these, simply call the preset's name (see example).
		@example
			console.set_color(console.clr.Preset.WARN)
	*/
	class Preset
	{
		static ERR               := __console.clr.FG_RED    + __console.clr.BG_BLACK
		static WARN              := __console.clr.FG_YELLOW + __console.clr.BG_BLACK
		static INFO              := __console.clr.FG_GREEN  + __console.clr.BG_BLACK
		static DEBUG             := __console.clr.FG_BLUE   + __console.clr.BG_BLACK
		static TRACE             := __console.clr.FG_CYAN   + __console.clr.BG_BLACK
		static PROMPT            := __console.clr.FG_CYAN   + __console.clr.BG_BLACK
		static DETAIL            := __console.clr.FG_WHITE  + __console.clr.BG_BLACK
	}

	/*
		@constructor
		@brief Creates a color object to be used with console.print_clr()
		@param {string} txt - The text to be printed.
		@param {integer|console.clr.FLAG} fgcolor - The foreground color.
		@param {integer|console.clr.FLAG} bgcolor - The background color.
	*/
	__new(txt, fgcolor := 7, bgcolor := 0)
	{
		this.txt := txt
		this.color := fgcolor + bgcolor
		return this
	}

	/*
		@method to_string
		@return {string} The text of the object instance.
	*/
	__str()
	{
		return this.txt
	}
}
