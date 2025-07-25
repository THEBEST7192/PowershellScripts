Sort

This script allows you to sort files alphabetically by the first letter of filename in folders starting with the first letter of the filename.

Example Usage
Unsorted:
abc.txt
bac.txt
cab.txt
acb.txt
bca.txt
cba.txt

Sorted
A/
    abc.txt
    acb.txt
B/
    bac.txt
    bca.txt
C/
    cab.txt
    cba.txt

If you have any duplicates you will be asked for what to do with them.
(S)kip, Skip moving the file
(O)verwrite, Overwrite the file in the destination folder
(R)ename, Rename the file automatically incrementing the number at the end of the filename

Execute the script by typing this:
.\Sort.ps1