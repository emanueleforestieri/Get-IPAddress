# Emanuele Forestieri
# Private IP and Public IP

param
(
    [string]$Adapter=$(throw "Adapter must have a value") #ethernet or wireless
)

if(($Adapter -ne "ethernet") -and ($Adapter -ne "wireless"))
{
    Write-Error -Message "does not exist this adapter"
    exit 1
}

#Get PrivateIP Address
$PrivateIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias $Adapter).IPAddress 
#Get PublicIP Address
$PublicIP = (Invoke-WebRequest -UseBasicParsing http://checkip.dyndns.com).Content.ToString().Split(" ")
$PublicIP = $PublicIP[5].Replace("</body>","").Replace("</html>","")
Write-Host -ForegroundColor Red "Private-IP:" $PrivateIP
Write-Host -NoNewLine -ForegroundColor Green "Public-IP:" $PublicIP
exit 0
