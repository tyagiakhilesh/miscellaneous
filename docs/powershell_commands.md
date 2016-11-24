## Working with services

```
 Get-Service -Name "HPCA-*" | Sort-Object status
 Get-Service -Name "HPCA-*" | Set-Service -StartupType Disabled
 Get-Service -Name "HPCA-*" | Set-Service -Status Stopped
 ```

## tail equivlant 
```
Get-Content -Path .\Logs\SystemManager.log -Wait
```

## Grep equivalent
```
select-string .\*.* -pattern "evildoer"
Get-ChildItem -recurse | Select-String -pattern "dummy" | group path | select name
```

## redirecting output to a file
```
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path C:\output.txt -append
# do some stuff
Stop-Transcript
```

## Customizing powershell 

(This is a good reference)[https://git-scm.com/book/uz/v2/Git-in-Other-Environments-Git-in-Powershell]
