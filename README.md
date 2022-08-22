# ChunkFileB64.ps1
PowerShell base64 encode a file and break the output into chunks. Used to exfiltrate a file from a target machine onto your own machine using only copy and paste.

## Usage

Dot source or copy-paste the function into PowerShell:

```
. .\ChunkFileB64.ps1
```

Execute function in PowerShell passing chunk length and filename to be encoded:

```
ChunkFileB64 5000 .\test.txt
```

Example Base64 Output (truncated):

```
PS C:\Users\IEUser\Desktop\ChunkFileB64> ChunkFileB64 1000 .\test.txt
---  1  ---
TG9yZW0g...cGlidXMg

---  2  ---
aW4uIERv...dW5jIGF0

---  3  ---
IG51bmMg...ZGlhbS4g
```

Copy-paste each line from the PowerShell session into a file on your own machine (truncated example in bash):
```
root@kali:~/# echo -n 'TG9yZW0g...cGlidXMg'  > test.txt.b64
root@kali:~/# echo -n 'aW4uIERv...dW5jIGF0' >> test.txt.b64
root@kali:~/# echo -n 'IG51bmMg...ZGlhbS4g' >> test.txt.b64
```

Decode base64 to recover the file:
```
root@kali:~/# base64 -d test.txt.b64 > test.txt
```

Check md5 hash of the file in PowerShell:
```
PS C:\Users\IEUser\Desktop\ChunkFileB64> Get-FileHash -Algorithm MD5 .\test.txt

Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
MD5             D21EF80870D4D8872CA7B7604B8692CF                                       C:\Users\IEUser\Desktop\ChunkFileB64\test.txt
```

Check md5 hash of the file in Bash:
```
root@kali:~/# md5sum test.txt
d21ef80870d4d8872ca7b7604b8692cf  test.txt
```
