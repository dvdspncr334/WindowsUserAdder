@echo off

net session >nul 2>&1
if %errorLevel% == 0 (
echo Success: Administrative permissions confirmed.
timeout /t 4
cls
goto Menu
) 
if %errorLevel% == 2 (
echo Failure: Current permissions inadequate.
timeout /t 4
cls
goto exit
)


:Menu
cls
echo Where would you like to go. Input a number to select menu option and press enter:
set /p menuhandler=(1)Auto Add User, (2)Manually Add User, (3)Manually Remove User, (4)Manually Add Admin, (5)ListAllUsers (6)Exit:
if %menuhandler%==1 (goto AddUsersFromList)
if %menuhandler%==2 (goto AddUserManually)
if %menuhandler%==3 (goto RemoveUser)
if %menuhandler%==4 (goto ManualAddAdminList)
if %menuhandler%==5 (goto ListAllUsers)
if %menuhandler%==6 (goto Exit)
cls
echo Error: You may have miss typed the command. Please select one of the options.
timeout /t 5
cls
goto Menu


:AddUsersFromList
cls
net user Guest1 /add
cls
goto Menu


:AddUserManually
cls
set /p username=Please input a username:
set /p password=Please input a password for user account:
net user %username% %password% /add
cls
net users
:Isadminerror
set /p isAdmin=Is user going to be admin. Enter y/n:
if %isAdmin%==y (goto AddUserToAdminList)
if %isAdmin%==n (goto NewUser)
cls
echo Error: You may have miss typed the command. Please enter y or n for your command.
timeout /t 5
cls
goto Isadminerror


:RemoveUser
cls
net users
set /p removeusername=Please select user to be removed:
:Removeusererror
set /p checkifuserissure=Are you sure. y/n:
if %checkifuserissure%==y (
net user %removeusername% /del
cls
goto :Removeanoutherusererror
)
if %checkifuserissure%==n (goto Menu)
cls
echo Error: You may have miss typed the command. Please enter y or n for your command.
timeout /t 5
cls
goto Removeusererror
:Removeanoutherusererror
set /p removeanoutheruser=Would you like to remove anouther user. Enter y/n:
if %removeanoutheruser%==y (goto RemoveUser)
if %removeanoutheruser%==n (goto Menu)
cls
echo Error: You may have miss typed the command. Please enter y or n for your command.
timeout /t 5
cls
goto Removeanoutherusererror


:NewUser
cls
:Newusererror
set /p newuser=Would you like to add anouther user. Enter y/n:
if %newuser%==y (goto AddUserManually)
if %newuser%==n (goto Menu)
cls
echo Error: You may have miss typed the command. Please enter y or n for your command.
timeout /t 5
cls
goto Newusererror


:AddUserToAdminList
cls
net localgroup administrators %username% /add
:Addusertoadminlisterror
set /p newadmin=Would you like to a user to the admin List. Enter y/n:
if %newadmin%==y (goto ManualAddAdminList)
if %newadmin%==n (goto Menu)
cls
echo Error: You may have miss typed the command. Please enter y or n for your command.
timeout /t 5
cls
goto Addusertoadminlisterror


:ManualAddAdminList
cls
net users
set /p newadminusername=Please enter username of user to be made admin:
net localgroup administrators %newadminusername% /add
:Addadminerror
set /p addanoutheradmin=Would you like to add anouther admin to list. Enter y/n.
if %addanoutheradmin%==y (goto AddUserToAdminList)
if %addanoutheradmin%==n (goto Menu)
cls
echo Error: You may have miss typed the command. Please enter y or n for your command.
timeout /t 5
cls
goto Addadminerror


:ListAllUsers
net users
net localgroup administrators
pause
goto Menu


:Exit
exit