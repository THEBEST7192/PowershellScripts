ScriptRunner

This script allows you to view and run any PowerShell scripts in the current folder.

When you execute it, you will be shown a numbered list of all available .ps1 files. You will then have the option to:

Run a script

View information about a script (if a .md file with the same name exists)

Quit

To view information, type:

i <number>

Example:
Typing i 2 will show the contents of scriptname.md that corresponds to script number 2 (scriptname.ps1).

To run a script, simply type the number of the script:

2

To quit, type:

q

Example Usage

Available PowerShell scripts:
1. test.ps1
2. cleanup.ps1

Enter the number of the script to run, 'i' to view info, or 'q' to quit: i 1
--- INFO for test.ps1 ---
<Markdown info from test.md appears here>
--- END OF INFO ---

Enter the number of the script to run, 'i' to view info, or 'q' to quit: 1
Running test.ps1...

Execute the script by typing this:
```
.\PathBackupRestore.ps1
```