function ChunkFileB64($chunkLength, $FileName) {

    $fileContent = Get-Content $FileName -Encoding Byte -Raw

    $fileContentEncoded = [System.Convert]::ToBase64String($fileContent)

    $fileLength = $fileContentEncoded.length

    $counter = 1

    for ($x = 0; $x -lt $fileLength; $x += $chunkLength) {
        if ($x + $chunkLength -gt $fileLength) {
            $chunkLength = $fileLength - $x
        }
        write-host '--- ' $counter ' ---'
        write-host $fileContentEncoded.SubString($x, $chunkLength)
        write-host ''
        $counter += 1
    }

}
