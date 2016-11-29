## Working with services

```
 Get-Service -Name "HPCA-*" | Sort-Object status
 Get-Service -Name "HPCA-*" | Set-Service -StartupType Disabled
 Get-Service -Name "HPCA-*" | Set-Service -Status Stopped
 ```

## Restarting service
```
Restart-Service  -name
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

[This is a good reference](https://git-scm.com/book/uz/v2/Git-in-Other-Environments-Git-in-Powershell)

## Find files with a name pattern
```
Get-ChildItem -Filter
Get-ChildItem *.txt
Get-ChildItem -Exclude *.txt
Get-ChildItem -Include *.txt -Recurse
```

## Opening another powershell window from powershell
```
start powershell
```
## Finding file, doing something like xargs and concatanation of files
```
Get-Content files.* | Set-Content newfile.fileÎ
cat example*.txt | sc allexamples.txt
Get-ChildItem -include "HPCA802_[0-9][0-9]_update_central_sa.sql" -recurse -name | ForEach-Object {Get-Content $_ | Set-Content finalOutput.sql}
```

Finally after going through rounds, this worked for me.
```
Get-ChildItem -include "HPCA802_[0-9][0-9]_update_central_sa.sql" -recurse  | foreach-object { $name=$_.FullName; get-content $name } | Set-Content concat.sql
```


## Counting lines and all in a file
```
 Get-ChildItem -include "HPCA802_[0-9][0-9]_update_central_sa.sql" -recurse -name | ForEach-Object {Get-Content $_ | Measure-Object -Line}
```
