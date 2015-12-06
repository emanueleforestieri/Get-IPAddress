#
#  Copyright 2015 Emanuele Forestieri <forestieriemanuele@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
# 

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
$PublicIP = (Invoke-WebRequest -UseBasicParsing http://checkip.dyndns.com).Content.ToString().Split("")
$PublicIP = $PublicIP[5].Replace("</body>","").Replace("</html>","")
$PrivateIP
$PublicIP
exit 0
