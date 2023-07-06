using System;
using System.Diagnostics;
using UIDeskAutomationLib;

namespace AutomateWordpad
{
	class Program
	{
		public static void Main(string[] args)
		{
			Engine engine = new Engine();
			engine.LogFile = "log.txt";
			
            // Automate Wordpad *************
            Process proc = Process.Start("wordpad.exe");
			UIDA_Window wordpadWindow = engine.GetTopLevelByProcId(proc.Id, "Document - WordPad");
			UIDA_Document document = wordpadWindow.Document();
			document.Highlight();
			document.SetText("The lazy dog jumps over the quick brown fox.");
			document.SelectText("The lazy dog");
			
			// press Bold button
			UIDA_Toolbar fontToolbar = wordpadWindow.Pane("UIRibbonDockTop").Pane("Ribbon").Pane("Ribbon").Pane("").Pane("Ribbon").Pane("Lower Ribbon").Custom("").Custom("Home").Toolbar("Font");
			UIDA_Button boldButton = fontToolbar.Button("Bold");
			boldButton.Highlight();
			boldButton.Press();
			
			UIDA_Button italicButton = fontToolbar.Button("Italic");
			italicButton.Highlight();
			italicButton.Press();
			
			UIDA_ComboBox fontType = fontToolbar.ComboBox();
			fontType.Highlight();
			//fontType.SetText("Arial");
			//fontType.SendKeys("{ENTER}");
            
            // press the arrow button for "Change the text color"
            var colorBtn = wordpadWindow.Pane("UIRibbonDockTop").Pane("Ribbon").Pane("Ribbon").Pane("").Pane("Ribbon").Pane("Lower Ribbon").Custom("").Custom("Home").Toolbar("Font").Custom("Text color").Custom("Text color");
            colorBtn.Highlight();
            colorBtn.Invoke();

            // choose red color - might take a while because WordPad has many ui elements
            var red = wordpadWindow.Window("Text color", true).List("Text color").ListItem("Vibrant red", true);
            red.Invoke();
			
            // click in the middle of the document
			document.Click();
            engine.Sleep(1000);
            
            // Close all Notepad windows
            UIDA_Window[] windows = engine.GetTopLevelWindows(null, "Notepad");
            foreach (UIDA_Window wnd in windows)
            {
                wnd.Close();
            }
			
            // Automate Notepad *************
			engine.StartProcess("notepad.exe");
            UIDA_Window notepadWindow = engine.GetTopLevel("Untitled - Notepad");
            document = notepadWindow.Document();
            document.Highlight();
            
            document.SetText("The lazy dog jumps over the quick brown fox.");
            document.SelectAll();
            
            UIDA_MenuItem menuItem = notepadWindow.MenuBar("Application").MenuItem("Format");
            menuItem.Highlight();
            menuItem.Expand();
            
            menuItem = notepadWindow.MenuBar("Application").MenuItem("Format").Menu("Format").MenuItem("Font...");
            menuItem.Highlight();
            menuItem.AccessMenu();
            
            string fontText = notepadWindow.Window("Font").ComboBox().Edit().Text;
            UIDA_ComboBox fontCombo = notepadWindow.Window("Font").ComboBox();
            fontCombo.Highlight();
            fontCombo.Select("Segoe Print"); // Select "Segoe Print" in Font combobox using item name
            
            string fontStyleText = notepadWindow.Window("Font").ComboBoxes()[1].Edit().Text;
            UIDA_ComboBox fontStyleCombo = notepadWindow.Window("Font").ComboBoxes()[1];
            fontStyleCombo.Highlight();
            fontStyleCombo.Select(2); // Select "Bold" in Font style combobox using item index, "Bold" is the second item
            
            // use another way to select an item in a ComboBox
            string fontSizeText = notepadWindow.Window("Font").ComboBoxes()[2].Edit().Text;
            UIDA_ListItem fontSizeItem = notepadWindow.Window("Font").ComboBoxes()[2].List("Size:").ListItem("14");
            fontSizeItem.Highlight();
            fontSizeItem.Select(); // Select "14" in Size combobox
            
            UIDA_Button ok = notepadWindow.Window("Font").Button("OK");
            ok.Highlight();
            ok.Press();

            engine.Sleep(1000);
            
            // restore Notepad font settings
            notepadWindow.MenuBar("Application").MenuItem("Format").Highlight();
			notepadWindow.BringToForeground();
			try
			{
				notepadWindow.MenuBar("Application").MenuItem("Format").Expand();
			}
			catch (Exception ex)
			{
				engine.WriteInLogFile(ex.Message);
			}
			
            notepadWindow.MenuBar("Application").MenuItem("Format").Menu("Format").MenuItem("Font...").AccessMenu();
            notepadWindow.Window("Font").ComboBox().Edit().Highlight();
            notepadWindow.Window("Font").ComboBox().Edit().SendKeys(fontText);
            notepadWindow.Window("Font").ComboBoxes()[1].Edit().Highlight();
            notepadWindow.Window("Font").ComboBoxes()[1].Edit().SetText(fontStyleText);
            notepadWindow.Window("Font").ComboBoxes()[2].Edit().Highlight();
            notepadWindow.Window("Font").ComboBoxes()[2].Edit().SetText(fontSizeText);

            notepadWindow.Window("Font").Button("OK").Highlight();
            notepadWindow.Window("Font").Button("OK").Press();
		}
	}
}