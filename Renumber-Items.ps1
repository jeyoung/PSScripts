[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$Prefix,

    [Parameter(Mandatory=$false)]
    [bool]$Staging=$true

)

$counter = 0
$items = Get-ChildItem -Path .
$items | Sort-Object -Property 'LastWriteTime' | ForEach-Object {
    $counter = $counter + 1
    $name = "$Prefix` -` $($counter.ToString('000#'))$($_.Extension)"
    $tempPrefix = [string](New-Guid)
    $tempName = "$tempPrefix`_$name"
    if (-Not $Staging) {
        Rename-Item -Path $_.Name -NewName $tempName
    }
    Write-Verbose "$($_.Name) --> $tempName"
}

$counter = 0
$items = Get-ChildItem -Path .
Write-Host "Renaming $($items.Length) file(s)..."
$items | Sort-Object -Property 'LastWriteTime' | ForEach-Object {
    $counter = $counter + 1
    $name = "$Prefix` -` $($counter.ToString('000#'))$($_.Extension)"
    Write-Verbose "$($_.Name) --> $name"
    if (-Not $Staging) {
        Rename-Item -Path $_.Name -NewName $name
    }
    Write-Host "$($_.Name) --> $name"
}
Write-Host
Write-Host "$counter file(s) renamed. Done."


