param (
    $Path = '.\ADInfo.txt',
    [switch]$NoPause
)
$text = Get-Content -Path $Path
$employes = @()
foreach ($line in $text) {
    $tk = $line -split ':'
    if ($tk) { # to avoid the empty lines
        $name = $tk[0].Trim()
        $val  = $tk[1].Trim()
        if ($name -eq 'DistinguishedName') {
            $record = [PSCustomObject]@{} # new record
        }
        $record | Add-Member -Type NoteProperty -Name $name -Value $val
        if ($name -eq 'DigitalSignature') {
            $record
            if (!$NoPause) { pause }
            $employes += $record
        }
    }
}
write-warning "Found $($employes.count) employes"