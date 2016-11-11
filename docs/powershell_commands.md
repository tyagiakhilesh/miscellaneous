## Working with services

```
 Get-Service -Name "HPCA-*" | Sort-Object status
 Get-Service -Name "HPCA-*" | Set-Service -StartupType Disabled
 Get-Service -Name "HPCA-*" | Set-Service -Status Stopped
 ```
 
