[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$Prefix,

    [Parameter(Mandatory=$false)]
    [bool]$Staging=$true

)

$counter = 0
$items = Get-ChildItem -Path .
Write-Host "Renaming $($items.Length) file(s)..."
$items | ForEach-Object {
    $counter = $counter + 1
    $name = "$Prefix` -` $($counter.ToString('000#'))$($_.Extension)"
    Write-Host "$_.Name --> $name"
    if (-Not $Staging) {
        Rename-Item -Path $_.Name -NewName $name
    }
}
Write-Host ''
Write-Host "$counter file(s) renamed. Done."


