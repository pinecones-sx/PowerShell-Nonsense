<# Connect-Exchange
    Used to easily connect to Exchange Online.
    Also will verify whether a session is connected already and skip reconnecting if so.
#>

function Connect-Exchange{
    param ([switch]$Disconnect)

    If ( $Disconnect ){
        $EXOSessionConnected = Get-PSSession | Where { ($_.Name -like 'ExchangeOnline*') -and ($_.State -eq 'Opened') }
        return $EXOSessionConnected | Remove-PSSession
    }
    Else{
        $EXOInstalled = Get-InstalledModule ExchangeOnlineManagement
        If (-not $EXOInstalled){
            Install-Module -Name ExchangeOnlineManagement
        }

        $EXOLoaded = Get-Module ExchangeOnlineManagement
        If (-not $EXOLoaded){
            Import-Module -Name ExchangeOnlineManagement
        }

        $EXOSessionConnected = Get-PSSession | Where { ($_.Name -like 'ExchangeOnline*') -and ($_.State -eq 'Opened') }
        If ($EXOSessionConnected) {
            return $EXOSessionConnected
        }
        Else{
            return Connect-ExchangeOnline
        }
    }
}
