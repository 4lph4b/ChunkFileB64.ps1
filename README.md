# ChunkFileB64.ps1
PowerShell base64 encode a file and break the output into chunks. Used to exfiltrate a file from a target machine onto your own machine using only copy and paste.

### Why?
Sometimes the only way to exfiltrate a file is through copy and paste from a PowerShell session into your own environment. If the file is fairly large, this can cause issues with clipboard and command line maximum size/length limitations in various situations. 

This function first encodes the file into base64 then outputs pieces of the encoded value broken up by the chunk size you specify (number of characters).

Copy and paste each section into a single file, no carriage returns or breaks, and then decode back to the original file. Its important to get the encoding correct when PowerShell generates the base64 since Unicode encoding will cause the process to fail if decoding in anything other than another PowerShell session (going from PowerShell encoding to Linux decoding).

## Usage

Dot source or copy-paste the function into PowerShell:

```
. .\ChunkFileB64.ps1
```

Execute function in PowerShell passing chunk length and filename to be encoded:

```
ChunkFileB64 5000 .\testFile.txt
```

Example Base64 Output (truncated):

```
PS C:\Users\IEUser\Desktop\ChunkFileB64> ChunkFileB64 5000 .\testFile.txt
---  1  ---
TG9yZW0g...cGlidXMg

---  2  ---
aW4uIERv...dW5jIGF0

---  3  ---
IG51bmMg...ZGlhbS4g
```

Copy-paste each line from the PowerShell session into a file on your own machine (truncated example in bash):
```
root@kali:~/# echo -n 'TG9yZW0g...cGlidXMg'  > testFile.txt.b64
root@kali:~/# echo -n 'aW4uIERv...dW5jIGF0' >> testFile.txt.b64
root@kali:~/# echo -n 'IG51bmMg...ZGlhbS4g' >> testFile.txt.b64
```

Decode base64 to recover the file:
```
root@kali:~/# base64 -d testFile.txt.b64 > testFile.txt
```

Check md5 hash of the file in PowerShell:
```
PS C:\Users\IEUser\Desktop\ChunkFileB64> Get-FileHash -Algorithm MD5 .\testFile.txt

Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
MD5             D21EF80870D4D8872CA7B7604B8692CF                                       C:\Users\IEUser\Desktop\ChunkFileB64\testFile.txt
```

Check md5 hash of the file in Bash:
```
root@kali:~/# md5sum testFile.txt
d21ef80870d4d8872ca7b7604b8692cf  testFile.txt
```
