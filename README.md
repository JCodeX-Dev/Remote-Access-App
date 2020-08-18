Remote System Acces Control Script

The scripts and the program provided in this repository are to be used at your own discretion!!!!


Download this repository as a zip fil
Extract the zip file at you desired location

Change IP address in all the script files to the IP of the Host System

execute Server.java program first by following commands given below
javac Server.java
java Server [port]
#replace [port] with the port no. of your choice


You have manually send the script file RemoteSystemAccess.ps1 to the remote system and execute it.
Before executing the script, change IP address and the port in the script file to the IP and the listening port of the Host System

Remember Server.java should be running first in the host system before running RemoteSystemAccess.ps1 in the remote system

As soon as RemoteSystemAccess.ps1 is executed, it will connect to the Server program running in the host system

Server.java pragram is designed to send initial scripts to remote system and execute it.
If this feature is not needed, comment line no 12

Here, Server.java will send screenshot.ps1 to the remote system and execute it
This screenshot.ps1 will try connect with server program with the given IP and Port number.

ImageServer.java progarm is used to handle screenshot.ps1 request
ImageServer.java along with Server.java should be executed in the beginning in different terminals

execute ImageServer.java program first by following commands given below
javac ImageServer.java
java ImageServer.java [port]
#replace [port] with the port no. of your choice

Also, change IP address and the port in the script file screenshot.ps1 to the IP and the listening port of the Host System

This screenshot.ps1 will take screenshot of the remote system every 10 second by imitating [prt sc] key press,
and will send Image to host system running ImageServer.java

ImageServer.java will receive this file and save it to receivedFile directory with current system time as file name.

Custom are created in Server.java file
custom #1: send files from host to remote system
=>  $sc FileNametobeSaved.ext FiletobeSend.ext

custom #2: retreive files from Remote System
=>  $gc FiletobeRetreived.ext
