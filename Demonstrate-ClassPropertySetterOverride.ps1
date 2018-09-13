class person{
    [string]$FirstName
    [string]$LastName
    hidden [string]$_FullName
    hidden [bool]$_FullNameManualInput

    person(){
        $this |
            Add-Member -Name 'FullName' -MemberType ScriptProperty {
                If (-not $this._FullNameManualInput){
                    $this._FullName = ($this.FirstName + ' ' + $this.LastName)
                }
                Return $this._FullName
            } -SecondValue {
                param($PropInput)
                If (-not $PropInput){
                    $this._FullNameManualInput = $false
                }
                Else{
                    $this._FullNameManualInput = $true
                }

                $this._FullName = $PropInput
            }
    }
    
    <#
    Each property creates two methods get_propname and set_propname
        as of right now, there is no way to overload these.

    [void]set_FullName(){
        $this.FullName = ($this.FirstName + ' ' + $this.LastName)
    }
    get_FullName(){
        $this.set_FullName()
        $this.FullName
    }
    #>
}

$testVar = [person]::new()
$testVar.FirstName = 'Egon'
$testVar.LastName = 'Spenglar'

Write-Host $testVar.FullName -ForegroundColor Green

$testVar.FullName = 'Fugley Man'
Write-Host $testVar.FullName -ForegroundColor Green

$testVar.FullName = $null
Write-Host $testVar.FullName -ForegroundColor Green
