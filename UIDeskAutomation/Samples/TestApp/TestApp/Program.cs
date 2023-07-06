using System;
using UIDeskAutomationLib;

namespace TestApp
{
	class Program
	{
		public static void Main(string[] args)
		{
			Engine engine = new Engine();
            engine.LogFile = "log.txt";
			
            int procId = engine.StartProcess("TestApplication.exe");
            UIDA_Window mainWindow = engine.GetTopLevelByProcId(procId, "Test Application");
            mainWindow.Highlight();
            
            UIDA_MenuItem fileMenuItem = mainWindow.Menu("").MenuItem("File");
            fileMenuItem.Expand();
            UIDA_MenuItem checkableMI = mainWindow.Menu("").MenuItem("File").MenuItem("Checkable menu item");
            checkableMI.Toggle();
            
            UIDA_Edit edit = mainWindow.TabCtrl("").TabItem("Controls").Edit();
            edit.Text = "new text";
            engine.WriteInLogFile("Edit Text: \"" + edit.Text + "\"");
            
            UIDA_CheckBox checkBox = mainWindow.TabCtrl("").TabItem("Controls").CheckBox("Check this");
            checkBox.IsChecked = true;
			
			UIDA_CheckBox checkBoxThreeState = mainWindow.TabCtrl("").TabItem("Controls").CheckBox("Three state");
            checkBoxThreeState.IsChecked = null; // set indeterminable state
            
            UIDA_RadioButton radio = mainWindow.TabCtrl("").TabItem("Controls").RadioButton("Choice 2");
            radio.Select();
            
            UIDA_ComboBox combo1 = mainWindow.TabCtrl("").TabItem("Controls").ComboBox();
            combo1.Select(2);
            
            UIDA_ComboBox combo2 = mainWindow.TabCtrl("").TabItem("Controls").ComboBoxAt(null, 2);
            combo2.SetText("some text"); // editable combobox
            engine.Sleep(1000);
            combo2.Select("EditableCombo item 3");
            
            UIDA_List list = mainWindow.TabCtrl("").TabItem("Controls").List("");
            list.Select(3);
            list.AddToSelection("List Item 4");
            UIDA_ListItem[] selectedItems = list.SelectedItems;
            engine.WriteInLogFile("");
            engine.WriteInLogFile("List selected items:");
            foreach (UIDA_ListItem selectedItem in selectedItems)
            {
                engine.WriteInLogFile(selectedItem.GetText());
            }
            
            UIDA_Slider slider = mainWindow.TabCtrl("").TabItem("Controls").Slider("");
            engine.WriteInLogFile("Slider old value: " + slider.Value);
            slider.Value = 80;
            engine.WriteInLogFile("Slider new value: " + slider.Value);
            
            UIDA_ScrollBar scrollBar = mainWindow.TabCtrl("").TabItem("Controls").ScrollBar("");
            engine.WriteInLogFile("ScrollBar old value: " + scrollBar.Value);
            scrollBar.Value = 60;
            engine.WriteInLogFile("ScrollBar new value: " + scrollBar.Value);
            
            UIDA_ProgressBar progress = mainWindow.TabCtrl("").TabItem("Controls").ProgressBar("");
            engine.WriteInLogFile("ProgressBar value: " + progress.Value);
            
            UIDA_Button button = mainWindow.TabCtrl("").TabItem("Controls").Button("Press me");
            button.Press();
			
			UIDA_Button toggleButton = mainWindow.TabCtrl("").TabItem("Controls").Button("ToggleButton*");
			toggleButton.Click();
			engine.WriteInLogFile("ToggleButton: " + (toggleButton.IsPressed ? "Pressed" : "Not Pressed"));
            
            UIDA_TabCtrl tabCtrl = mainWindow.TabCtrl("");
            tabCtrl.Select(2); // select "More Controls" tab
            
            UIDA_TreeItem treeItem = mainWindow.TabCtrl("").TabItem("More Controls").Tree("").TreeItem("TreeViewItem1");
            treeItem.Expand();
            
            UIDA_DataGrid grid = mainWindow.TabCtrl("").TabItem("More Controls").DataGrid("");
            grid.Select(3);
            engine.WriteInLogFile("");
            engine.WriteInLogFile("ListView all items:");
            int rowCount = grid.RowCount;
            for (int i = 0; i < rowCount; i++)
            {
                // instead of column names can be used column indexes
                engine.WriteInLogFile(grid[i]["First Name"] + "\t" + grid[i]["Last Name"] + "\t" + grid[i]["Age"]);
            }
            
            UIDA_Calendar calendar = mainWindow.TabCtrl("").TabItem("More Controls").Calendar("");
            calendar.SelectDate(new DateTime(2021, 6, 1)); // select 1st June 2021 in calendar
            
            UIDA_DatePicker datePicker = mainWindow.TabCtrl("").TabItem("More Controls").DatePicker();
            datePicker.SelectedDate = new DateTime(2021, 6, 1); // select 1st June 2021 in DatePicker
		}
	}
}
